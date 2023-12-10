using HorizonSideRobots
rob = Robot("untitled.sit", animate = true) 

function spiral!(r)
    s = Ost
    n = 1
    while !ismarker(r)
        s = ortpov(s)
        stroka!(r, s, n)
        n += 1
    end
end

function stroka!(r, s, n)
    t = 1
    while t < n
        cherez_stenu(r, s, 0)
        t += 1
    end
end

function cherez_stenu(r::Robot, side::HorizonSide, steps::Int)
    ort = ortpov(side)
    t = try_move!(r, side)
    if t == 4
        return 0
    elseif t
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
    if ismarker(r)
        return 4
    end
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

spiral!(rob)