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
        for i in 1:steps
            move!(r, inverse(side))
        end
        return 0
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

recursion_along!(rob, Sud, 0)