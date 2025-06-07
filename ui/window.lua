-- Window management
local Window = {
  title = "Helix in Reaper",
  width = 300,
  height = 100
}

function Window.init()
  gfx.init(Window.title, Window.width, Window.height)
end

function Window.draw_background()
  gfx.set(0.18, 0.18, 0.18, 1)
  gfx.rect(0, 0, gfx.w, gfx.h, 1)
end

function Window.update()
  gfx.update()
end

function Window.should_close()
  return gfx.getchar() < 0
end

function Window.close()
  gfx.quit()
end

return Window