using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

function perimetr_obr!(r)
    p, v, g = v_ugol_put_i_schet!(r, Sud, West)
    print(v)
    proecii!(r, Sud, v, West, g)
    v_ugol!(r, Sud, West)
    obratno!(r, Nord, Ost, p)
end

function proecii!(r, side1, n1, side2, n2)
    for i in [side2, inverse(side2)]
        v_ugol!(r, side1, i)
        nmove!(r, inverse(side1), n1)
        putmarker!(r)
    end
    for i in [side1, inverse(side1)]
        v_ugol!(r, side2, i)
        nmove!(r, inverse(side2), n2)
        putmarker!(r)
    end
end

function v_ugol!(r, side1, side2)
    while !(isborder(r, side1) & isborder(r, side2))
        if ! isborder(r, side1)
            move!(r, side1)
        end    
        if ! isborder(r, side2)
            move!(r, side2) 
        end  
    end 
end

function v_ugol_put_i_schet!(r, side1, side2)
    p = ""
    n1, n2 = 0, 0
    while !(isborder(r, side1) & isborder(r, side2))
        if ! isborder(r, side1)
            move!(r, side1)
            p = p * "0" 
            n1 += 1
        end    
        if ! isborder(r, side2)
            move!(r, side2) 
            p = p * "1"
            n2 += 1
        end  
    end 
    return p, n1, n2
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

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

perimetr_obr!(r)