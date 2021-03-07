use v5.32;

=pod

LineStorage know how to store and provide lines and words. Nothing
else gets to mess with the data structure that contains the lines.

Nothing else deals with actual lines or words. They know line
numbers and word numbers, which they can store any way they like. The
MasterControl module can use those numbers to ask LineStorage for the
actual lines.

=cut

package LineStorage {
	use experimental qw(signatures);

	sub all_lines ( $self ) { state $lines = []; $lines }

	sub line_at ( $self, $line_n ) {
		if( $line_n > $self->line_count() ) {
			die "Out of bounds! Last line is " . $self->line_count
				. " but you asked for $line_n";
			}
		$self->all_lines->@[ $line_n ]
		}

	sub line_count ( $self ) { scalar $self->all_lines->@* }

	sub line_last_index ( $self ) { $self->line_count - 1 }

	sub line_range ( $self ) { [ 0 .. $self->line_last_index ] }

	sub shifted_line_at( $self, $line_n, $word_order ) {
		join ' ', map { $self->word_at( $line_n, $_ ) } $word_order->@*;
		}

	sub store_line ( $self, $line ) {
		push $self->all_lines->@*, map { [ split ]  } $line
		}

	sub word_at ( $self, $line_n, $word_n ) {
		my $line = $self->line_at( $line_n );

		if( $word_n > $self->word_count_in( $line_n ) ) {
			die "Out of bounds! Last word is " .
				$self->word_count_in( $line_n )
				. " but you asked for $word_n";
			}

		$self->line_at( $line_n )->[ $word_n - 1 ];
		}

	sub word_count_in ( $self, $line_n ) {
		scalar $self->line_at( $line_n )->@*
		}
	}

1;
