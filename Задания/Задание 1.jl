using HorizonSideRobots
r = Robot("untitled.sit", animate=true)

function pryamoi_krest!(robot)
    for sides in [Nord, Ost, Sud, West]
        while isborder(robot, sides) == 0
            move!(robot, sides)
            putmarker!(robot)
        end
        sides = HorizonSide(mod(Int(sides) + 2 , 4))
        while ismarker(robot) == 1
            move!(robot, sides)
        end
    end
    putmarker!(robot)
end

pryamoi_krest!(r)