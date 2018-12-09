# MTA-SA-LUA-GIF-SUPPORT
Script to run gif images based on sprite image of the gif.  
You can create sprite img on [this website](https://ezgif.com/gif-to-sprite).

# CREATING GIF
createGif(int x, int y, int w, int h, int verticleCount, int horizontalCount, texture / string path, int width, int height [, int speed = 500, string type = "horizontally"] )
  
**Required Arguments**  
int x - position x on the screen  
int y - position y on the screen  
int w - width on the screen  
int h - height on the screen  
int verticleCount - how many verticle img's in grid  
int horizontalCount - how many horizontal img's in grid  
texture / string path - string path to img or dxCreateTexture()  
int width - width of one grid img sprite  
int height - height of one grid img sprite  

**Optional Arguments**  
int speed - img switching speed (ms)  
string type - gif img grid type ("horizontally", "vertically", "grid")  

**Returns**  
int ID - ID of the created gif  

# REMOVING GIF  
destroyGif(int ID)
  
**Required Arguments**  
int ID - id of created GIF img  

**Returns**  
Returns true if the gif was removed succesfully, false otherwise.
