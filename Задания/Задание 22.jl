using HorizonSideRobots
r = Robot("untitled.sit", animate = true) 

function backx2(r::Robot, side::HorizonSide, steps::Int64, o::Bool)
    if !isborder(r,side)
        try_move!(r,side)
        steps += 1
        steps += backx2(r, side, steps, o)
        return steps
    else 
        for i in 1:steps*2
            if try_move!(r, inverse(side))
            else
                o = false
                move!(r, side, steps - 1)
                return 0
            end
        end
        return 0
    end
    return otvet
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function try_move!(r, side)
    if !isborder(r, side)     
        move!(r, side)
        return true
    else 
        return false
    end
end

function HorizonSideRobots.move!(r::Robot, s::HorizonSide, num::Integer)
    for i in 1:num
        move!(r, s)
    end
end

backx2(r, Ost, 0, true)