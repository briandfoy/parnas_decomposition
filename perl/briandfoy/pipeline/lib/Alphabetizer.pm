package Alphabetizer;

=pod

The input is the line input data structure, and the combination of
the first indices for the words in each line. Use that to sort the
lines based on what the first word will be.

=cut

sub order {
	my( $class, $input, $cursors ) = @_;

	my @runs;

	CURSOR: foreach my $cursor ( $cursors->@* ) {
		my @ordered_lines;

		# First, combine the line number, first word index, and
		# first word for each line. Do that for all the lines and
		# package that as an array reference that you add to @runs.
		LINE: foreach my $line_no ( 0 .. $input->$#* ) {
			my $first_index = $cursor->[$line_no];
			my $first_word = $input->[$line_no][$first_index];
			push @ordered_lines, [ $line_no, $first_index, $first_word ];
			}

		push @runs, [ sort { $a->[-1] cmp $b->[-1] } @ordered_lines ];
		}

	\@runs;
	}

1;
