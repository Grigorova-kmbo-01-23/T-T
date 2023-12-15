using HorizonSideRobots
r = Robot("untitled.sit", animate = true)

function prohod!(robot)
    dlina_shaga = 1
    side = Ost
    while isborder(robot, Nord)
        move!(robot, side, dlina_shaga)
        dlina_shaga += 1
        side = inverse(side)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function HorizonSideRobots.move!(robot, side, num)
    for i in 1:num
        if isborder(robot, side)
           move!(robot, side)
        end
    end
end

prohod!(r)
