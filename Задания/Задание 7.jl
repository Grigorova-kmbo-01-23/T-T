using HorizonSideRobots
r = Robot("untitled.sit", animate = true)

function prohod!(r)
    n = 1
    s = Ost
    while isborder(r, Nord)
        nmove!(r, s, n)
        n += 1
        s = inverse(s)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function nmove!(r, side, n)
    for i in 1:n
        if !isborder(r, side)
            move!(r, side)
        end
    end
end

prohod!(r)