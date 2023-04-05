require("./const")

function love.load()
  LoadPlayer()
  LoadBullets()
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  PlayerControl(dt)
  UpdateBullet(dt)
end

function love.draw()
  DrawBullets()
  DrawPlayer()
end

function PlayerControl(dt)
  if love.keyboard.isDown("d") then
    Player.x = Player.x + Player.speed * dt
  elseif love.keyboard.isDown("a") then
    Player.x = Player.x - Player.speed * dt
  end

  if love.keyboard.isDown("w") then
    Player.y = Player.y - Player.speed * dt
  elseif love.keyboard.isDown("s") then
    Player.y = Player.y + Player.speed * dt
  end
end

function love.mousepressed(x, y, button, istouch)
  CreateBullet(x, y, button)
end

function UpdateBullet(dt)
  if #Bullets <= 0 then
    return
  end

  for i = #Bullets, 1, -1 do
    Bullets[i].x = Bullets[i].x + Bullets[i].dx * dt
    Bullets[i].y = Bullets[i].y + Bullets[i].dy * dt

    if Bullets[i].x <= 0 or Bullets[i].x >= WIDTH or Bullets[i].y <= 0 or Bullets[i].y >= HEIGHT then
      table.remove(Bullets, i)
    end
  end
end

function DrawBullets()
  for i = 1, #Bullets do
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", Bullets[i].x, Bullets[i].y, 5)
  end
end

function DrawPlayer()
  local angle = math.atan2((love.mouse.getY() - Player.y), (love.mouse.getX() - Player.x))

  love.graphics.translate(Player.x - 5 + 5, Player.y)
  love.graphics.rotate(angle - math.pi / 2)
  love.graphics.translate(-Player.x, -Player.y)

  love.graphics.setColor(1, 1, 0)
  love.graphics.rectangle("fill", Player.x - 7, Player.y, 14, 40)
  love.graphics.setColor(0, 1, 0)
  love.graphics.circle("fill", Player.x, Player.y, 20)
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("fill", Player.x + 10, Player.y + 5, 4)
  love.graphics.circle("fill", Player.x - 10, Player.y + 5, 4)

  love.graphics.translate(Player.x, Player.y)
  love.graphics.rotate(-angle + math.pi / 2)
  love.graphics.translate(-Player.x, -Player.y)
end
