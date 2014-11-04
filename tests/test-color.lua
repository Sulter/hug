require('path')
local framework = require('tt')
local color     = require('hug.color')

local function eq()
  local a = color.fromrgba(100, 200, 300)
  local b = color.fromtable{100, 200, 300}
  framework.compare(true, a == b, 'rgb-rgb color equality')
  
  local c = color.fromrgba(100, 200, 300, 200)
  local d = color.fromtable{100, 200, 300}
  framework.compare(false, c == d, 'rgba-rgb color equality')
  
  local e = color.fromrgba(100, 200, 300, 100)
  local f = color.fromtable{100, 200, 300, 100}
  framework.compare(true, e == f, 'rgba-rgba color equality')
end

local function add()
  framework.compare(
    color.fromrgba(100, 200, 100),
    color.fromrgba(40, 100, 60):add(color.fromrgba(60, 100, 40))
  )
end

local function sub()
  framework.compare(
    color.fromrgba(100, 100, 100),
    color.fromrgba(200, 150, 100):sub(color.fromrgba(100, 50, 0))
  )
end

local function mul()
  framework.compare(
    color.fromrgba(100, 150, 200),
    color.fromrgba(10, 15, 20):mul(10)
  )
end

local function div()
  framework.compare(
    color.fromrgba(10, 15, 20),
    color.fromrgba(100, 150, 200):div(10)
  )
end

local function opadd()
  framework.compare(
    color.fromrgba(100, 200, 100),
    color.fromrgba(40, 100, 60) + color.fromrgba(60, 100, 40)
  )
  
  framework.ensureerror(function()
    return color.fromrgba(100, 200, 100) + 5
  end, 'invalid operation: color + number')

  framework.ensureerror(function()
    return 5 + color.fromrgba(100, 200, 100)
  end, 'invalid operation: number + color')
end

local function opsub()
  framework.compare(
    color.fromrgba(100, 100, 100),
    color.fromrgba(200, 150, 100) - color.fromrgba(100, 50, 0)
  )
  
  framework.ensureerror(function()
    return color.fromrgba(100, 200, 100) - 5
  end, 'invalid operation: color - number')

  framework.ensureerror(function()
    return 5 - color.fromrgba(100, 200, 100)
  end, 'invalid operation: number - color')
end

local function opmul()
  framework.compare(
    color.fromrgba(100, 150, 200),
    color.fromrgba(10, 15, 20) * 10,
    'color * scalar'
  )
  framework.compare(
    color.fromrgba(100, 150, 200),
    10 * color.fromrgba(10, 15, 20),
    'scalar * color'
  )
  
  framework.ensureerror(function()
    return color.fromrgba(100, 200, 100) * color.fromrgba(1, 2, 3)
  end, 'invalid operation: color * color')
end

local function opdiv()
  framework.compare(
    color.fromrgba(100, 75, 50),
    color.fromrgba(200, 150, 100) / 2,
    'color / scalar'
  )
  
  framework.ensureerror(function()
    return color.fromrgba(100, 200, 100) / color.fromrgba(1, 2, 3)
  end, 'invalid operation: color / color')
end

local function invert()
  framework.compare(
    color.fromrgba(100, 120, 140),
    color.fromrgba(255 - 100, 255 - 120, 255 - 140):invert()
  )
end

local function opinvert()
  framework.compare(
    color.fromrgba(100, 120, 140),
    -color.fromrgba(255 - 100, 255 - 120, 255 - 140)
  )
end

return framework.testall {
  { 'equality', eq },

  { 'in-place addition', add },
  { 'in-place subtraction', sub },
  { 'in-place multiplication', mul },
  { 'in-place division', div },

  { 'operator addition', opadd },
  { 'operator subtraction', opsub },
  { 'operator multiplication', opmul },
  { 'operator division', opdiv },
  
  { 'in-place inversion', invert },
  { 'operator inversion', opinvert }
}
