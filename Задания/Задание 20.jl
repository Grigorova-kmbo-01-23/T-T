using HorizonSideRobots
rob = Robot("untitled.sit", animate = true)

function recursion_along!(r::Robot, side::HorizonSide, steps::Int)
    if !isborder(r, side)
        move!(r, side)
        steps += 1
        steps += recursion_along!(r, side, steps)
        return steps
    else 
        putmarker!(r)
        move!(r, inverse(side), steps)
        return 0
    end
end

function HorizonSideRobots.move!(r::Robot, s::HorizonSide, num::Integer)
    for i in 1:num
        move!(r, s)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

recursion_along!(rob, Sud, 0)