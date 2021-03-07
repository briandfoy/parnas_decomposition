use v5.32;


=pod

The CircularShifter only needs to know the number of lines and
the number of words in each line.

This module is similar to LineStorage although it's stores each
combination. Well, it stores indices for each combination, but not
the lines or words themselves.

=cut

package CircularShifter {
	use experimental qw(signatures);

	use Set::CrossProduct;

	sub all_shifts ( $self ) { state $Shifts = []; $Shifts }

	sub setup ( $self, $word_count_in_lines ) {
		push $self->word_counts->@*, $word_count_in_lines->@*;
		my @indices = map { [ 1 .. $_ ] } $word_count_in_lines->@*;
		push $self->all_shifts->@*, Set::CrossProduct->new( \@indices )->combinations;
		}

	sub shift_at ( $self, $shift_n ) {
		if( $shift_n > $self->shift_count() ) {
			die "Out of bounds! Last shift is " .
				shift_count() . " but you asked for $shift_n";
			}
		$self->all_shifts->@[ $shift_n - 1 ]
		}

	sub shift_count ( $self ) { scalar $self->all_shifts->@* }

	sub shift_last_index ( $self ) { $self->shift_count - 1 }

	sub shift_range ( $self ) { [ 0 .. $self->shift_last_index ] }

	sub word_counts ( $self ) { state $Counts = []; $Counts }

	sub word_count_at_line ( $self, $line_n ) {
		$self->word_counts->@[$line_n]
		}

	sub word_index_at_line ( $self, $shift_n, $line_n ) {
		$self->shift_at( $shift_n )->[ $line_n - 1 ]
		}

	sub word_order_for ( $self, $shift_n, $line_n ) {
		my $first_word_index =
			$self->word_index_at_line( $shift_n, $line_n );

		my @word_order = 1 .. $self->word_count_at_line( $line_n );

		my @rotate = splice @word_order, 0, $first_word_index - 1, ();
		push @word_order, @rotate;

		\@word_order;
		}
	}
1;
