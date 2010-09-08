Lovemap = {}
Lovemap.tileSize = 16
Lovemap.tileset = love.graphics.newImage("lovemap/tileset.png")

function Lovemap:new(width, height)
  object = {
    width = width,
    height = height,
    x = 0,
    y = 0,
    tiles = {}
  }

  setmetatable(object, {__index = Lovemap})
  return object
end

function Lovemap:setup()
  for x=1,self.width do
    self.tiles[x] = {}
    for y=1,self.height do
      self.tiles[x][y] = Lovemap.mapTile:new(self, x, y, Lovemap.materials.grass)
    end
  end

  self:buildSpriteBatch()
end

function Lovemap:buildSpriteBatch()
  self.spriteBatch = love.graphics.newSpriteBatch(Lovemap.tileset, self.width * self.height * 4)

  for x=0, self.width-1 do
    for y=0, self.height-1 do
      quads = self.tiles[x+1][y+1]:tileQuads()
      for i=1,#quads do self.spriteBatch:addq(quads[i], x * Lovemap.tileSize, y * Lovemap.tileSize) end
    end
  end
end

function Lovemap:move(dx, dy)
  self.x = math.max(math.min(self.x + dx * Lovemap.tileSize, self.width * Lovemap.tileSize - love.graphics.getWidth()), 0)
  self.y = math.max(math.min(self.y + dy * Lovemap.tileSize, self.height * Lovemap.tileSize - love.graphics.getHeight()), 0)
end

function Lovemap:draw()
  love.graphics.draw(self.spriteBatch, 0, 0, 0, 1, 1, self.x, self.y)
end
