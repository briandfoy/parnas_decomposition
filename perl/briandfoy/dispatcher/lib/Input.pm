use v5.32;
use experimental qw(signatures);

package Input;

=pod

Read the lines of input (command line files or standard input)
and return an array ref to the list of lines.

=cut

sub get_line {
	my $line = <>;
	return defined $line ? $line : ();
	}

1;
