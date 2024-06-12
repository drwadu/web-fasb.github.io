% 3 cups
cup(1..3).

%*
 3 possible labels, which encode possible combination of balls
  * `r` refers to a red ball
  * `b` refers to a blue ball
*%
label(b,b). label(r,b). label(r,r).

% each cup contains exactly one possible combination of balls
{ in(X,Y,Z) : label(Y,Z) } = 1 :- cup(X).

% no two cups contain the same balls
:- in(X,Y,Z), in(X',Y,Z), X != X'.

% we found exactly one ball in one cup
{ found(X,Y) : cup(X), label(Y,_) } = 1.

% we found a ball within a cup, if the cup actually contains it
:- not in(X,Y,_), not in(X,_,Y), found(X,Y).
