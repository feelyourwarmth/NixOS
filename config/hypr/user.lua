-- --- hypr/user.lua --------------------------------------------------------
-- Your Hyprland overrides, in Ryoku's `hl` Lua API. Loaded LAST, so anything
-- here wins over Ryoku's defaults and over Ryoku Settings. Updates never touch
-- it. Reach for it only for raw config the GUI does not expose.
--
-- --- who owns what --------------------------------------------------------
--   Ryoku defaults   the base modules           replaced by updates   don't edit
--   Ryoku Settings   settings.lua, rebinds.lua  the GUI writes these  edit in-app
--   you              this file, + anything you drop in user_edits     yours
--
-- --- take over a whole module ---------------------------------------------
-- Copy it into the overlay at the same path and edit there, e.g.
--   ~/.config/ryoku/user_edits/hypr/modules/binds.lua
-- You then own that file: `ryoku doctor` warns when an update changes the
-- original, and `ryoku reset hypr/modules/binds.lua` hands it back.
--
-- --- examples -------------------------------------------------------------
-- hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty"))
-- hl.window_rule({ name = "float-mpv", match = { class = "mpv" }, float = true })
-- hl.config({ general = { border_size = 3 } })

local ws_helper = (os.getenv("HOME") or "") .. "/.config/hypr/scripts/ryoku-workspace"

local scrolling_expanded = false

hl.bind("SUPER + F", function()
	local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
	local layout = workspace and (workspace.tiled_layout or tostring(hl.get_config("general.layout")))
		or tostring(hl.get_config("general.layout"))
	if layout == "scrolling" then
		if scrolling_expanded then
			hl.dispatch(hl.dsp.layout("colresize 0.5"))
			scrolling_expanded = false
		else
			hl.dispatch(hl.dsp.layout("colresize 1.0"))
			scrolling_expanded = true
		end
	else
		hl.dispatch(hl.dsp.window.fullscreen())
	end
end)

hl.config({
	cursor = {
		no_warps = false,
	},
})

for i = 1, 10 do
	local key = i % 10 -- 10 maps to the 0 key
	hl.bind(("SUPER + CTRL + " .. key), hl.dsp.exec_cmd(ws_helper .. " move " .. i))
end

hl.unbind("SUPER + mouse_up")
hl.unbind("SUPER + mouse_down")

hl.bind("ALT + Backslash", hl.dsp.exec_cmd("flock -n -o /tmp/ryoshot.lock qs -c ryoshot"))
hl.bind("CTRL + Backslash", hl.dsp.exec_cmd("flock -n -o /tmp/ryoshot.lock env RYOSHOT_MODE=monitor qs -c ryoshot"))

hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.focus({ workspace = "r+1" }))

hl.bind("SUPER + mouse_up", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ direction = "r" }))

hl.window_rule({
	name = "Spotify",
	match = { class = "[Ss]potify" },
	float = false,
})

hl.window_rule({
	name = "Discord",
	match = { class = "[Dd]iscord" },
	float = false,
})

hl.window_rule({
	name = "float-nautilus",
	match = { class = "org.gnome.Nautilus" },
	float = false,
	size = { 1500, 850 },
	center = true,
})

hl.window_rule({
	name = "float-emoji",
	match = { class = "it.mijorus.smile" },
	float = true,
	size = { 340, 140 },
	center = true,
})

hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())
