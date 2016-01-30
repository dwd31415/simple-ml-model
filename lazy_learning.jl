#=
lazy-learning.jl
Copyright 2016 Adrian Dawid
=#

function gen_gaussian_kernel(width)
    return (x -> (1/(sqrt(2*pi)*width)) * exp(-(x^2/(2*width^2))))
end

function lazy_approximate(samples_in,samples_out,kernel_width,x)
    output = 0
    # Generate the gaussain kernel function in advance
    current_kernel = gen_gaussian_kernel(kernel_width)
    # Sum over all the input
    for i = 1:length(samples_in)
        output += samples_out[i] * (current_kernel(samples_in[i] - x)/current_kernel(0))
    end
    return output
end

function lazy_approximate_normalized(samples_in,samples_out,kernel_width,x)
    output = 0
    # Generate the gaussain kernel function in advance
    current_kernel = gen_gaussian_kernel(kernel_width)
    # Store overall-influence for normalization
    overall_influence = 0
    # Sum over all the input
    for i = 1:length(samples_in)
        local_influence = (current_kernel(samples_in[i] - x)/current_kernel(0))
        overall_influence += local_influence
        output += samples_out[i] * local_influence
    end
    return output/overall_influence
end
