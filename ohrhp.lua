-- ohrp
-- v0.0.1 @daeclan
-- tinyurl.com/yr5r8mbd
--
-- /
-- //
-- //
-- ///////
-- //
-- //
-- mOtHeRsHiP
-- //
-- //
-- ///////
-- //
-- //
-- /

engine.name = 'Ohrhp'


ohrhp = include('ohrhp/lib/ohrhp_engine')
s = require 'sequins'

g = grid.connect(1) 

grid_redraw_metro = metro.init()

grid_redraw_metro.event = function()
  if grid.device and Grid_Dirty then
    grid_redraw()
    grid_dirty = false
  end
end

grid_redraw_metro:start(1/25)

key_leds = {}

function init()
  lights = true
  ohrhp.add_params() -- the script adds params via the `.add params()` function
  mults = s{1, 2.25, s{0.25, 1.5, 3.5, 2, 3, 0.75} }
  playing = false
  sequence = clock.run(
    function()
      while true do
        clock.sync(1/3)
        if playing then
          ohrhp.trig(200 * mults() * math.random(2))
        end
      end
    end
  )
  keys = {
  {1, 6, 8, 65.41},
  {2, 7, 8, 73.42},
  {3, 8, 8, 82.41},
  {4, 8, 8, 87.31},
  {5, 7, 8, 98},
  {6, 6, 8, 110},
  {7, 5, 8, 123.47},
  {8, 5, 8, 130.81},
  {9, 6, 8, 146.83},
  {10, 7, 8, 164.81},
  {11, 7, 8, 174.61},
  {12, 6, 8, 196},
  {13, 5, 8, 220},
  {14, 4, 8, 246.94},
  {15, 4, 8, 261.63},
  {16, 5, 8, 293.66},
  {17, 6, 8, 329.63},
  {18, 6, 8, 349.23},
  {19, 5, 8, 392.00},
  {20, 4, 8, 440.00},
  {21, 3, 8, 493.88},
  {22, 3, 8, 523.25},
  {23, 4, 8, 587.33},
  {24, 5, 8, 659.26},
  {25, 5, 8, 698.46},
  {26, 4, 8, 783.99},
  {27, 3, 8, 880.00},
  {28, 2, 8, 987.77},
  {29, 2, 8, 1046.50},
  {30, 3, 8, 1174.66},
  {31, 4, 8, 1318.51},
  {32, 4, 8, 1396.91},
  {33, 3, 8, 1567.98},
  {34, 2, 8, 1760.00},
  {35, 1, 8, 1975.53},
  {36, 1, 8, 2093.00},
  {2, 6, 3, 69.3},
  {3, 7, 3, 77.78},
  {4, 7, 3, 92.5},
  {5, 6, 3, 103.83},
  {6, 5, 3, 116.54},
  {9, 5, 3, 138.59},
  {10, 6, 3, 155.56},
  {11, 6, 3, 185},
  {12, 5, 3, 207.65},
  {13, 4, 3, 233.08},
  {16, 4, 3, 277.18},
  {17, 5, 3, 311.13},
  {18, 5, 3, 369.99},
  {19, 4, 3, 415.30},
  {20, 3, 3, 466.16},
  {23, 3, 3, 554.37},
  {24, 4, 3, 622.25},
  {25, 4, 3, 739.99},
  {26, 3, 3, 830.61},
  {27, 2, 3, 932.33},
  {30, 2, 3, 1108.73},
  {31, 3, 3, 1244.51},
  {32, 3, 3, 1479.98},
  {33, 2, 3, 1661.22},
  {34, 1, 3, 1864.66},
  }
  for i=1, #keys do
    local k = keys[i]
    local x = k[1]
    local y = k[2]
    local brightness = k[3]
    if key_leds[x] = nil then
      key_leds[x] = {}
    end
    key_leds[x][y] = brightness
    -- g:led(keys[i][1], keys[i][2], keys[i][3])
  end
  -- g:refresh()
end

if g:refresh() then
  print('kiss me')
end

-- g.key = function(x,y,z)
--   if z == 1 then -- if a key is pressed...
--     steps[x] = y -- store its vertical position (y) for that step (x)
--     grid_redraw() -- redraw the grid
--   end
-- end

function key(n,z)
  if n == 3 and z == 1 then
    playing = not playing
    mults:reset()
    redraw()
  end
  if n == 2 and z == 1 then
    if lights then
      ohrhp.trig(200 * mults() * math.random(2))
      g:all(0)
      g:refresh()
      print(lights)
      print('f')
      lights = false
    elseif lights == false then
      ohrhp.trig(200 * mults() * math.random(2))
      g:all(10)
      g:refresh()
      lights = true
      print(lights)
      print('s')
    end 
  end
end

g.key = function(x,y,z)
  if z==1 then engine.hz(100+x*4+y*64) end
  g:led(x,y,z*15)
  g:refresh()
end

function redraw()
  screen.clear()
  screen.move(64,32)
  screen.text(playing and "K3: turn off" or "K3: turn on")
  screen.move(64,46)
  screen.text("OHRP?")
  screen.update()
end
