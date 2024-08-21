<div align="center">
<h1>2D Game Using Godot 4 Game Engine</h1>
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
- [Dynamic camera](#dynamic-camera)
- [Placing collectables](#placing-collectables)
- [Project settings](#project-settings)
- [Keep track of collectables](#keep-track-of-collectables)
- [Extend game level, add finish](#extend-game-level-add-finish)
- [Displaying points in UI](#displaying-points-in-ui)
- [Creating 2nd level](#creating-2nd-level)
- [Main menu UI in your Godot game](#main-menu-ui-in-your-godot-game)
- [Scene transition](#scene-transition)
- [Health points](#health-points)
- [Enemies](#enemies)

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
- For falling animation add falling image and add condition in `main.tscn`
    ```gd
	# Falling animation
    if velocity.y>0:
        animated_sprite_2d.animation="fall"
    ```
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

### Dynamic camera
- Add `Camera2D` child in `CharacterBody2D`
- Now add the pointer to the character
- To make the camera movement smoother turn on smooth positioning

    [⬆️ Go to top](#context)

### Placing collectables
- Add collectables fruit from asset
- Create animation using `AnimatedSprite2D` & `CollisionShape2D`
- Save as scene
- Add fruit in the game

### Project settings
- Adjust aspect ratio full screen in project setting window stretch mode to `canvas_item` and aspect `expand`

    [⬆️ Go to top](#context)

### Keep track of collectables
- Click on `collectable.tscn` and add `gdscript`
- Remove everything except  `extends Area2D` from `gdscript` and click on `collectable`
- This will show option on the right where node signals list will be shown
- Double click on `on_body_entered` signal
- Now add condition for when player collide with collectable it will vanish
    ```gd
    extends Area2D

    func _on_body_entered(body: Node2D) -> void:
        if body.name == "CharacterBody2D":
            queue_free()
    ```
- Game Manager
    - To keep track of collecting point create new node `GameManager`
    - Click on `GameManager` and create `gdscript`
    - Add point count functionality
        ```gd
        extends Node

        var points=0
        func add_point():
            points+=1
            print(points)
        ```
    - Now right click on `GameManager` node and click on `access as unique name`
    - Now drag and drop `GameManager` while holding ctrl in `collectable.gd` and modify the function to count when collide
        ```gd
        @onready var game_manager: Node = %GameManager
        func _on_body_entered(body: Node2D) -> void:
            if body.name == "CharacterBody2D":
                queue_free()
                game_manager.add_point()
        ```

    [⬆️ Go to top](#context)

### Extend game level, add finish
- Extend scene by editing `TileMapLayer`
- To end the level add trophy from the asset
- Create new `Area2D` node with two child node `Sprite2D` and `CollisionShape2D`
- Adjust the size and place it

    [⬆️ Go to top](#context)

### Displaying points in UI
- Create a new node `CanvasLayer` to show the point always on the screen
- Add a simple `panel` for background of the point
- Adjust the size and stick it to the corner using anchor preset
- Add new child node `label` in `panel` node for displaying text
- Adjust size,anchor preset alignment of the label
- To modify the text of the level when player collide with fruit, add `PointsLabel` to `access as unique name`
- Drag and drop `PointsLabel` in `game_manager.gd` with ctrl holding and modify as below
    ```gd
    extends Node
    @onready var poinst_label: Label = %PoinstLabel
    var points=0
    func add_point():
        points+=1
        poinst_label.text = "Points: " + str(points)
        print(points)
    ```

    [⬆️ Go to top](#context)

### Creating 2nd level
- Duplicate `main.tscn` and rename it to `level1.tscn` and duplicated one to `level2.tscn`
- Move these two to `scenes` directory
- Now edit `level2.tscn` to design new level
- Make sure to add `physics layer 0` in `TileSet` for new collide
- To test the new level set it as main scene by right clicking on `level2.tscn`

    [⬆️ Go to top](#context)

### Main menu UI in your Godot game
- Make new scene right clicking on `scene` directory
- Name it `main_menu.tscn`
- Create 2 new node `TextureRect`
- One is for background image and another is for game title
- Create 2 `button` node and place it below title as `level 1` & `level 2`
- Set `main_menu.tscn` as main scene by right clicking on it

    [⬆️ Go to top](#context)

### Scene transition
- Scene transition from main menu
    - When in main menu there is two button 1 & 2
    - Create a main menu gdscript
    - Now while selecting `main_menu.gd` click on level 1 button and add `pressed()` signal. do the same for level 2 button
    - Now to change scene add `get_tree().change_scene_to_file("res://scenes/level1.tscn")`
- Now when player in level 1 and touch the trophy it will go to level 2 and when in level 2 it will go to main menu
    - Create gdscript for `finish.tscn`
    - Now in `finish.gd` create `body_entered` signal with below code
        ```gd
        extends Area2D
        @export var target_level: PackedScene

        func _on_body_entered(body: Node2D) -> void:
            if body.name == "CharacterBody2D":
                call_deferred("_change_scene")

        func _change_scene() -> void:
            get_tree().change_scene_to_packed(target_level)
        ```
- Now go to level 1 and select the trophy, on the right side there will be `target level` select level 2
- Now in level 2 select main menu or just drag and drop `main_menu.tscn`

    [⬆️ Go to top](#context)

### Health points
- Download heart asset from [itch.io](https://disven.itch.io/pixel-icons-and-game-controller-2)
- To edit/crop use [Aseprite](https://github.com/aseprite/aseprite)
- Add `heart.png` in res
- Create `Panel` node inside that create `TextureRect`
- Now align heart using another node by selecting three of the heart `Reparent to new node` and select `HBoxContainer` node

    [⬆️ Go to top](#context)

### Enemies
- Download enemies asset from [itch.io](https://pixelfrog-assets.itch.io/pixel-adventure-2)
- Add `Mushroom` enemy asset in res directory
- Create new node `RigidBody2D` inside that create 2 more node `AnimatedSprite2D` where frame will be adjust and another node `CollisionShape2D` for collide
- Now save it as `Scene`
- Now drag and drop `enemy.tscn` to the map

    [⬆️ Go to top](#context)
