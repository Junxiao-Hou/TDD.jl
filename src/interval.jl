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

function Base.show(iv::Interval) # no need for real tests?
    if isempty(iv)
        show("\u2205")
    else
        show("\u301a$(iv.lower_bound), $(iv.upper_bound)\u301b")
    end
end

function Base.print(iv::Interval) # no need for real tests?
    if isempty(iv)
        print("\u2205")
    else
        print("\u301a$(iv.lower_bound), $(iv.upper_bound)\u301b")
    end
end