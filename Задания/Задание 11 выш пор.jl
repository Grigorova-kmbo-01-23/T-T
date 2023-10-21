using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

function peregorodki!(rob)
    g, v = numsteps_along!(() -> isborder(rob, West), rob, West), numsteps_along!(() -> isborder(rob, Sud), rob, Sud)
    if ! isborder(rob, Nord)
        move!(rob, Nord)
    else
        return 0
    end
    m = zmeika!(rob)
    along!(() -> isborder(rob, West), rob, West)
    along!(() -> isborder(rob, Sud), rob, Sud)
    nmove!(rob, Nord, v)
    nmove!(rob, Ost, g)
    return m
end

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

function zmeika!(rob)
    n = 0
    s = Ost
    while !isborder(rob,Nord)
        x = stenki!(rob, s)
        move!(rob, Nord)
        s = inverse(s)
        n += x
    end
    n += stenki!(rob, s)
    return n
end

function stenki!(rob, s)
    x = 0
    f = 0
    while ! isborder(rob, s)
        if isborder(rob, Sud)
            f = 1
        else
            x += f
            f = 0
        end
        move!(rob, s)
    end
    x += f
    return x
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

function numsteps_along!(st_cond, r, side)
    n = 0
    while !st_cond()
        move!(r, side)
        n += 1
    end
    return n
end

function along!(st_cond, r, side)
    while !st_cond()
        move!(r, side)
    end
end

println(peregorodki!(r))