# Hexrays Decompiler Server
Simple ruby/sinatra server for IDA/Hexrays.<br />
Supports uploading PE or IDB.<br />

# Usage
1. Install IDA/Hexrays in Wine.
2. Update main.rb to point to your installation path.
3. Run with "ruby main.rb -o 0.0.0.0 -p 8888"
4. Browse to "http://<yourip>:8888/upload"

# Screenshots with putty.exe
![Upload](/linuxgeek247/hexrays_server/screenshots/upload.png?raw=true)
![Results](/linuxgeek247/hexrays_server/screenshots/result.png?raw=true)
