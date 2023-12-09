using HorizonSideRobots
rob = Robot("untitled.sit", animate = true) 

function chess!(r)
    p = v_ugol_put!(r, Nord, Ost)
    v, g = v_ugol_col!(r, Sud, West)
    if mod(v + count(p, "0"), 2) == mod(g + count(p, "1"), 2)
        putmarker!(r)
    end
    stroka!(r, Nord, v)
    stroka!(r, Ost, g)
    stroka!(r, Sud, v)
    zmeika!(r, West, Nord, v, g)
    v_ugol_put!(r, Nord, Ost)
    obratno!(r, Sud, West, p)
end

function zmeika!(r, s, osn, vis, shir)
    t = 1
    while t < vis
       stroka!(r, s, shir)
       s = inverse(s)
       move!(r, osn)
       t += 1
    end
end

function stroka!(r, s, shir)
    t = 1
    if ismarker(r)
        shir -= 1
        move!(r, s)
    end
    stav!(r, t)
    while t < shir
        t += cherez_stenu(r, s, 0, 0)[2]
        stav!(r, t)
    end
    if shir != t
        move!(r, s)
        stav!(r, t)
    end
end

function stav!(r, t)
    if mod(t, 2) == 0
        putmarker!(r)
    end
end

function v_ugol_col!(r, side1, side2)
    n1, n2 = 1, 1
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

function v_ugol_put!(r, side1, side2)
    p = ""
    while !(isborder(r, side1) & isborder(r, side2))
        if ! isborder(r, side1)
            move!(r, side1)
            p *= "0"
        end    
        if ! isborder(r, side2)
            move!(r, side2)
            p *= "1"
        end  
    end
    return p
end

function obratno!(r, side1, side2, p::String)
    p = reverse(p)
    for i in p
        if i == '0'
            move!(r, side1)
        else
            move!(r, side2)
        end
    end
end

function cherez_stenu(r::Robot, side::HorizonSide, steps::Int, steps2::Int)
    ort = ortpov(side)
    if try_move!(r, side)
        steps2 += 1
        if !isborder(r, inverse(ort))
            for i in 1:(steps)
                move!(r, inverse(ort))
            end
            return steps, steps2
        else
            if steps == 0
                return (0, 1) 
            end
            steps, steps2 = cherez_stenu(r, side, steps, steps2)
        end
        return (steps, steps2)
    else
        if isborder(r, side)
            move!(r, ort)
            x, y = cherez_stenu(r, side, steps + 1, steps2)
            steps = x
            steps2 = y
            return (steps, steps2)
        end
    end
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

chess!(rob)