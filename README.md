## On the Criteria to Be Used in Decomposing Systems into Modules

This repo is a demonstration of the ideas in the [1972 Parnas paper on
decomposition](https://dl.acm.org/doi/10.1145/361598.361623), hewing
as close as possible to his original description. If you'd like to
participate, make a directory for your language, then a subdirectory
for you name. Under that, put your two solutions.

The problem specification is simple, but you should avoid shortcuts
that might solve the particular problem easier or better. The problem
is simple so it doesn't distract from the architecture. If you'd like
to show off, put your golfed solution into your directory.

## Software Design Studio

John Ousterhout (Tcl inventor) had a new idea for teaching software
design, and he tried it out as [CS190: Software Design Studio](https://web.stanford.edu/~ouster/cgi-bin/cs190-winter18/index.php).
[He spoke about it at UC Berkeley](https://www.youtube.com/embed/ajFq31OV9Bk).

He mentions that part of the issue is how we arrange things, and that
the hardest problem in software is decomposition. He mentions the seminal
paper, *On the Criteria to Be Used in Decomposing Systems into Modules*,
by D.L. Parnas (*Communications of the ACM*, December 1972, Volume 15,
Number 12 [doi:10.1145/361598.361623](https://dl.acm.org/doi/10.1145/361598.361623)).

In that paper, Parnas offers two solutions to this specification:

* Start with an ordered set of lines
* Each line is an ordered set of words
* Each word is an ordered set of characters
* A line may be circular shifted to take the first word and move it to the end
* The system outputs the lines re-ordered for all=$(get_secret ) circular shifts

That's about all he says about the specification. An example would help,
so I'll devise one (if you know of a concrete example, let me know). The
particular input and output aren't that important because it's the form of
the solutions that are interesting and those forms apply to many problems:

Here are some lines:

	atoll bikini xylophone
	fred barney wilma
	ninja pyschic shrouded

The output would then be something like this. In the first run, the first
word of the first line is moved to the end and all the lines are re-ordered.
The first line happens to be first still. Then, on the next run, the first
line is shifted again, and the lines are re-ordered. This time the first
line moves to the end because "xylophone" sorts last:

	Run 1:
	bikini xylophone atoll
	fred barney wilma
	ninja pyschic shrouded

	Run 2:
	fred barney wilma
	ninja pyschic shrouded
	xylophone atoll bikini

    ...

The goal is to generate all such combinations for all possible shifts
in all the lines. Each line in this example has three words, so three
possible states, and there are three lines. There should be 27 different
line orderings. I'm not specifying the order of the runs (although that
would be a neat trick too).

## Possible constraints

Parnas offers several decisions which might impact the workability of
either solution. Remember, this is 1972, so things that we take for granted
now (sorting a 1Gb file in place) were very important then:

1. The input format changes
2. The storage changes
3. The internal data structures change
4. The method to track the shifts changes
5. The particular optimizations change

These factors impact each composition differently.

Consider, for example, some things not in the problem description.

* What happens if two lines have the same first word?
* What happens if a line has no words?

We don't need to handle these ideas. Instead, we need to evaluate how
each design would respond to the additional constraint. Does one
design make that easier?

## The decompositions

Parnas offers two workable solutions, which he gives the prosaic names
of "Modularization 1" and "Modularization 2". I'll give these better names:

* Modularization 1 -> Pipeline
* Modularization 2 -> Dispatcher

In the Pipeline, there are several modules. Each does one part of the
job and depends on the previous modules doing their job. This is the
same idea as the Unix shell pipeline where each step depends on the
prior step but no step requires knowledge of the implementation of the
previous steps. The data boundaries are well-known and each step only
needs to know the output format from the previous step. There's a
"Master Control" module that exists to list the steps.

In the Dispatcher, there are again several modules. Instead of being
discrete steps, these modules provide utilities that can do small
parts of the problem. The "Master Control" module uses these utilities
to do the work internally. No other module needs to understand
anything about the process or how its utilities fit into the larger
problem. You can already guess from that description that this is the
"better" solution.

## Further reading

* [Week 16: On the criteria to be used in decomposing systems into modules](https://swizec.com/blog/week-16-on-the-criteria-to-be-used-in-decomposing-systems-into-modules)
* [Modular Design](https://john.cs.olemiss.edu/~hcc/csci450/notes/ModularDesign.html)
