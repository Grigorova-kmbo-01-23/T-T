using HorizonSideRobots
rob = Robot("Zadania8,17.sit", animate = true)

function spiral!(stop_condition, robot)
    side = Ost
    dlina_storoni = 1
    while !stop_condition()
        for i in 1:2
            move!(stop_condition, robot, side, dlina_storoni)
            side = povorot(side)
        end
        dlina_storoni += 1
    end
end

function povorot(side)
    return HorizonSide(mod(Int(side) + 1, 4))
end

function try_move!(stop_condition, robot, side)
    if !stop_condition()     
        move!(robot, side)
    end
end

function HorizonSideRobots.move!(stop_condition::Function, robot::Robot, side::HorizonSide, num::Integer)
    for i in 1:num
        try_move!(stop_condition, robot, side)
    end
end

spiral!(() -> ismarker(rob), rob)
