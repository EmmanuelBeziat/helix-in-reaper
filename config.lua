-- Global configuration
local Config = {
  -- Paths
	script_path = reaper.GetResourcePath() .. "/Scripts/helix-in-reaper/",
  -- script_path = "i:/helix-in-reaper/",

  -- Window settings
  window = {
    title = "Helix in Reaper",
    width = 300,
    height = 300
  },

  -- UI element positions and sizes
  device_list = {
    x = 20,
    y = 20,
    width = 260,
    height = 100
  },

  button = {
    x = 50,
    y = 250,
    width = 200,
    height = 40,
    text = "Create MIDI Block"
  }
}

return Config