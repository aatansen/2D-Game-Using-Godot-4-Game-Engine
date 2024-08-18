<div align="center">
<h1>2D Game Using Godot 4</h1>
</div>

### Context
- [Scene Setup](#scene-setup)
- [Background Image](#background-image)
- [TileSet (Ground design)](#tileset-ground-design)
- [Character (Player)](#character-player)
- [Creating Sub-scenes/Group/Prefab](#creating-sub-scenesgroupprefab)
- [Character Movement & Collision](#character-movement--collision)
- [Sprite Animation](#sprite-animation)
- [Character movement tweaks](#character-movement-tweaks)
- [Input map](#input-map)

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

### Creating Sub-scenes/Group/Prefab
- Right click on `CharacterBody2D` and select `Save Branch as Scene`
- Create a new folder `scenes` and save it there as `main_character.tscn`
- To edit it double click on the character

    [⬆️ Go to top](#context)

### Character Movement & Collision
- Click on `main_character.tscn` 
- Now beside `CharacterBody2D` there is a script icon with `+` sign
- Click on it and create the `GDScript`
- Now player basic movement will work
- For `Collision` we have to configure it by selecting `TileMapLayer`
- Now go to `TileSet` and select `Physics Layers`
- Click on `TileSet` and select `Physics Layer 0` from `Paint`
- Now Select those tile where player collision will happened

    [⬆️ Go to top](#context)

### Sprite Animation
- Change `Sprite2D` to `AnimatedSprite2D`
- Add Sprite Frame to new sprite frame
- Add idle,jumping,running image from downloaded asset
- Now click on `add frame from sprite sheet`
- Adjust size and save
- Make idle one default and run the game to see the movement

    [⬆️ Go to top](#context)

### Character movement tweaks
- In `_physics_process` function add condition for running and idle
    ```gd
    #Animations 
    if(velocity.x>1||velocity.x<-1):
        animated_sprite_2d.animation="running"
    else:
        animated_sprite_2d.animation="default_idle"
    ```
- In gravity add jumping animation
    ```gd
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation="jumping"
    ```
- For smooth stop change `SPEED` in `move_toward` 10 to 20 range
    ```gd
    velocity.x = move_toward(velocity.x, 0, 20)
    ```

    [⬆️ Go to top](#context)

### Input map
- Go to project setting and setup input map
- After setting keys in input map just replace those name in project `main.tscn`

    [⬆️ Go to top](#context)
