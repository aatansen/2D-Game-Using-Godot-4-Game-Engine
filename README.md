<div align="center">
<h1>2D Game Using Godot 4</h1>
</div>

### Context
- [Scene Setup](#scene-setup)
- [Background Image](#background-image)

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
