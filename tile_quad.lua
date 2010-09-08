Lovemap.tileQuad = {}

function Lovemap.tileQuad:new(x, y, tileset)
  tileSize = Lovemap.tileSize
  image = Lovemap.tileset
  return love.graphics.newQuad(x * tileSize, y * tileSize, tileSize, tileSize, image:getWidth(), image:getHeight())
end
