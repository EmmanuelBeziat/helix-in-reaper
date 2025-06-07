-- helix-in-reaper.lua
-- Basic GUI with a button to create a MIDI block at the cursor position

-- Main script
local script_path = reaper.GetResourcePath() .. "/Scripts/helix-in-reaper/"
-- local script_path = "i:/helix-in-reaper/"
package.path = script_path .. "?.lua;" .. package.path

-- Import modules
local Window = dofile(script_path .. "ui/window.lua")
local Button = dofile(script_path .. "ui/button.lua")
local MIDI = dofile(script_path .. "core/midi.lua")

-- Initialize window
Window.init()

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

function main()
  -- Draw background
  Window.draw_background()

  -- Draw and handle button
  Button.draw()
  Button.handle_click()

  -- Update window
  Window.update()

  -- Check for window close
  if Window.should_close() then
    Window.close()
    return
  end

  reaper.defer(main)
end

main()
