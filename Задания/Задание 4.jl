using HorizonSideRobots
r = Robot("untitled.sit", animate=true)

function kosoi_krest!(robot)
    sides = ((Nord,Ost), (Sud,Ost), (Sud,West), (Nord,West))
    for s in sides
        while isborder(robot, s) == 0
            move!(robot, s)
            putmarker!(robot)
        end
        s = inverse(s)
        while ismarker(robot) == 1
            move!(robot, s)
        end
    end
    putmarker!(robot)
end

HorizonSideRobots.isborder(robot, side::Tuple{HorizonSide, HorizonSide}) = isborder(robot, side[1]) || isborder(robot, side[2])

function HorizonSideRobots.move!(r::Robot, s::Tuple{HorizonSide, HorizonSide})
    move!(r, s[1])
    move!(r, s[2])
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s) + 2 , 4))

inverse(s::Tuple{HorizonSide, HorizonSide}) = inverse.(s)

kosoi_krest!(r)