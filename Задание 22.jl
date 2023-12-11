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
                for j in  1:(i-steps-1)
                    move!(r, side)
                end
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

ble(r, Ost, 0, true)