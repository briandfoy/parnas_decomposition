package Alphabetizer;

sub order {
	my( $class, $input, $cursors ) = @_;

	my @ordered;

	CURSOR: foreach my $cursor ( $cursors->@* ) {
		my @group;
		LINE: foreach my $line_no ( 0 .. $input->$#* ) {
			my $first_index = $cursor->[$line_no];
			my $first_word = $input->[$line_no][$first_index];
			push @group, [ $line_no, $first_index, $first_word ];
			}

		push @ordered, [ sort { $a->[-1] cmp $b->[-1] } @group ];
		}

	\@ordered;
	}

1;
