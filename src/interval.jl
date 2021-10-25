export Interval

struct Interval
    lower_bound::Real
    upper_bound::Real
end

function Base.minimum(iv::Interval)
    return iv.lower_bound
end

function Base.maximum(iv::Interval)
    return iv.upper_bound
end

function Base.in(num::Real, iv::Interval)
    if num >= iv.lower_bound && num <= iv.upper_bound
        return true
    else
        return false
    end
end