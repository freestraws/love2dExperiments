--! file: main.lua
local utf8 = require("utf8")

rects = {}
buttons = {}
inputOn = false
local text = "Type here "
mykeys = {}

function love.load()
  tick = require "tick"
  Object = require "classic"
  require "shape"
  require "rectangle"
  require "button"
  require "spriteAnimationSet"
  require "body"
  window_height = love.graphics.getHeight()
  window_width = love.graphics.getWidth()
  myImage = love.graphics.newImage("images/sheep.png")
  table.insert(buttons,
   Button(50, 100, window_width/10, window_height/20, "test", "FAFAFA",
    function () inputOn = not inputOn end))

  local animSetInfo = {
    walk = {
      coords = {
        start = {0, 16},
        ["end"] = {96, 16}
      },
      duration = 3,
      loop = true
    },
    idle = {
      coords = {
        start = {48, 32},
        ["end"] = {96, 48}
      },
      duration = 2,
      loop = true
    }
  }

  bodyTest = Body(200, 100, 16, 16, love.graphics.newImage("images/greenBot.png"), animSetInfo)
end

function love.textinput(t)
  if(inputOn) then
    text = text .. t
  end
end

function love.mousepressed(x, y, mbutton, istouch)
  if mbutton == 1 then
    for i,button in ipairs(buttons) do
      if button:isInside(mouse_x, mouse_y) then
        button:click()
      end
    end
  end
  if not inputOn then
    text = "Type here "
  end
end

function love.update(dt)
  mouse_x, mouse_y = love.mouse.getPosition()
  bodyTest:update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(100, 100, 100)
  for i,button in ipairs(buttons) do
    button:draw()
  end
  bodyTest:draw()
  -- love.graphics.draw(myImage, mouse_x, mouse_y)
  if(inputOn) then
    love.graphics.printf(text, buttons[1].x, buttons[1].y+buttons[1].height, love.graphics.getWidth())
  end
end

function love.keypressed(key)

  if(inputOn) then
    if key == "backspace" then
          -- get the byte offset to the last UTF-8 character in the string.
          local byteoffset = utf8.offset(text, -1)

          if byteoffset then
              -- remove the last UTF-8 character.
              -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
              text = string.sub(text, 1, byteoffset - 1)
          end
      end
    elseif key =="space" then
      rects.createRect()
    end

    if key== "escape" then
      love.event.quit()
    end

    if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end

end

function keyDown(key)
  if love.keyboard.isDown(key) then
    return true
  else
    return false
  end
end

function rects.createRect()
  table.insert(rects,AnimRectangle())
end
