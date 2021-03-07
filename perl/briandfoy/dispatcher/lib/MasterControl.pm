use v5.32;

=pod

This is the second decomposition that Parnas described. The components
don't know about each other or how they work. Instead, a Master
Controller coordinates their work and translates the outputs into
inputs, where necessary.

Notice especially that no other module knows anything about the task
and that those modules can easily be used for other tasks. Also, the
Master Control module does not know how the other modules do their work.
Instead, it asks questions to get information it needs to talk to other
modules.

=cut

package MasterControl;
use experimental qw(signatures);

use Input;
use LineStorage;
use CircularShifter;

sub run {
	# Module 1: Read the input. This is trivial.
	# Module 2: Take in the raw input and store it. LineStorage has
	# everything to get particular lines and words.
	while( my $line = Input->get_line ) {
		LineStorage->store_line( $line );
		};

	# This could be in LineStorage too, but this is easy enough
	my @word_count_in_lines =
		map { LineStorage->word_count_in( $_ ) }
		LineStorage->line_range->@*;

	# Module 3: The only thing CircularShifter knows is the number of
	# lines and the count of words in each line.
	CircularShifter->setup( \@word_count_in_lines );

	# Module 4: Alphabetize. This parts cheats slightly, but that's
	# what happens when you have a 1990s language solving 1970s
	# problems. The CircularShifter knows how to order the words
	# even though it doesn't know the particular words.
	foreach my $shift_n ( CircularShifter->shift_range->@* ) {
		state $n = 0;

		my @lines =
			map {
				# This reconstructs lines by figuring out the word order
				# and putting the line back together in that order.
				my $word_order = CircularShifter->word_order_for( $shift_n, $_ );
				LineStorage->shifted_line_at( $_, $word_order );
			}
			LineStorage->line_range->@*;

		# The Alphabetizer. This would be a whole other module, but
		# this is really all it is. We don't do our own character-by-
		# character comparison.
		my @sorted_lines = sort @lines;

		# Module 5: The Output. This would be a whole other module,
		# but this is really all it is. We already have what we need
		# since we have the whole lines
		say "Run " . ++$n . " " . "-" x 50;
		say join "\n", @sorted_lines;
		}
	}

1;
