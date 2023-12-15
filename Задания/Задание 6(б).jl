using HorizonSideRobots
r = Robot("Zadanie5.sit", animate=true) 

function proecii_i_na_start!(robot)
    put, shagov_po_vertikali, shagov_po_gorizontali  = v_ugol_put_i_schet!(r, Sud, West)
    proecii!(robot, Sud, shagov_po_vertikali, West, shagov_po_gorizontali)
    v_ugol!(robot, Sud, West)
    na_start!(robot, Nord, Ost, put)
end

function proecii!(robot, side1, koordinaty_po_side1, side2, koordinaty_po_side2)
    for i in [side2, inverse(side2)]
        v_ugol!(robot, side1, i)
        move!(robot, inverse(side1), koordinaty_po_side1)
        putmarker!(robot)
    end
    for i in [side1, inverse(side1)]
        v_ugol!(robot, side2, i)
        move!(robot, inverse(side2), koordinaty_po_side2)
        putmarker!(robot)
    end
end

function v_ugol!(robot, side1, side2)
    while !v_uglu!(robot, side1, side2)
        if ! isborder(robot, side1)
            move!(robot, side1)
        end    
        if ! isborder(robot, side2)
            move!(robot, side2) 
        end  
    end 
end

function v_ugol_put_i_schet!(robot, side1, side2)
    put = ""
    shagov_po_side1, shagov_po_side2 = 0, 0
    while !v_uglu!(robot, side1, side2)
        if ! isborder(r, side1)
            move!(robot, side1)
            put = put * "0" 
            shagov_po_side1 += 1
        end    
        if ! isborder(robot, side2)
            move!(robot, side2) 
            put = put * "1"
            shagov_po_side2 += 1
        end  
    end 
    return put, shagov_po_side1, shagov_po_side2
end

function na_start!(robot, side1, side2, p::String)
    p = reverse(p)
    for i in p
        if i == '0'
            move!(robot, side1)
        else
            move!(robot, side2)
        end
    end
end

function inverse(side)
    return HorizonSide(mod(Int(side) + 2,4))
end

function HorizonSideRobots.move!(robot, side, num)
    for i in 1:num
        move!(robot, side)
    end
end

function v_uglu!(robot, side1, side2)
    return (isborder(robot, side1) & isborder(robot, side2))
end

proecii_i_na_start!(r)