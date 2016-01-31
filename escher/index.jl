include("../lazy_learning.jl")
include("../polynomial.jl")
using LazyLearning
using Polynomial
using Gadfly
using Compose

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

# Escher main function is automatically called by the escher_serve function
function main(window)
    push!(window.assets, "widgets")

    iterᵗ=Signal(0)

    vbox(hbox(paper(3,Escher.pad(4em,vbox(title(2, "Lazy Learning Function Approximation"),
        vskip(3em),
        hbox("Kernel width(Scale: 100): ", slider(10:200) >>> iterᵗ),
        vskip(3em),
        map(iterᵗ) do iter
            draw_plot(iter/100)
        end
    )))) |> Escher.pad(5em))
end