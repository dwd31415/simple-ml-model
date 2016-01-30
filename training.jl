include("polynomial.jl")
using Polynomial

module Training
using Calculus

export train

# Compute the MSE(Mean squared error)
function error_MSE(samples_in,samples_out,params)
    current_error = 0
    for i=1:length(samples_in)
        current_error += 1/length(samples_in) * (samples_out[i] - compute_polynomial(params,samples_in[i]))^2
    end
    return current_error
end

function train(samples_in,samples_out,weights,steps,learning_rate)
    if (size(weights)[1] != length(weights))
        error("FATAL ERROR:weights has the wrong dimensions.")
    end
    local_weights = copy(weights)
    for _=1:steps
        local_weights -= learning_rate * Calculus.gradient(params -> error_MSE(samples_in,samples_out,params),local_weights)
    end
    return local_weights
end

end

