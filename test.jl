include("polynomial.jl")
using Polynomial
using Base.Test

# Tests for polynomial.jl
params = [32,3,5.4]
@test compute_polynomial(params,0) == 32
@test compute_polynomial(params,-1) == 34.4
@test compute_polynomial(params,1) == 40.4
@test compute_polynomial(params,100) == 54332.0
@test compute_polynomial(params,-100) == 53732.0

include("lazy_learning.jl")
using LazyLearning

data = ([-4,0,4],[-2,5,2])
f1 = x -> lazy_approximate(data[1],data[2],1,x)
f2 = x -> lazy_approximate_normalized(data[1],data[2],1,x)

@test isapprox(f1(4),2.001677313139487)
@test isapprox(f1(10),3.04599594e-8)
@test isapprox(f1(-10),-3.04599594e-8)
@test isapprox(f1(6),0.2706706426)

@test abs(f2(2) - 3.5) < 2e-5
@test abs(f2(10) - 2) < 2e-5
@test abs(f2(-10) + 2) < 2e-5
@test abs(f2(6) - 2) < 2e-5
