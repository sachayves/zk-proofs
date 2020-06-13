/*
Circuit to check that dot product of a public input array l,
and a private input array m, is zero

A note on negative numbers:
in circom, -1 is equivalent to q-1
the logic operators handle negative numbers correcly: -1 < 0 for example.
However, these operators do not work with signals.
One need sot add some comparator circuits if one wants to limit the underflow/overflow.
*/

/*
template IsEqual() {
    signal input in[2];
    signal output out;

    component isz = IsZero();

    in[1] - in[0] ==> isz.in;

    isz.out ==> out;
}
*/

template Multiplier() {
    signal input a;
    signal input b;
    signal output c;
    c <== a*b;
}

template DotProduct(n) {
	 signal input l[n];
	 signal private input m[n];
	 component intermediates[n];
	 signal output out;
	 var sum = 0

	 for(var i=0; i<n; i++) {
	 	 intermediates[i] = Multiplier();
		 intermediates[i].a <== l[i];
		 intermediates[i].b <== m[i];
	 	 sum = sum + intermediates[i].c
	 }
	 out <-- sum;
	 out === 0;
}

component main = DotProduct(4);