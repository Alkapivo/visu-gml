# UI overview


## Title bar
On left there are three buttons:
- `New` - open modal with new project creator. Can be triggered through keyboard shortcut `CTRL + N`.
- `Open` - open `manifest.visu` file. Can be triggered through keyboard shortcut `CTRL + O`.
- `Save` - open modal where we can choose location to save track. Can be triggered through keyboard shortcut `CTRL + S`.

On right there are five buttons:
- `Track controls` - show/hide track controls. Can be triggered through keyboard press `F4`.
- `Asset toolbar` - show/hide asset toolbar (`Event inspector` and `Templates`). Can be triggered through keyboard press `F1`.
- `Timeline` - show/hide track control panel. Can be triggered through keyboard press `F2`.
- `Brush toolbar` - show/hide brush toolbar. Can be triggered through keyboard press `F3`.
- `Fullscreen` - enable/disable fullscreen. Can be triggered through keyboard press `F11`.
  

## Asset toolbar
Contains two components:
- Event inspector - inspector for selected events on `Timeline`. Button `<play>` allows to preview selected event on grid.
- Templates - see `Templates.md`


## Track controls
Track slider can be changed with a mouse by drag & drop. Buttons:
 - Timestamp - show current track time.
 - Previous - rewind track 5 seconds in past.
 - Play - start playing the track. Can be trigerred through keyboard press `SPACE`.
 - Pause - stop playing the track. Can be trigerred through keyboard press `SPACE`.
 - Next - rewind track 5 seconds in future.
 - Snap - when enabled it will align new events to the timeline BPM and Sub.
 - `+` - zoom out the timeline view
 - `-` - zoom in the timeline view
 - `B` - set timeline tool to `Brush`, when brush is selected from `Brush toolbar` then you can create events on timeline with this tool by using mouse left click. Use mouse right click on events to remove them. Tool can be selected through keyboard press `B`.
 - `E`- set timeline tool to `Erase`, you can remove events from timeline with this tool by using mouse left click. Tool can be selected through keyboard press `E`.
 - `C`- set timeline tool to `Clone`, when event is selected on `Timeline` then you can clone it on timeline with this tool by using mouse left click. Use mouse right click on events to remove them. Tool can be selected through keyboard press `C`.
 - `S`- set timeline tool to `Select`, you can select event on timeline with this tool by using mouse left click. Use mouse left click on empty area on timeline to deselect the event. Use mouse right click on events to remove them. Tool can be selected through keyboard press `S`.


## Timeline
Contains:
 - add channel form - define a name and press `Add` button to add channel
 - ruler - use mouse to drag and drop the pointer in order to rewind the track
 - channel list - to remove channel press `<trash>` button. If you want to mute channel (ignore events while playing the track, then press `<mute>` button. Channels can be rearranged by drag & drop.
 - events - use tools from `Track Controls` to manipulate events. Despite that you can drag and drop events to change their position.


## Brush toolbar
Contains:
- Category - list of available brush categories.
- Type - list of availables types for selected category.
- Brushes - list of available brushes of selected category and type. Brushesh can be rearranged by drag & drop.
- Brush inspector - edit brush.
- Preview button - press to preview selected brush.
- Save button - save brush in game (not in file system!).
See `Brush toolbar.md`.

## Status bar
- FPS - display frames per second (max 60).
- Timestamp - current track position.
- Duration - track length.
- BPM - text field (mouse left click to edited) of beats per minute in song.
- Sub - text field (mouse left click to edited) of how many beats are in one beat.
- Gamemode - button (mouse left click to change) that shows current gamemode.
- Autosave - button that controls autosave feature