use v5.10;

package CircularShifter;

=pod

Each line of input is stored as an array of words. The shifter really
only needs to determine which word to start at. So, this returns an
index for each line:

	[ 0, 0, 0 ];
	[ 0, 0, 1 ];
	[ 0, 0, 2 ];
	[ 0, 1, 0 ];
	[ 0, 1, 1 ];
	[ 0, 1, 2 ];

That is, these combinations are the cross products of the sets of
indices in each line:

	(0,1,2,...n) X (0,1,2,...n) X ...

So, I'll punt to my Set::CrossProduct module to create this and return
all the tuples at once.

=cut

use Set::CrossProduct;

sub shift {
	my @indices = map { [ 0 .. $_->$#* ] } $_[1]->@*;
	Set::CrossProduct->new( \@indices )->combinations;
	}

1;
