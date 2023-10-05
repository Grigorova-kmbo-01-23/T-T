using HorizonSideRobots
r = Robot("with_two_rectangles.sit", animate=true)
 
function two_per!(rob)
    ver, gor = v_ugol_schet!(rob, Sud, West)
    per!(rob)
    poisk!(rob)
    obv!(rob)
    v_ugol_schet!(rob, Sud, West)
    obr!(rob, ver, Nord, gor, Ost)
end

function obv!(rob)
    for i in [Ost, Nord, West, Sud, Ost]
        putmarker!(rob)
        k = HorizonSide(mod(Int(i) - 1, 4))
        while isborder(rob, i)
            move!(rob, k)
            putmarker!(rob)
        end
        move!(rob, i)
    end
end 

function per!(rob)
    for i in [Nord, Ost, Sud, West]
        while isborder(r, i) == false
            move!(rob, i)
            putmarker!(rob)
        end
    end
end

function v_ugol_schet!(rob, side1, side2)
    n1 = 0
    n2 = 0
    while isborder(rob, side1) == 0 || isborder(rob, side2) == 0
        if isborder(rob, side2) == 0
            move!(rob, side2)
            n2 += 1
        end
        if isborder(rob, side1) == 0
            move!(rob, side1)
            n1 += 1
        end
    end
    return n1, n2
end

function poisk!(rob)
    s = Nord
    while isborder(rob, Ost) == 0 
        while isborder(rob, s) == 0
            move!(rob, s)
            if isborder(rob, Ost) == 1
                break
            end
        end
        if isborder(rob, Ost) == 0
            s = HorizonSide(mod(Int(s)+ 2, 4))
            move!(rob, Ost)
        else
            break
        end
    end
end

function obr!(rob, n1, side1, n2, side2)
    f = 0
    nmove!(rob, side1, n1)
    for i in 1:n2
        if ! isborder(rob, side2)
            move!(rob, side2)
        else
            f = 1
            break
        end
    end
    if f == 1
        v_ugol_schet!(rob, HorizonSide(mod(Int(side1)+ 2, 4)), HorizonSide(mod(Int(side2)+ 2, 4)))
        nmove!(rob, side2, n2)
        nmove!(rob, side1, n1)
    end
end

function nmove!(rob, side, n)
    for i in 1:n
        move!(rob, side)
    end
end

two_per!(r)