<div align="center">
<h1>2D Game Using Godot 4</h1>
</div>

### Context
- [Scene Setup](#scene-setup)
- [Background Image](#background-image)
- [TileSet (Ground design)](#tileset-ground-design)
- [Character (Player)](#character-player)

### Scene Setup
- Create new project selecting mobile renderer & Git for version controlling
- Now select other node --> Node
- Ctrl+s and name the file main.tsnc

    [⬆️ Go to top](#context)

### Background Image
- Select 2D mode as it is 2D game
- Zoom to blue border
- Three main element:
    - Background
    - Ground blocks (tileset where player will be able to walk) 
    - Character (Player)
- Get the game assets from [pixelfrog-assets](https://pixelfrog-assets.itch.io/pixel-adventure-1)
- Add a background from downloaded asset
- Click on `+` icon and add `TextureRect` node
- Now select `TextureRect` node and drag the background image to the `Texture`
- Now to fillup texture with the background image click on `anchor preset`
- To make the image look good after fillup; choose `nearest` from the `canvasItem` setting and change the `stretch mode` to `tile`

    [⬆️ Go to top](#context)

### TileSet (Ground design)
- Add `Terrain` from downloaded asset
- Right click on the parent node and select `Add Child Node` and add `TileMap` / `TileMapLayer`
- From `TileMap` setting Select `TileSet`
- Now drag and drop the `Terrain` in `TileSet`
- Now click on `TileMap` beside `TileSet`
- Change `transform` to `3` to change the view of the tile to bigger
- Now design the level

    [⬆️ Go to top](#context)

### Character (Player)
- Create a new child node `CharacterBody2D`
- Create `Sprite2D` & `CollisionShape2D` two new child in `CharacterBody2D` and import the character from the downloaded asset
- Select `CharacterBody2D` and choose shape of the character body according to its shape
- Adjust the size

    [⬆️ Go to top](#context)
