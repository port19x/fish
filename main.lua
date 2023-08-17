function love.load()
    d = 200
    points = 0
    w = love.graphics.getWidth()
    h = love.graphics.getHeight()
end

function castrod()
    rod_x = love.mouse.getX()
    rod_y = love.mouse.getY()
    aux = 0
    auxlive = 100
    cast = true
end

function reelinrod()
    cast = false
    auxlive = -1
    if not pdebounce and fishable then
        points = points + 1
    end
    fishable = false
end

function bumpbobber()
    aux = aux + 1
    auxlive = auxlive - 1 
    if auxlive == 0 then
        fishable = false
        auxlive = 100
        aux = 0
        fishable = math.random() * 100 < 50
    end
end

function love.update(dt)
    if love.mouse.isDown(1) and not pdebounce then
        if cast then reelinrod() else castrod() end
    end
    if cast then
        bumpbobber()
    end
    pdebounce = love.mouse.isDown(1)
end

function love.draw()
    love.graphics.setBackgroundColor(35/255, 87/255, 124/255)
    love.graphics.setColor(1,1,1)
    if points <= 0 then
        love.graphics.print("Leftclick to cast fishing rod", 10, 10)
        love.graphics.print("Reel in when the ripple turns cyan", 10, 30)
    end
    love.graphics.print(string.format("Fish caught: %d", points), w-120, 10)
    love.graphics.setColor(1/5, 1/5, 1/5, 1/2)
    if cast then
        love.graphics.line(w/2, h, rod_x, rod_y)
        if fishable then
            love.graphics.setColor(0, 1, 1, 1/2)
        end
        love.graphics.circle("line", rod_x, rod_y, aux, aux)
    end
end
