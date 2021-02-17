use v5.10;
package Output;

sub show {
	my( $class, $input, $ordered ) = @_;

	foreach my $order ( $ordered->@* ) {
		state $n = 1;
		say 'Run ', $n++, ' ', '-' x 50;

		# the elements in $order define the order of lines. That's
		# easy. We have the index of the first word, so we use that
		# to order the array indices to get the order we want.
		foreach my $line ( $order->@* ) {
			my $line_i       = $line->[0];
			my $first_word_i = $line->[1];

			# the words are in an array, and we have the indices.
			# now we need to determine the order of all indices.
			# start with the index of the first word and go to the
			# end of the array. Basically, we pivot on the first
			# word index.
			my @j = $first_word_i .. $input->[$line_i]->$#*;
			# Now, go from the start of the array to one before the
			# first word index. If the first word index is 0, there's
			# nothing to do. If the index is greater than zero, we
			# go from 0 to one less. If one less is also zero, the
			# range is just zero.
			if( $first_word_i > 0 ) { push @j, 0 .. $first_word_i - 1 }

			# Now do an array slice with the re-ordered indices.
			say join ' ', $input->[$line_i]->@[ @j ];
			}
		}
	}

1;
