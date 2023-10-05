using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

function chess(r)
    v, g = v_ugol_put_i_schet!(r, Sud, West)
    if mod(v, 2) == mod(g, 2)
        putmarker!(r)
    end
    zmeika!(r, Ost, Nord)
    v_ugol_put_i_schet!(r, Sud, West)
    nmove!(r, Nord, v)
    nmove!(r, Ost, g)
end

function zmeika!(r, tec, osn)
    while !isborder(r, osn)
        stroka!(r, tec)
        if ismarker(r)
            move!(r, osn)
        else
            move!(r, osn)
            putmarker!(r)
        end
        tec = inverse(tec)
    end
    stroka!(r, tec)
end

function stroka!(r, s)
    if ! ismarker(r)
        move!(r, s)
        putmarker!(r)
    else
        f = 1
    end
    f = 0
    while ! isborder(r, s)
        move!(r, s)
        f = stavitli!(r, f)
    end
end

function stavitli!(r, f)
    if f == 1
        putmarker!(r)
        f = 0
    else
        f = 1
    end
    return f
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

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

chess(r)