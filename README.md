# latex-macro-expander

The code for the LaTeX Macro Expander can be found in the "proj1" folder, and it is fairly simple to run. Simply build the C file using the Makefile and then run the built executable with an input .txt file. The code should produce the correct expansion of the macros, of which some examples include:

- \def{B}{Buffalo}
- \expandafter{\B{}}{\undef{B}\def{B}{bison}}

result : bison

- \def{list}{\if{#}{#, \list}{..., omega}}%
- \list{alpha}{beta}{gamma}

result : alpha, beta, gamma, ..., omega

- \def{A}{aardvarl}%
- \expandafter{\def{B}}{{\A{}}}%
- \undef{A}\def{A}{anteater}%
- \B{} = \A{}

result : aardvark = anteater
