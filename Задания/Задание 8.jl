using HorizonSideRobots
r = Robot("Zadania8,17.sit", animate = true)

function findmark!(robot)
    side = Ost
    dlina_storoni = 1
    while  ! ismarker(r)
        for i in 1:2
            move!(robot, side, dlina_storoni)
            side = povorot(side)
        end
        dlina_storoni += 1
    end
end

function povorot(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

function HorizonSideRobots.move!(robot::Robot, side::HorizonSide, num::Integer)
    for i in 1:num
        if !ismarker(robot)
            move!(robot, side)
        end
    end
end

findmark!(r)
