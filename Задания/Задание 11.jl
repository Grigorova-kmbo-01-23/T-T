using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

function peregorodki!(rob)
    g, v = k_stene(rob, West), k_stene(rob, Sud)
    if ! isborder(rob, Nord)
        move!(rob, Nord)
    else
        return 0
    end
    m = zmeika(rob)
    k_stene(rob, West)
    k_stene(rob, Sud)
    nmove!(rob, Nord, v)
    nmove!(rob, Ost, g)
    return m
end

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

function zmeika(rob)
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

function k_stene(rob, side)
    n = 0
    while ! isborder(rob, side)
        move!(rob, side)
        n += 1
    end
    return n
end