package MasterControl;
use v5.10;

=pod

I could get rid of all the temporary variables, but it's easier to
see each step this way. Each step feeds into the next. The MasterControl
basically takes the output from one step and feeds it to the next.
Some of the steps need the output of multiple steps.

In this design, the MasterControl knows nothing about the data
structures or how things are done. It knows the order of operations
and which outputs become inputs for each step.

Suppose something changes in one of the steps. MasterControl doesn't
care. The output of Input still becomes the input for CircularShifter.
If Input changes, then CircularShifter also needs to change. That is,
there is tight coupling between most steps. Small changes in the problem
affect most parts of the system.

=cut

use File::FindLib qw(lib);

use Input;
use CircularShifter;
use Alphabetizer;
use Output;

run() unless caller;

sub run {
	# Step 1
	# Produce an array of arrays. Each line is an array of the words in
	# that line.
	my $input = Input->get_lines();

	# Step 2
	# This returns an array of arrays. Each element is an array of the
	# indices for the first word for each line.
	my $shifted = CircularShifter->shift( $input );

	# Step 3
	# The alphabetizer takes the input data structure and the circular
	# shift data structure, and will re-order all the combinations to
	# put them order. It orders the elements of $shifted.
	my $ordered = Alphabetizer->order( $input, $shifted );

	# Step 4
	# Use the information in $ordered to decide how to display each line.
	Output->show( $input, $ordered );
	}

1;
