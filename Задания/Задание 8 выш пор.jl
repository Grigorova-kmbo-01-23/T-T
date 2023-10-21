using HorizonSideRobots
rob = Robot("untitled.sit", animate = true)

function spiral!(st_cond, r)
    s = Ost
    n = 1
    while !st_cond()
        for i in 1:2
            nmove!(st_cond, r, s, n)
            s = povorot(s)
        end
        n += 1
    end
end

function povorot(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

function try_move!(st_cond, r, side)
    if !st_cond()     
        move!(r, side)
    end
end

function nmove!(st_cond, r, side, n)
    for i in 1:n
        try_move!(st_cond, r, side)
    end
end

spiral!(() -> ismarker(rob), rob)