#=
Copyright 2016 Adrian Dawid
A simple example that uses Gadfly to plot a polynomial for the range from -10 to 10.
=#
using Gadfly
include("polynomial.jl")
using Polynomial

function main()
    # Encode the Polynomial f(x) = x^2 * 4.2 + x^3 * -2.21 + 3*x + 4
    params = [4,3,4.2,-2.21]
    f = x -> Polynomial.compute_polynomial(params,x)
    plt = plot([f],-10,10)
    draw(PDF("example_plot" * string(now()) * ".pdf",10inch,8inch),plt)
    return 0
end

main()
