using HorizonSideRobots
r = Robot("ui.sit", animate=true)
 
function all_i_obr!(robot)
    ver, gor = v_ugol!(robot, Sud, West)
    all!(robot)
    nmove!(robot, Nord, ver)
    nmove!(robot, Ost, gor)
end

function all!(robot)
    s = Nord
    while isborder(robot, Ost) == 0
        putmarker!(robot)
        while isborder(robot, s) == 0
            move!(robot, s)
            putmarker!(robot)
        end
        s = HorizonSide(mod(Int(s) + 2 , 4))
        move!(robot, Ost)
    end
    putmarker!(robot)
    while isborder(robot, s) == 0
        move!(robot, s)
        putmarker!(robot)
    end
    for i in [Sud, West]
        while isborder(robot, i) == 0
            move!(robot, i)
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

all_i_obr!(r)