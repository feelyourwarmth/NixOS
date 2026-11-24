# The overlay: ~/.config/ryoku/user_edits

This folder mirrors ~/.config. A file you put here is laid on top of Ryoku's own
copy on every update, so it wins and survives while Ryoku's base file keeps
getting fixes underneath. Empty is fine.

Use the overlay to FORK a whole Ryoku file you want to fully own: copy it here at
the same path and edit it. ryoku doctor then warns when an update changes the
original, and ryoku reset <path> hands it back.

Ryoku Settings (Super + ,) writes these here; change them in the GUI, not by
hand:

    ~/.config/hypr/settings.lua
    ~/.config/hypr/rebinds.lua

--- Simple tweaks do NOT go here -----------------------------------------

Edit the tool's own user file at its normal place. Ryoku never overwrites these,
so your edits always survive an update:

    ~/.config/hypr/user.lua
    ~/.config/hypr/monitors_user.lua
    ~/.config/kitty/user.conf

Putting one of those in this overlay is the old, broken way: the overlay froze a
copy and re-laid it over your live file every update, wiping later edits. If you
find one here, move it back to the path above; ryoku doctor does this for you.

--- Commands -------------------------------------------------------------

    ryoku reset <path>   drop one forked file, back to Ryoku's default
    ryoku reset          drop everything here (asks first)
    ryoku recovery       last resort: wipe all edits and settings, pure Ryoku

--- Notes ----------------------------------------------------------------

.md files here (like this one) are never copied into the live config, so keep
your own notes beside your edits.
