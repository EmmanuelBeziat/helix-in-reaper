-- MIDI-related functions
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

return {
  create_midi_block = create_midi_block
}