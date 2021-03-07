package LineStorage;

use File::FindLib qw(lib);
use MasterControl qw(store_line);

sub store_line {
	$_[0] =~ s/\A\s*|\s*\z//g;
	push @lines, [ split /\s+/, $_[0] ]
	}

sub words_in_line {
	my( $line ) = @_;
	scalar $lines[ $line ]->@*
	}

sub word_at {
	my( $line, $i ) = @_;

	}

sub compare_words {
	my( $line_i, $i, $line_j, $j ) = @_;

	}

1;
