using HorizonSideRobots
r = Robot("untitled.sit", animate = true)

function findmark!(r)
    s = Ost
    n = 1
    while  ! ismarker(r)
        for i in 1:2
            nmove!(r, s, n)
            s = povorot(s)
        end
        n += 1
    end
end

function povorot(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

function nmove!(r, side, n)
    for i in 1:n
        if !ismarker(r)
            move!(r, side)
        end
    end
end

findmark!(r)