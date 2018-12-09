Gifs = {}
Gifs.__index = Gifs

local avaliableTypes = {
  ["horizontally"] = true,
  ["vertically"] = true,
  ["grid"] = true,
}

function Gifs:new(...)
  local instance = {}
  setmetatable(instance, Gifs)
  if instance:constructor(...) then
    return instance
  end
  return false
end

function Gifs:constructor(...)
  assert(arg[1] and tonumber(arg[1]) ~= nil, "@ Gif x position is not valid (1 arg)!")
  assert(arg[2] and tonumber(arg[2]) ~= nil, "@ Gif y position is not valid (2 arg)!")
  assert(arg[3] and tonumber(arg[3]) ~= nil, "@ Gif width size is not valid (3 arg)!")
  assert(arg[4] and tonumber(arg[4]) ~= nil, "@ Gif height size is not valid (4 arg)!")
  assert(arg[5] and tonumber(arg[5]) ~= nil, "@ Gif row amount is not valid (5 arg)!")
  assert(arg[6] and tonumber(arg[6]) ~= nil, "@ Gif column amount is not valid (6 arg)!")
  assert(isElement(arg[7]) or arg[7] and fileExists(arg[7]), "@ Gif img is not valid (7 arg)!")
  assert(arg[8] and tonumber(arg[8]) ~= nil, "@ Gif img width amount is not valid (8 arg)!")
  assert(arg[9] and tonumber(arg[9]) ~= nil, "@ Gif img height amount is not valid (9 arg)!")

  self.x = arg[1]
  self.y = arg[2]
  self.w = arg[3]
  self.h = arg[4]

  self.rowAmount = arg[5]
  self.columnAmount = arg[6]
  self.img = isElement(arg[7]) and arg[7] or dxCreateTexture(arg[7])
  self.defW = arg[8]
  self.defH = arg[9]
  self.time = arg[10] and arg[10] or 500
  self.type = arg[11] and avaliableTypes[arg[11]] and arg[11] or "horizontally"

  self.row = 0
  self.column = 0
  self.lastTick = getTickCount()
  self.createdTexture = isElement(arg[7]) and true or false

  self.func = {}
  self.func.render = function() self:draw() end

  addEventHandler("onClientRender", root, self.func.render)
  return true
end


function Gifs:draw()
  if (getTickCount() - self.lastTick)/self.time >= 1 then
    self.lastTick = getTickCount()

    if self.type == "horizontally" then
      if self.row < self.rowAmount then
        self:nextRow()
      else 
        self:cleanRow()
      end

    elseif self.type == "vertically" then
      if self.column < self.columnAmount then
        self:nextColumn()
      else
        self:cleanColumn()
      end

    elseif self.type == "grid" then
      if self.row < self.rowAmount then
        self:nextRow()
      else 
        self:cleanRow()

        if self.column < self.columnAmount then
          self:nextColumn()
        else
          self:cleanColumn()
        end
      end
    end
  end

  dxDrawImageSection(self.x, self.y, self.w, self.h, self.defW * self.row, self.defH * self.column, self.defW, self.defH, self.img)
end

function Gifs:nextRow()
  self.row = self.row + 1
end

function Gifs:cleanRow()
  self.row = 0
end

function Gifs:nextColumn()
  self.column = self.column + 1
end

function Gifs:cleanColumn()
  self.column = 0
end

function Gifs:destroyGif()
  removeEventHandler("onClientRender", root, self.func.render)
  if not self.createdTexture and isElement(self.img) then destroyElement(self.img) end
  self = nil
  return true
end


----- ID FUNCTIONS -----
local IDlist = {}
function Gifs:assignID()
  self.ID = self:findFreeValue()
  table.insert(IDlist, self.ID)
  return self.ID
end

function Gifs:getID()
  return self.ID
end

function Gifs:findFreeValue()
	table.sort(IDlist)
	local freeID = 0
	for i, v in ipairs(IDlist) do
		if (v == freeID) then freeID = freeID + 1 end
		if (v > freeID) then return freeID end
	end
	return freeID
end




----- Exports -----
local createdGifs = {}
function createGif(...)
  table.insert(createdGifs, Gifs:new(...))
  local id = createdGifs[#createdGifs]:assignID()
  return id
end

function destroyGif(id)
  for i, v in pairs(createdGifs) do
    if v:getID() == id then
      v:destroyGif()
      return true
    end
  end
  return false
end