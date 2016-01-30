module Training
using Calculus
include("polynomial.jl")
using Polynomial


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

function correct_value(x)
    if abs(0 - x) > 2e-4
        return x
    else
        return 0
    end
end

function train_fixed_step(samples_in,samples_out,weights,steps,learning_rate)
    if (size(weights)[1] != length(weights))
        error("FATAL ERROR:weights has the wrong dimensions.")
    end
    local_weights = copy(weights)
    for _=1:steps
        local_weights -= learning_rate * sign(map(correct_value,Calculus.gradient(params -> error_MSE(samples_in,samples_out,params),local_weights)))
    end
    return local_weights
end

end

