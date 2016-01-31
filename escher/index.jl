include("../lazy_learning.jl")
include("../polynomial.jl")
using LazyLearning
using Polynomial
using Gadfly
using Compose

function draw_plot(params_string,width)
    # Define the parameters for the polynomial
    # params_string = "3 0.5 2.4 -1.2"
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

    input = Signal(Dict())
    s = Escher.sampler()
    form = vbox(
        vskip(3em),
        watch!(s, :params,textinput("1 2", label="Function Paramerters(Whitespace sperated)")),
	hskip(4em),
        hbox("Kernel width(Scale 100): ", watch!(s,:w,slider(10:200))) |> packacross(center),
	hskip(4em),
        vskip(3em),
        trigger!(s,:update, button("Update")))

    map(input) do dict
        vbox(hbox(paper(3,Escher.pad(4em,
        vbox(title(2, "Lazy Learning Function Approximation"),
        intent(s, form) >>> input,
        vskip(2em),
        draw_plot(get(dict,:params,"1 2"),get(dict,:w,100)/100)
    )))) |> Escher.pad(5em))
    end
end
