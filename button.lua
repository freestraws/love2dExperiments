--! file: button.lua

Button = Rectangle:extend()

function Button:new(x, y, w, h, text, color, f)
  Button.super.new(self, x, y, w, h, "fill", color, 25, 25)
  self.text = text or "weird"
  self.f = f
end

function Button:draw()
  love.graphics.push()
  Button.super.draw(self)
  ink("black")
  love.graphics.print(self.text, 0, 0)
  love.graphics.pop()
end

function Button:click()
  self.f()
end

function Button:isInside(x, y)
  if(x>self.x and y>self.y and
    x<self.x+self.width and
    y<self.y+self.height) then
    return true
  end
end