include("../lazy_learning.jl")
include("../polynomial.jl")
using LazyLearning
using Polynomial
using Gadfly

# Escher main function is automatically called by the escher_serve function
function main(window)
    # Define the parameters for the polynomial
    params_string = "3 0.5 2.4 -1.2"
    params = map(s -> parse(Float64,s),split(params_string))

    # Define some sample data
    scale = 40
    x = randn(100) * scale
    y = map(x -> compute_polynomial(params,x),x)

    # Define a function computing the polynomial
    f = x -> compute_polynomial(params,x)
    # Define the lazy approximation
    f_approx = a -> lazy_approximate(x,y,1,a)
    f_approx2 = a -> lazy_approximate_normalized(x,y,1,a)

    #Plot all of the functions
    plot(layer([f,f_approx,f_approx2],-100,100))
end
