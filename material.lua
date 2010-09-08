Lovemap.material = {}
Lovemap.materials = {}

function Lovemap.material:new(materialName)
  object = {
    name = materialName, 
    zLevel = 0,
    baseTileYOffset = 0,
    baseTileCount = 0,
    baseTiles = {},
    overlayTiles = {}
  }
  Lovemap.materials[materialName] = object
  setmetatable(object, {__index = Lovemap.material})
  return object
end

function Lovemap.material:baseTile(seed)
  seed = seed or 0
  seed = seed % self.baseTileCount + 1
  
  if not self.baseTiles[seed] then
    self.baseTiles[seed] = Lovemap.tileQuad:new(seed - 1, self.baseTileYOffset)
  end

  return self.baseTiles[seed]
end

require "lovemap/material/grass"
require "lovemap/material/dirt"
require "lovemap/material/water"
require "lovemap/material/deepwater"
