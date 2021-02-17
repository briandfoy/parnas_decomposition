package MasterControl;
use v5.10;

=pod

# I could get rid of all the temporary variables, but it's easier to
# see each step this way.

# returns an array of arrays. Each line is an array of the words it
# contains.

=cut

use File::FindLib qw(lib);
use Input;
use CircularShifter;
use Alphabetizer;
use Output;

use Mojo::Util qw(dumper);

run() unless caller;

sub run {
	# Step 1
	# Produce an array of arrays. Each line is an array of the words in
	# that line.
	my $input = Input->get_lines;
	say '$input:', dumper( $input ) if $ENV{DEBUG};

	# Step 2
	# This returns an array of arrays. Each element is an array of the
	# indices for the first word for each line.
	my $shifted = CircularShifter->shift( $input );
	say '$shifted:', dumper( $shifted ) if $ENV{DEBUG};

	# Step 3
	# The alphabetizer takes the input data structure and the circular
	# shift data structure, and will re-order all the combinations to
	# put them order. It orders the elements of $shifted.
	my $ordered = Alphabetizer->order( $input, $shifted );
	say '$ordered:', dumper( $ordered ) if $ENV{DEBUG};

	# Step 4
	# Use the information in $ordered to decide how to display each line.
	Output->show( $input, $ordered );
	}

1;
