using HorizonSideRobots
r = Robot("ui.sit", animate=true)

function pryamoi_krest!(robot)
    for s in [Nord, Ost, Sud, West]
        while isborder(robot, s) == 0
            move!(robot, s)
            putmarker!(robot)
        end
        s = HorizonSide(mod(Int(s) + 2 , 4))
        while ismarker(robot) == 1
            move!(robot, s)
        end
    end
    putmarker!(robot)
end

pryamoi_krest!(r)