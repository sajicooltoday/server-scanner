# Server Scanner

> [!IMPORTANT]
> Script is discontinued due to me working on other projects and i cant maintain like 500 things so yea. fork, modify, edit, use for your own projects, just give credits to me. I will use a modified version of this script for onyx which is maintained.

Scans the game to recreate the server hierarchy of the roblox game via methods and recreates the hierarchy with Instance new so you can view the found stuff in any explorer or log to a file.

Will be reused and improved for [Onyx](https://github.com/sajicooltoday/onyx-suite)!

- Minimalistic cli window ui
- File logging (.txt)
- Optimized & speedy
  - optimized as much as it can but a bad device will probably cause problems
  - usually fast process for good devices (can take a while, thats why file logging exists)
- Methods
  - methods can be easily plugged in & out for modification

---

- moduleScan (method)
  - scans every module script in the game to find server references (such as game.ServerScriptService.ExampleScript in the module script)
  - reason: many modern games have module scripts inside of replicated storage or somewhere that is supposed to be required on the server, and leaks script locations/paths

- remotefunctionFuzz (method)
  - fuzzes every remote function in the game with random meaningless arguments and catch any error it returns (the error will contain the script path and it will be extracted with xpcall)
  - reason: almost every stable game uses remote functions that are avaliable to the client, fuzzing them for error script paths can recreate alot of scripts

---

- How to implement methods:
  - add a .luau file to methods, prefer camelCase for naming
  - make sure it returns a table containg the clear dotted path of instances to recreate
  - example: `game.ServerScriptService.GameHandler`
  - add it to the readme

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
