using HorizonSideRobots
r = Robot("Zadanie5.sit", animate=true)
 
function dva_perimetra_i_na_start!(robot)
    shagov_po_vertikali, shagov_po_gorizontali = v_ugol!(robot, Sud, West)
    vneshnii_perimetr!(robot)
    poisk_vnutrennego_pryamougolnica!(robot)
    vnutrennii_perimetr!(robot)
    v_ugol!(robot, Sud, West)
    na_start!(robot, shagov_po_vertikali, Nord, shagov_po_gorizontali, Ost)
end

function vnutrennii_perimetr!(robot)
    for border_side in [Ost, Nord, West, Sud, Ost]
        putmarker!(robot)
        move_side = HorizonSide(mod(Int(border_side) - 1, 4))
        while isborder(robot, border_side)
            move!(robot, move_side)
            putmarker!(robot)
        end
        move!(robot, border_side)
    end
end 

function vneshnii_perimetr!(robot)
    for side in [Nord, Ost, Sud, West]
        while isborder(robot, side) == false
            move!(robot, side)
            putmarker!(robot)
        end
    end
end

function poisk_vnutrennego_pryamougolnica!(robot)
    side = Nord
    while isborder(robot, Ost) == 0 
        while isborder(robot, side) == 0
            move!(robot, side)
            if isborder(robot, Ost) == 1
                break
            end
        end
        if isborder(robot, Ost) == 0
            side = HorizonSide(mod(Int(side)+ 2, 4))
            move!(robot, Ost)
        else
            break
        end
    end
end

function na_start!(robot, shagov_v_side1, side1, shagov_v_side2, side2)
    flag = 0
    move!(robot, side1, shagov_v_side1)
    for i in 1:shagov_v_side2
        if ! isborder(robot, side2)
            move!(robot, side2)
        else
            flag = 1
            break
        end
    end
    if flag == 1
        v_ugol!(robot, HorizonSide(mod(Int(side1)+ 2, 4)), HorizonSide(mod(Int(side2)+ 2, 4)))
        move!(robot, side2, shagov_v_side2)
        move!(robot, side1, shagov_v_side1)
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


dva_perimetra_i_na_start!(r)