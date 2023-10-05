using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

k = parse(Int, readline())

function chess!(r, n)
    v, g = v_ugol_put_i_schet!(r, Sud, West)
    putmarker!(r)
    kletki!(r, Ost, Nord, n)
    dosten!(r, West)
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
        mnmove!(r, s, n-1)
        while ! isborder(r, s)
            nmove!(r, s, n)
            mnmove!(r, s, n)
        end
    else
        nmove!(r, s, n-1)
        while ! isborder(r, s)
            mnmove!(r, s, n)
            nmove!(r, s, n)
        end
    end
    dosten!(r, inverse(s))
end

function v_ugol_put_i_schet!(r, side1, side2)
    n1, n2 = 0, 0
    while !(isborder(r, side1) & isborder(r, side2))
        if ! isborder(r, side1)
            move!(r, side1)
            n1 += 1
        end    
        if ! isborder(r, side2)
            move!(r, side2) 
            n2 += 1
        end  
    end 
    return n1, n2
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

function mnmove!(r, side, n)
    for i in 1:n
        if !isborder(r, side)
            move!(r, side)
            putmarker!(r)
        end
    end
end

function dosten!(r, s)
    while !isborder(r, s)
        move!(r, s)
    end
end

chess!(r, k)