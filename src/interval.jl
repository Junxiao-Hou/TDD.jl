export Interval

struct Interval
    lower_bound::Float64
    upper_bound::Float64
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

function Base.isempty(iv::Interval)
    if iv.lower_bound > iv.upper_bound
        return true
    else
        return false
    end
end

function Base.issubset(iv1::Interval, iv2::Interval)
    if isempty(iv1)
        return true
    elseif (iv1.lower_bound >= iv2.lower_bound) && (iv1.upper_bound <= iv2.upper_bound)
        return true
    else
        return false
    end
end

function Base.intersect(iv1::Interval, iv2::Interval)
    if isempty(iv1) || isempty(iv2)
        return Interval(1,-1)
    elseif iv1.upper_bound >= iv2.lower_bound && iv2.upper_bound >= iv1.lower_bound
        return Interval(max(iv1.lower_bound,iv2.lower_bound),min(iv1.upper_bound,iv2.upper_bound))
    else
        return Interval(1,-1)
    end
end