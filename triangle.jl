# Chain ladder using ccall, and traingle as a vector rather than as a matrix

using DataArrays, DataFrames

# Chain Ladder function
function chain_ladder(tri)
	p = size(tri)[1]
	tri = reshape(tri, (p*p, 1))
	fact = zeros(p)
	ccall((:get_factor, "speed-cl"), Void, (Ptr{Float64}, Ptr{Float64}, Int32), pointer(tri), pointer(fact), p)
	ccall((:cl, "speed-cl"), Void, (Ptr{Float64}, Ptr{Float64}, Int32), pointer(tri), pointer(fact), p)
	return reshape(tri, (p, p))
end

function bench(n::Int)
	output = [@elapsed chain_ladder(x) for i = 1:n]
	output = output*1E6 # microseconds
	return DataFrames.DataFrame(min = quantile(output, 0), lq = quantile(output, 0.25), median = quantile(output, 0.5), 
			uq = quantile(output, 0.75), max = quantile(output, 1), neval = n)
end
