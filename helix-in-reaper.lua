-- helix-in-reaper.lua
-- Basic GUI with a button to create a MIDI block at the cursor position

function create_midi_block()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track first!", "Error", 0)
    return
  end

  local cursor_pos = reaper.GetCursorPosition()
  local proj = 0
  local _, num, denom = reaper.TimeMap_GetTimeSigAtTime(proj, cursor_pos)
  local qn = reaper.TimeMap2_timeToQN(proj, cursor_pos)
  local qn_end = qn + num -- 1 measure
  local end_pos = reaper.TimeMap2_QNToTime(proj, qn_end)

  local item = reaper.CreateNewMIDIItemInProj(track, cursor_pos, end_pos, false)
  if not item then
    reaper.ShowMessageBox("Failed to create MIDI item.", "Error", 0)
  end
end

-- GUI parameters
local window_title = "Helix in Reaper"
local width, height = 300, 100

function main()
  gfx.init(window_title, width, height)
  while true do
    gfx.set(0.18, 0.18, 0.18, 1) -- background color
    gfx.rect(0, 0, gfx.w, gfx.h, 1)

    -- Draw button
    local btn_x, btn_y, btn_w, btn_h = 50, 30, 200, 40
    gfx.set(0.3, 0.5, 0.7, 1)
    gfx.rect(btn_x, btn_y, btn_w, btn_h, 1)
    gfx.set(1, 1, 1, 1)
    gfx.x = btn_x + 40
    gfx.y = btn_y + 12
    gfx.drawstr("Create MIDI Block")

    -- Button click detection
    if gfx.mouse_cap & 1 == 1 then
      local mx, my = gfx.mouse_x, gfx.mouse_y
      if mx > btn_x and mx < btn_x + btn_w and my > btn_y and my < btn_y + btn_h then
        if not button_down then
          create_midi_block()
          button_down = true
        end
      end
    else
      button_down = false
    end

    if gfx.getchar() < 0 then break end
    gfx.update()
    reaper.defer(main)
    return
  end
  gfx.quit()
end

main()
