package Input;

=pod

get_lines() reads the input (command line args or standard input).
Each breaks up each line on whitespace and creates an anonymous array
for that line. It returns an array of arrays.

For example, for this input:

	cat dog
	bird lizard

You get this data structure:

	[
		[ qw(cat dog) ],
		[ qw(bird lizard) ],
	]

The original paper had to jump through a lot of hoops to store this
stuff in memory, know where each line started, and so on. That's all
the usual stuff from C and its predecessors. That part isn't necessary
here. The idea is that this Module produces the thing the next part
will use.

=cut

sub get_lines { [ map{ [ split ] } <> ] }

1;
