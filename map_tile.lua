Lovemap.mapTile = {}

function Lovemap.mapTile:new(map, x, y, material)
  object = {
    map = map,
    x = x,
    y = y,
    material = material,
    seed = math.random(1,99)
  }

  setmetatable(object, {__index = Lovemap.mapTile})
  return object
end

function Lovemap.mapTile:tileQuads()
  quads = {}
  overlayQuads = {}
  
  quads[1] = self.material:baseTile(self.seed)

  if self:nOverlay() then overlayQuads[#overlayQuads+1] = self:nOverlay() end
  if self:eOverlay() then overlayQuads[#overlayQuads+1] = self:eOverlay() end
  if self:sOverlay() then overlayQuads[#overlayQuads+1] = self:sOverlay() end
  if self:wOverlay() then overlayQuads[#overlayQuads+1] = self:wOverlay() end
  if self:neInnerOverlay() then overlayQuads[#overlayQuads+1] = self:neInnerOverlay() end
  if self:seInnerOverlay() then overlayQuads[#overlayQuads+1] = self:seInnerOverlay() end
  if self:swInnerOverlay() then overlayQuads[#overlayQuads+1] = self:swInnerOverlay() end
  if self:nwInnerOverlay() then overlayQuads[#overlayQuads+1] = self:nwInnerOverlay() end
  if self:neOuterOverlay() then overlayQuads[#overlayQuads+1] = self:neOuterOverlay() end
  if self:seOuterOverlay() then overlayQuads[#overlayQuads+1] = self:seOuterOverlay() end
  if self:swOuterOverlay() then overlayQuads[#overlayQuads+1] = self:swOuterOverlay() end
  if self:nwOuterOverlay() then overlayQuads[#overlayQuads+1] = self:nwOuterOverlay() end

  table.sort(overlayQuads, function(a, b)
    return a.z < b.z
  end)

  for i=1,#overlayQuads do quads[i+1] = overlayQuads[i].tile end

  return(quads)
end

function Lovemap.mapTile:n()
  if self.y == 1 then return(nil) else return(self.map.tiles[self.x][self.y-1]) end
end

function Lovemap.mapTile:e()
  if self.x == self.map.width then return(nil) else return(self.map.tiles[self.x+1][self.y]) end
end

function Lovemap.mapTile:s()
  if self.y == self.map.height then return(nil) else return(self.map.tiles[self.x][self.y+1]) end
end

function Lovemap.mapTile:w()
  if self.x == 1 then return(nil) else return(self.map.tiles[self.x-1][self.y]) end
end

function Lovemap.mapTile:ne()
  if self.y == 1 or self.x == self.map.width then return(nil) else return(self.map.tiles[self.x+1][self.y-1]) end
end

function Lovemap.mapTile:se()
  if self.y == self.map.height or self.x == self.map.width then return(nil) else return(self.map.tiles[self.x+1][self.y+1]) end
end

function Lovemap.mapTile:sw()
  if self.y == self.map.height or self.x == 1 then return(nil) else return(self.map.tiles[self.x-1][self.y+1]) end
end

function Lovemap.mapTile:nw()
  if self.y == 1 or self.x == 1 then return(nil) else return(self.map.tiles[self.x-1][self.y-1]) end
end

function Lovemap.mapTile:nOverlay()
  if self:n() and self:n().material.zLevel > self.material.zLevel then
    return({tile = self:n().material.overlayTiles.n, z = self:n().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:eOverlay()
  if self:e() and self:e().material.zLevel > self.material.zLevel then
    return({tile = self:e().material.overlayTiles.e, z = self:e().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:sOverlay()
  if self:s() and self:s().material.zLevel > self.material.zLevel then
    return({tile = self:s().material.overlayTiles.s, z = self:s().material.zLevel})
  else
    return(nil)
  end
end
  
function Lovemap.mapTile:wOverlay()
  if self:w() and self:w().material.zLevel > self.material.zLevel then
    return({tile = self:w().material.overlayTiles.w, z = self:w().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:neInnerOverlay()
  if self:ne() 
    and self:n().material.zLevel > self.material.zLevel
    and self:e().material.zLevel > self.material.zLevel 
    and self:n().material.name == self:e().material.name then
    return({tile = self:n().material.overlayTiles.ne_inner, z = self:n().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:seInnerOverlay()
  if self:se() 
    and self:s().material.zLevel > self.material.zLevel
    and self:e().material.zLevel > self.material.zLevel 
    and self:s().material.name == self:e().material.name then
    return({tile = self:s().material.overlayTiles.se_inner, z = self:s().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:swInnerOverlay()
  if self:sw() 
    and self:s().material.zLevel > self.material.zLevel
    and self:w().material.zLevel > self.material.zLevel 
    and self:s().material.name == self:w().material.name then
    return({tile = self:s().material.overlayTiles.sw_inner, z = self:s().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:nwInnerOverlay()
  if self:nw() 
    and self:n().material.zLevel > self.material.zLevel
    and self:w().material.zLevel > self.material.zLevel 
    and self:n().material.name == self:w().material.name then
    return({tile = self:n().material.overlayTiles.nw_inner, z = self:n().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:neOuterOverlay()
  if self:ne()
    and self:ne().material.zLevel > self:n().material.zLevel
    and self:ne().material.zLevel > self:e().material.zLevel
    and self:ne().material.zLevel > self.material.zLevel then
    return({tile = self:ne().material.overlayTiles.ne_outer, z = self:ne().material.zLevel})
  else
    return(nil)
  end
end
  
function Lovemap.mapTile:seOuterOverlay()
  if self:se()
    and self:se().material.zLevel > self:s().material.zLevel
    and self:se().material.zLevel > self:e().material.zLevel
    and self:se().material.zLevel > self.material.zLevel then
    return({tile = self:se().material.overlayTiles.se_outer, z = self:se().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:swOuterOverlay()
  if self:sw()
    and self:sw().material.zLevel > self:s().material.zLevel
    and self:sw().material.zLevel > self:w().material.zLevel
    and self:sw().material.zLevel > self.material.zLevel then
    return({tile = self:sw().material.overlayTiles.sw_outer, z = self:sw().material.zLevel})
  else
    return(nil)
  end
end

function Lovemap.mapTile:nwOuterOverlay()
  if self:nw()
    and self:nw().material.zLevel > self:n().material.zLevel
    and self:nw().material.zLevel > self:w().material.zLevel
    and self:nw().material.zLevel > self.material.zLevel then
    return({tile = self:nw().material.overlayTiles.nw_outer, z = self:nw().material.zLevel})
  else
    return(nil)
  end
end
