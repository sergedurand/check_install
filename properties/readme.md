### Property Format

At the moment PyRAT supports only properties with inputs labeled x0 and outputs labeled y0 (0 or a valid index in input
range / output range). Each inputs lower bounds and upper bounds should be specified first, with one bound per line.

Outputs can be specified on a single line or on seperate lines (forming a conjunction of clauses), with connectors "or"
and "and", and parenthesis. If there are no parenthesis and mix of "and" and "or" the OR will take precedence.

Clauses must be comparisons (<=, <, >=, >) between outputs, or comparisons between outputs and numeric constants.
Comparisons of linear combinations of outputs are planned but not supported at the moment (this includes e.g y0 <= -y1)

See files for examples.
