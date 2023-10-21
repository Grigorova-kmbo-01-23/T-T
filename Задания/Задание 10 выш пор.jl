using HorizonSideRobots
rob = Robot("untitled.sit", animate=true) 

function chess!(r, n)
    v, g = v_ugol_put_i_schet!(r, Sud, West)
    putmarker!(r)
    kletki!(r, Ost, Nord, n)
    along!(() -> isborder(r, West), r, West)
    nmove!(r, Nord, v)
    nmove!(r, Ost, g)
end

function kletki!(r, osn, tec, n)
    stroka!(r, osn, n)
    while ! isborder(r, osn)
        stroka!(r, tec, n)
        move!(r, osn)
    end
    stroka!(r, tec, n)
end

function stroka!(r, s, n)
    if ismarker(r)
        mnmove!(() -> isborder(r, s), r, s, n-1)
        while ! isborder(r, s)
            nmove!(r, s, n)
            mnmove!(() -> isborder(r, s), r, s, n)
        end
    else
        nmove!(r, s, n-1)
        while ! isborder(r, s)
            mnmove!(() -> isborder(r, s), r, s, n)
            nmove!(r, s, n)
        end
    end
    along!(() -> isborder(r, inverse(s)), r, inverse(s))
end

function v_ugol_put_i_schet!(r, side1, side2)
    n1 = numsteps_along!(() -> isborder(r, side1), r, side1)
    n2 = numsteps_along!(() -> isborder(r, side2), r, side2)
    return n1, n2
end

function numsteps_along!(st_cond, r, side)
    n = 0
    while !st_cond()
        move!(r, side)
        n += 1
    end
    return n
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

function nmove!(r, side, n)
    for i in 1:n
        if !isborder(r, side)
            move!(r, side)
        end
    end
end

function mnmove!(st_cond, r, side, n)
    for i in 1:n
        if !st_cond()
            move!(r, side)
            putmarker!(r)
        end
    end
end

function along!(st_cond, r, side)
    while !st_cond()
        move!(r, side)
    end
end

k = parse(Int, readline())
chess!(rob, k)