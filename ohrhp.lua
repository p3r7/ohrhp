-- ohrp
-- v0.0.1 @daeclan
-- www.yamom.com
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

g = grid.connect() 
-- g.key = function(x,y,z) print(x,y,z) end



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
  	{1, 6, 8},
	{2, 7, 8},
	{3, 8, 8},
	{4, 8, 8},
	{5, 7, 8},
	{6, 6, 8},
	{7, 5, 8},
	{8, 5, 8},
	{9, 6, 8},
	{10, 7, 8},
	{11, 7, 8},
	{12, 6, 8},
	{13, 5, 8},
	{14, 4, 8},
	{15, 4, 8},
	{16, 5, 8},
	{2, 6, 3},
	{3, 7, 3},
	{4, 7, 3},
	{5, 6, 3},
	{6, 5, 3},
	{9, 5, 3},
	{10, 6, 3},
	{11, 6, 3},
	{12, 5, 3},
	{13, 4, 3},
	{16, 4, 3},
	{17, 6, 8},
	{18, 6, 8},
	{19, 5, 8},
	{20, 4, 8},
	{21, 3, 8},
	{22, 3, 8},
	{23, 4, 8},
	{25, 5, 8},
	{26, 4, 8},
	{27, 3, 8},
	{28, 2, 8},
	{29, 2, 8},
	{30, 3, 8},
	{31, 4, 8},
	{32, 4, 8},
	{33, 3, 8},
	{34, 2, 8},
	{35, 1, 8},
	{36, 1, 8},
  }
  for i=1,28 do
    g:led(keys[i][1], keys[i][2], keys[i][3])
  end

  g:refresh()
end

-- g.key = function(x,y,z)
--   if z == 1 then -- n.b. saving this for the next step
--     steps[x] = y -- 
--     grid_redraw() --
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
