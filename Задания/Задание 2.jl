using HorizonSideRobots
r = Robot("ui.sit", animate=true)
 
function per_i_obr!(robot)
    ver, gor = v_ugol!(robot, Sud, West)
    per!(robot)
    nmove!(robot, Nord, ver)
    nmove!(robot, Ost, gor)
end

function per!(robot)
    for i in [Nord, Ost, Sud, West]
        while isborder(r, i) == false
            move!(r, i)
            putmarker!(r)
        end
    end
end

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

function v_ugol!(rob, side1, side2)
    n1, n2 =  0, 0
    while ! isborder(rob, side2)
        move!(rob, side2)
        n2 += 1
    end
    while ! isborder(rob, side1)
        move!(rob, side1)
        n1 += 1
    end
    return n1, n2
end

per_i_obr!(r)