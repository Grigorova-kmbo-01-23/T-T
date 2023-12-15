using HorizonSideRobots
r = Robot("untitled.sit", animate=true) 

function perimetr_i_na_start!(robot)
    put = v_ugol_i_put!(robot, Sud, West)
    perimetr!(robot)
    na_start!(robot, Nord, Ost, put)
end

function perimetr!(robot)
    for i in [Nord, Ost, Sud, West]
        while isborder(robot, i) == false
            move!(robot, i)
            putmarker!(robot)
        end
    end
end

function v_ugol_i_put!(robot, side1, side2)
    put = ""
    while !(isborder(robot, side1) & isborder(robot, side2))
        if ! isborder(robot, side1)
            move!(robot, side1)
            put = put * "0" 
        end    
        if ! isborder(robot, side2)
            move!(robot, side2) 
            put = put * "1"
        end  
    end 
    return put
end

function na_start!(robot, side1, side2, put::String)
    put = reverse(put)
    for shag in put
        if shag == '0'
            move!(robot, side1)
        else
            move!(robot, side2)
        end
    end
end

perimetr_i_na_start!(r)