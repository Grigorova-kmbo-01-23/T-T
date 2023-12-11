using HorizonSideRobots
r = Robot("untitled.sit", animate = true) 

function cherez_stenu(r::Robot, side::HorizonSide, steps::Int)
    ort = ortpov(side)
    if try_move!(r, side)
        nmove!(r, inverse(ort), steps)
    else
        if isborder(r, side)
            move!(r, ort)
            steps += 1
            x = cherez_stenu(r, side, steps)
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

function nmove!(r, side, n)
    for i in 1:n
        try_move!(r, side)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function ortpov(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

cherez_stenu(r, Ost, 0)