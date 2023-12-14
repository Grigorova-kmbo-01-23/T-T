using HorizonSideRobots
r = Robot("untitled.sit", animate=true)
 
function all_i_na_start!(robot)
    shagov_po_vertikali, shagov_po_gorizontali = v_ugol!(robot, Sud, West)
    all!(robot)
    move!(robot, Nord, shagov_po_vertikali)
    move!(robot, Ost, shagov_po_gorizontali)
end

function all!(robot)
    side_now = Nord
    while isborder(robot, Ost) == 0
        putmarker!(robot)
        while isborder(robot, side_now) == 0
            move!(robot, side_now)
            putmarker!(robot)
        end
        side_now = HorizonSide(mod(Int(side_now) + 2 , 4))
        move!(robot, Ost)
    end
    putmarker!(robot)
    while isborder(robot, side_now) == 0
        move!(robot, side_now)
        putmarker!(robot)
    end
    for side in [Sud, West]
        while isborder(robot, side) == 0
            move!(robot, side)
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


all_i_na_start!(r)