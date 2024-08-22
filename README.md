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
- [Character Movement Tweaks](#character-movement-tweaks)
- [Input Map](#input-map)
- [Dynamic Camera](#dynamic-camera)
- [Placing Collectables](#placing-collectables)
- [Project Settings](#project-settings)
- [Keep Track of Collectables](#keep-track-of-collectables)
- [Extend Game Level, Add Finish](#extend-game-level-add-finish)
- [Displaying Points in UI](#displaying-points-in-ui)
- [Creating 2nd Level](#creating-2nd-level)
- [Main Menu UI](#main-menu-ui)
- [Scene Transition](#scene-transition)
- [Health Points I](#health-points)
- [Enemies I](#enemies)
- [Level 3 with Traps (falling ground)](#level-3-with-traps-falling-ground)
- [Enemies II](#enemies-ii)
- [Pause Menu](#pause-menu)
- [Health Points II](#health-points-ii)

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

### Character Movement Tweaks
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

### Input Map
- Go to project setting and setup input map
- After setting keys in input map just replace those name in project `main.tscn`

    [⬆️ Go to top](#context)

### Dynamic Camera
- Add `Camera2D` child in `CharacterBody2D`
- Now add the pointer to the character
- To make the camera movement smoother turn on smooth positioning

    [⬆️ Go to top](#context)

### Placing Collectables
- Add collectables fruit from asset
- Create animation using `AnimatedSprite2D` & `CollisionShape2D`
- Save as scene
- Add fruit in the game

### Project Settings
- Adjust aspect ratio full screen in project setting window stretch mode to `canvas_item` and aspect `expand`

    [⬆️ Go to top](#context)

### Keep Track of Collectables
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

### Extend Game Level, Add Finish
- Extend scene by editing `TileMapLayer`
- To end the level add trophy from the asset
- Create new `Area2D` node with two child node `Sprite2D` and `CollisionShape2D`
- Adjust the size and place it

    [⬆️ Go to top](#context)

### Displaying Points in UI
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

### Creating 2nd Level
- Duplicate `main.tscn` and rename it to `level1.tscn` and duplicated one to `level2.tscn`
- Move these two to `scenes` directory
- Now edit `level2.tscn` to design new level
- Make sure to add `physics layer 0` in `TileSet` for new collide
- To test the new level set it as main scene by right clicking on `level2.tscn`

    [⬆️ Go to top](#context)

### Main Menu UI
- Make new scene right clicking on `scene` directory
- Name it `main_menu.tscn`
- Create 2 new node `TextureRect`
- One is for background image and another is for game title
- Create 2 `button` node and place it below title as `level 1` & `level 2`
- Set `main_menu.tscn` as main scene by right clicking on it

    [⬆️ Go to top](#context)

### Scene Transition
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

### Health Points I
- Download heart asset from [itch.io](https://disven.itch.io/pixel-icons-and-game-controller-2)
- To edit/crop use [Aseprite](https://github.com/aseprite/aseprite)
- Add `heart.png` in res
- Create `Panel` node inside that create `TextureRect`
- Now align heart using another node by selecting three of the heart `Reparent to new node` and select `HBoxContainer` node

    [⬆️ Go to top](#context)

### Enemies I
- Download enemies asset from [itch.io](https://pixelfrog-assets.itch.io/pixel-adventure-2)
- Add `Mushroom` enemy asset in res directory
- Create new node `RigidBody2D` inside that create 2 more node `AnimatedSprite2D` where frame will be adjust and another node `CollisionShape2D` for collide
- Now save it as `Scene`
- Now drag and drop `enemy.tscn` to the map

    [⬆️ Go to top](#context)

### Level 3 with Traps (falling ground)
- Duplicate `level2.tscn` and rename it to `level3.tscn`
- Edit and create new design with falling ground
- Now create new node `Area2D` and `CollisionShape2D`
- Select `CollisionShape2D` node and choose `WorldBoundaryShape`
- Adjust the shape
- Now create a gdscript on `Area2D` node
- In gdscript write the following to reload the current scene when player fall
    ```gd
    extends Area2D

    func _on_body_entered(body: Node2D) -> void:
        get_tree().reload_current_scene()
    ```

    [⬆️ Go to top](#context)

### Enemies II
- To make the enemy collide with player we have to create another `Area2D` node and inside that `CollisionShape2D` node
- Now adjust the size of `CollisionShape2D` rectangle shape
- Attach script to the Root node `Enemy`
- Add `body_entered` signal of `Area2D` node inside script
    ```gd
    extends RigidBody2D

    func _on_area_2d_body_entered(body: Node2D) -> void:
        if body.name == "CharacterBody2D":
            var y_delta=position.y-body.position.y
            if y_delta>47:
                print("Destroy Enemy ",y_delta)
                queue_free()
                body.jump()
            else:
                print("Health Decrease ",y_delta)
                body.queue_free()
    ```
    - Here `y_delta` indicate where player is collide with enemy body
    - According to the value condition are made
    - `queue_free()` means enemy body disappeared
    - `body.queue_free()` means player body disappeared

    [⬆️ Go to top](#context)

### Pause Menu
- Create a new `Node` in UI root node
- In that node create `Panel` node
- Make the panel preset full rect
- Now create another node `VBoxContainer`
- Inside `VBoxContainer` node add 2 button `Resume_btn` and `Main_menu_btn`
- Adjust the size
- Now hide the `PausePanel` node and attach a script in `Pause` node
- Inside `_process` function get the input
    - `var esc_pressed = Input.is_action_just_pressed("pause")`
- Now check if `esc_pressed` is pressed with condition
    ```gd
    if esc_pressed:
        get_tree().paused = true
        pause_panel.show()
    ```
    - Here `pause_panel` is the `PausePanel` node where we make it unique name first and than drag and drop with holding ctrl button
- To make it work we need to set the input map from project setting and add new key for `pause` and the `Esc` key
- Now add two signal for each of the buttons on pressed signal
    ```gd
    func _on_resume_btn_pressed() -> void:
        print("pressed resume")
        pause_panel.hide()
        get_tree().paused = false


    func _on_main_menu_btn_pressed() -> void:
        print("pressed main_menu")
        get_tree().paused = false
        get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
    ```
- Still button press won't work cause the process is pause
- To solve this we need to select both of the button and from inspector sidebar change the process mode to `always`

    [⬆️ Go to top](#context)

### Health Points II
- In `game_manager.gd` Create a function to decrease the health
    ```gd
    var lives=3

    func decrease_health():
        lives-=1
        print(lives)
        if lives<0:
            get_tree().reload_current_scene()
    ```
- Now to include it in `enemy.gd` script drag and drop GameManager node with holding ctrl
    ```gd
    extends RigidBody2D
    @onready var game_manager: Node = %GameManager

    func _on_area_2d_body_entered(body: Node2D) -> void:
        if body.name == "CharacterBody2D":
            var y_delta=position.y-body.position.y
            if y_delta>47:
                print("Destroy Enemy ",y_delta)
                queue_free()
                body.jump()
            else:
                print("Health Decrease ",y_delta)
                #body.queue_free()
                game_manager.decrease_health()
    ```
    - Here `game_manager.decrease_health()` is calling that function we created in `game_manager.gd`
- To make the heart decrease when player collide with enemy, we need to export `Array[Node]` in `game_manager.gd` 
    - `@export var hearts: Array[Node]`
    - Now when clicking on `GameManager` node there will be heart option in inspector
    - Add three array and each will be fill-up with heart icon
    - Now Add condition to decrease heart when collide with enemy
        ```gd
        func decrease_health():
            lives-=1
            print(lives)
            for h in 3:
                if h<lives:
                    hearts[h].show()
                else:
                    hearts[h].hide()
            if lives<=0:
                get_tree().reload_current_scene()
        ```
- Now when player collide with enemy it will jump away, to do that we need to create another function in `main_character.gd`
    ```gd
    func jump_side(x):
        velocity.y=JUMP_VELOCITY
        velocity.x=x
    ```
-  In `enemy.gd` modify the function and by calculating `x_delta` and adding condition based on its value 
    ```gd
    func _on_area_2d_body_entered(body: Node2D) -> void:
        if body.name == "CharacterBody2D":
            var y_delta=position.y-body.position.y
            var x_delta=body.position.x-position.x
            print("x delta value: ",x_delta)
            if y_delta>47:
                print("Destroy Enemy ",y_delta)
                queue_free()
                body.jump()
            else:
                print("Health Decrease ",y_delta)
                #body.queue_free()
                game_manager.decrease_health()
                if x_delta>0:
                    body.jump_side(500)
                else:
                    body.jump_side(-500)
    ```

    [⬆️ Go to top](#context)
