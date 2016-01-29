#=
Polynomial.jl
Copyright 2016 Adrian Dawid
This file contains all the function necessary to compute polynomial function for any given paramter vector and an arbitrary input value x, given that the condition "x is a real number" holds for it.
=#
module Polynomial

export compute_polynomial

function compute_polynomial(parameters,x)
    if size(parameters)[1] != length(parameters)
        error("FATAL ERROR:The parameters vector has the wrong dimensions.")
    end
    output = 0
    for i = 1:length(parameters)
        # Julia array are 1-based, however the first parameter should be linked with x^0.
        output += (x^(i-1)) * parameters[i]
    end
    return output
end

end

