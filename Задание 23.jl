using HorizonSideRobots
r = Robot("untitled.sit", animate = true) 

function simmetr!(r::Robot, side::HorizonSide, steps::Int64)
    if !isborder(r, side)
        try_move!(r, side)
        steps += 1
        steps += simmetr!(r, side, steps)
        return steps
    else
        thru(r, side, 0)
        for i in 1:steps
            try_move!(r, side)
        end
        return 0
    end
end

function thru(r::Robot, side::HorizonSide, steps::Int)
    ort = ortpov(side)
    if try_move!(r, side)
        for i in 1:(steps)
            move!(r, inverse(ort))
        end
    else
        if isborder(r, side)
            move!(r, ort)
            steps += 1
            x = thru(r, side, steps)
            steps += x
            return steps
        end
    end
    return 0
end

function try_move!(r, side)
    if !isborder(r, side) 
        move!(r, side)
        return true
    else 
        return false
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function ortpov(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

simmetr!(r, Ost, 0)