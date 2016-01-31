include("../lazy_learning.jl")
include("../polynomial.jl")
using LazyLearning
using Polynomial
using Gadfly

# Escher main function is automatically called by the escher_serve function
function main(window)
    # Load HTML dependencies related to the slider
    push!(window.assets, "widgets")

    iterations = Input(5) # The number of iterations to show
    connected_slider = subscribe(slider(0:200, value=5), iterations)

    lift(iterations) do n
        vbox(
            connected_slider,
            draw_plot(n/100)
        )
    end
end

function draw_plot(width)
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
    f_approx2 = a -> lazy_approximate_normalized(x,y,width,a)

    #Plot all of the functions
    plot(layer([f,f_approx,f_approx2],-100,100))
end
