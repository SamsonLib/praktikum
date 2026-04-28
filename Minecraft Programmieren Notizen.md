# Java
## Server Level (Singleplayer)
- Man kann Blöcke, Entitys, ... überall verändern da man accesse auf die Server World bekommen kann. Dort werden Blöcke, Entities und mehr gespeichert.

## Client Level (Multiplayer)
- Man kann Blöcke, Entities, ... nicht überall verändern da man Network Packages an den Server senden muss und dieser auch nochmal überprüft ob die in ordnung sind.
	- Beispiel: Man möchte einen Block 100 Blöcke von einem selber plazieren. In Vanilla würde das nicht funktionieren deswegen würde der Server ein Packet dafür nicht annehmen.
- Ausnahme: Mods, Plugins.
	- Wenn man Mods oder Plugins installiert (auf dem Server) kann man diesen saftycheck ausschalten

## Datapacks
- Ansamlung von Minecraft commands die von Oben nach Unten ausgeführt werden.

## ScriptCraft (Plugin)
- Runtime Plugins mit JavaScript
```js
function greet( player ) {
  echo( player, 'Hello ' + player.name );
}
exports.greet = greet;
```
`/js greet(self)`

## Mineflare
- Minecraft Bots mit js
```js
const mineflayer = require('mineflayer')

const bot = mineflayer.createBot({
  host: 'localhost', // minecraft server ip
  username: 'Bot',
  auth: 'offline'
})

bot.on('chat', (username, message) => {
  if (username === bot.username) return
  bot.chat(message)
})

bot.on('kicked', console.log)
bot.on('error', console.log)
```
## Minescript
[Minescript](https://minescript.net/)
- Client Side Mod (Client Level)
- Benutzt die Programmiersprache Pyjinn (Python syntax)
- Kann Commands ausführen

```python
from minescript import (echo, execute, getblock, player)  
import sys  
  
# Get the player's position, rounded to the nearest integer:  
x, y, z = [round(p) for p in player().position]  
  
# Get the type of block directly beneath the player:  
block_type = getblock(x, y - 1, z)  
block_type = block_type.replace("minecraft:", "").split("[")[0]  
  
sign_text = (  
    """{Text1:'{"text":"%s"}',Text2:'{"text":"at"}',Text3:'{"text":"%d %d %d"}'}""" %  
    (block_type, x, y - 1, z))  
  
# Script argument, passed from Minecraft like "example 5"  
rotation = int(sys.argv[1]) if len(sys.argv) > 1 else 0  
if rotation < 0 or rotation > 15:  
  raise ValueError(f"Param not an integer between 0 and 15: {rotation}")  
  
# Create a sign then set text on it:  
execute(f"/setblock {x} {y} {z} minecraft:birch_sign[rotation={rotation}]")  
execute(f"/data merge block {x} {y} {z} {sign_text}")  
  
# Write a message to the chat that   
echo(f"Created sign at {x} {y} {z} over {block_type}")
```
## Raspberry Jam Mod
- [Github](https://github.com/arpruss/raspberryjammod)
- mcpi für jave (siehe unten)
## Eigene Mods / Plugins
- Java / Kotlin

## WorldEdit CraftScripts
- [Craftscripts](https://worldedit.enginehub.org/en/latest/usage/other/craftscripts/)
```js
importPackage(Packages.com.sk89q.worldedit.world.block);
var sess = context.remember();
sess.setBlock(player.getBlockOn().toVector().toBlockPoint(), BlockTypes.WHITE_WOOL.getDefaultState());
```
## Computer Craft (Mod)
- Fügt Computer Blöcker hinzu, die man mit lua steuern kann.
- Lua
- [Spiegel](https://www.spiegel.de/netzwelt/games/minecraft-so-kann-man-mit-dem-kultspiel-programmieren-lernen-a-1165498.html)
- ["Docs"](https://www.code-your-life.org/Praxis/Minecraft/mediabase/pdf/2642.pdf)
```lua
if turtle.detect() then
    turtle.dig()
    turtle.forward() 
end
```
## JNI
- Java Native Interface
- Man kann mit einer anderen Programmiersprache (C++, Rust, "Java", ...) Sich in Minecrafts Runtime Hooken und dort Funktionen und Methoden ausführen. Dadurch kann man wenn man im Singleplayer ist alles verändern und sonst muss man Packages senden

## PyAnvilEditor
- Editiren vom Save der Welt mit Python
- [PyAnvilEditor](https://github.com/DonoA/PyAnvilEditor)
```python
import nbt, stream, gzip

with gzip.open('level.dat', mode='rb') as level:
    in_stream = stream.InputStream(level.read())
    level_data = nbt.parse_nbt(in_stream)
    lvl_name = level_data.get("Data").get("LevelName").get()
```
# Education Edition
[Education Edition](https://education.minecraft.net/en-us/blog/new-ways-to-code-introducing-python-content-for-minecraft-education-edition)
- Eingebauter Code Editor für: JavaScript, Blöcke, Python

# Bedrock
## Websockets
- [Github](https://github.com/bedrock-ws)
- Python, Dart, JavaScript (*)
```js
import { consts, Server } from "@bedrock-ws/bedrockws";

const server = new Server();

server.on("PlayerMessage", (event) => {
  const { client, data } = event;
  if ((Object.values(consts.names) as string[]).includes(data.sender)) {
    // don't react on messages sent by the server
    return;
  }
  client.run(`say ${data.message}`);
});
```

## Scripting API
- Offiziel
- Molang (Json mit funktionen)
- [Guide](https://learn.microsoft.com/en-us/minecraft/creator/documents/learningjourneyguide?view=minecraft-bedrock-stable)

# Minecraft Raspberry Pi Edition
- mcpi
- Minecraft mit Python
```python
from mcpi import minecraft

mc = minecraft.Minecraft.create()

mc.postToChat("Hello world")

x, y, z = mc.player.getPos()
mc.setBlock(x+1, y, z, 1)
```

