include("lazy_learning.jl")
include("polynomial.jl")
using LazyLearning
using Polynomial
using Gadfly

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
plt = plot(layer([f,f_approx,f_approx2],-100,100))
if !isdir("plots")
    mkdir("plots")
end
draw(PDF("plots/polynomial_approx_" * string(now()) * ".pdf",12inch,9inch),plt)
