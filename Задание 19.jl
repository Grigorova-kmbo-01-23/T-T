using HorizonSideRobots
rob = Robot("untitled.sit", animate = true)

function along!(st_cond, r, side)
    while !st_cond()
        move!(r, side)
        along!(st_cond, r, side)
    end
end

along!(() -> isborder(rob, Ost), rob, Ost)