using HorizonSideRobots
rob = Robot("untitled.sit", animate = true)

function shuttle!(st_cond, r)
    n = 1
    s = Ost
    while !st_cond()
        nmove!(st_cond, r, s, n)
        n += 1
        s = inverse(s)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function nmove!(st_cond, r, side, n)
    for i in 1:n
        if !st_cond()
            try_move!(st_cond, r, side)
        end
    end
end

function try_move!(st_cond, r, side)
    if !st_cond()     
        move!(r, side)   
    end
end

shuttle!(() -> !isborder(rob, Nord), rob)