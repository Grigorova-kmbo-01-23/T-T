using HorizonSideRobots
r = Robot("untitled.sit", animate=true)
 
function perimetr_i_na_start!(robot)
    shagov_po_vertikali, shagov_po_gorizontali = v_ugol!(robot, Sud, West)
    perimetr!(robot)
    move!(robot, Nord, shagov_po_vertikali)
    move!(robot, Ost, shagov_po_gorizontali)
end

function perimetr!(robot)
    for i in [Nord, Ost, Sud, West]
        while isborder(r, i) == false
            move!(robot, i)
            putmarker!(robot)
        end
    end
end

function HorizonSideRobots.move!(robot, side, num)
    for i in 1:num
        move!(robot, side)
    end
end

function v_ugol!(robot, side1, side2)
    koordinaty_po_side1, koordinaty_po_side2 =  0, 0
    while ! isborder(robot, side2)
        move!(robot, side2)
        koordinaty_po_side2 += 1
    end
    while ! isborder(robot, side1)
        move!(robot, side1)
        koordinaty_po_side1 += 1
    end
    return koordinaty_po_side1, koordinaty_po_side2
end

perimetr_i_na_start!(r)