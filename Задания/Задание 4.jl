using HorizonSideRobots
r = Robot("ui.sit", animate=true)

function kosoi_krest!(robot)
    for a in [Nord, Sud]
        for b in [Ost, West]
            while (isborder(robot, a) + isborder(robot, b)) == 0
                move!(robot, a)
                move!(robot, b)
                putmarker!(robot)
            end
            a = HorizonSide(mod(Int(a) + 2 , 4))
            b = HorizonSide(mod(Int(b) + 2 , 4))
            while ismarker(robot) == 1
                move!(robot, a)
                move!(robot, b)
            end
        end
    end
    putmarker!(robot)
end

kosoi_krest!(r)