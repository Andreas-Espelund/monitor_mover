# Monitor Mover for mac

## Why 😡
Are you tired of doing this every time you connect to a new external monitor to your mac?

1. Open System Preferences
2. Click on Displays
3. Click on Arrangement
4. Drag the screens to the correct position

I am, so I made this script to do it for me.

## How 🤔
I will not take credit for the hard work of figuring out how to place the screens in the correct,
but i will take credit for making it easier to do so.

I use the [displayplacer](https://github.com/jakehilborn/displayplacer?tab=readme-ov-file)
utility to place my screens in the correct position.

This is a wrapper around the displayplacer utility that makes it possible to use as a raycast
script command, or as a more basic command line utility.

Currently this is very basic and only supports one monitor, but it
works on my machine! 🤠


## Get started 👷

Fowllow the guide from raycast on how to set up the script command [Raycast script commands](https://www.raycast.com/blog/getting-started-with-script-commands)
or run `create script command` in raycast.

```bash
# clone the repo
git clone git@github.com:Andreas-Espelund/monitor_mover.git

# install displayplacer
brew install displayplacer

# make the script executable
chmod +x place-monitor.sh

# run the script
./place-monitor.sh [layout]

```
### Valid layouts
| Layout | Description    |
|--------|----------------|
| l      | left           |
| tl     | top left       |
| t      | top            |
| tr     | top right      |
| r      | right          |
| br     | bottom right   |
| b      | bottom         |
| bl     | bottom left    |
