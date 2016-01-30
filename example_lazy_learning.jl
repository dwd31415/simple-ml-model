using Gadfly
include("lazy_learning.jl")
using LazyLearning

data = ([-4,0,4],[-2,5,2])
f1 = x -> lazy_approximate(data[1],data[2],1,x)
f2 = x -> lazy_approximate_normalized(data[1],data[2],1,x)

plt = plot([f1,f2],-15,15)
draw(PDF("lazy_learning_1"*string(now())*".pdf",12inch,8inch),plt)
