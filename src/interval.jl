export Interval

struct Interval
    lower_bound::Real
    upper_bound::Real
end

function Base.minimum(Interval)
    return Interval.lower_bound
end

function Base.maximum(Interval)
    return Interval.upper_bound
end