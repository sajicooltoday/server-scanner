# Server Scanner

Scans the game to recreate the server hierarchy of the roblox game via methods and recreates the hierarchy with Instance new so you can view the found stuff in any explorer or log to a file.

Will be reused and improved for [Onyx](https://github.com/sajicooltoday/onyx-suite)!

- Minimalistic cli window ui
- Optimized & speedy
  - optimized as much as it can but a bad device will probably cause problems
  - usually fast process for good devices (can take a while, thats why file logging exists)
- File logging (.txt)
- Methods
  - methods can be easily plugged in & out for modification
  - guide to implement your own methods exists inside the source code above the methods table
  - moduleScan: scans every module script in the game to find server referecens (such as game.ServerScriptService.GameHandler)

> [!WARNING]
> This will not, and can not give you the source code or bytecode of the scanned scripts or modulescripts due to filtering enabled. However you can recreate the scripts source with a decent accuracy by using AI, this will be implemented in [Onyx](https://github.com/sajicooltoday/onyx-suite).

## Prerequisites

To enhance your work environment, I recommend installing all the recommended [extensions](.vscode/extensions.json).

## Bundling everything

> [!IMPORTANT]
> Bundling should only be used for testing.
> If you want to make a new Release, please head to the GitHub "Actions" tab and run the "Release" action.

To bundle all the scripts, you have to follow these steps:

1. Install [rokit](https://github.com/rojo-rbx/rokit) if you haven't already
2. Open Powershell or the command-line shell of your liking and [cd to this repository](https://www.quora.com/What-does-it-mean-to-CD-into-a-directory-and-how-can-I-do-that-Can-someone-explain-it-in-a-laymans-term)
3. Run `rokit install` and wait for it to install all the dependencies
4. In VSCode, press CTRL + SHIFT + B to build or run this command `lune run Build bundle header=Build/Header.luau`

You can find the bundled script in '/Distribution/Script.luau'. If any issues occur or you are having troubles with the steps [open a Issue on this repository](https://github.com/user/repo/issues).
