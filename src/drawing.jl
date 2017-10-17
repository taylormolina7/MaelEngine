using ImageView, Images   # TestImages  just a reminder poop stinks!
using Gtk.ShortNames

grid, frames, canvases = canvasgrid((1,1))  # 1 row, 2 columns




#
#img = load("/home/travis/Documents/Mael Engine/sprites/cloud.png")
cloud = load("/home/travis/Documents/Mael Engine/sprites/cloud.png")
cloud2 = load("/home/travis/Documents/Mael Engine/sprites/cloud2.png")
LeftPlayer = load("/home/travis/Documents/Mael Engine/sprites/leftplayer.png")
MiddlePlayer = load("/home/travis/Documents/Mael Engine/sprites/middleplayer.png")
img = fill(RGBA(0.65625,0.796875,1,1), 500, 800)

imshow(canvases[1,1], img )
#win = @Window(canvas, "Grinding Gears", 500, 800)

win = Window(grid, "Grinding Gears", 800, 500)
showall(win)
# ==============================================================================
# This draws a line to a picture!
# ==============================================================================
function line(image, x1, y1, x2, y2, color)
        dx, dy = x2-x1,  y2-y1

        for x in x1:x2
              y = y1 + dy * (x - x1) / dx
              image[ round(Int32, y), round(Int32, x) ] = color
        end
end
# ==============================================================================
# This draws a rectrangle to a picture!
# ==============================================================================
function rect(image, left, top, width, height, color)
    for y in 1:height, x in 1:width
        pixel(image, top+y, left+x, color )
    end
end
# ==============================================================================
function clearScreen(image, color)
    height, width = size(image)
    for y in 1:height, x in 1:width
        image[ y, x ] = color
    end
end
# ==============================================================================
# This draws a rectrangle to a picture! 1="centered" 2= topCenter
# ==============================================================================
function drawSprite(image, sprite, x, y, position=1)
    # width, height = size(image)
    SpHeight, SpWidth = size(sprite)
    if position==1
        cx,cy = round(Int32, SpWidth/2), round(Int32, SpHeight/2)
    elseif  position==2
        cx,cy = round(Int32, SpWidth/2), SpHeight
    elseif position==3
        cx,cy = round(Int32, SpWidth/2), 0
    end
    left, top = x-cy, y-cx

    for y in 1:SpWidth,  x in 1:SpHeight
        pixel(image, left+x, top+y, sprite[ x, y ] )
    end
end
# ==============================================================================
function drawSprite(image, sprite) # sprite.image, sprite.x, sprite.y, sprite.position=1
    SpHeight, SpWidth = size(sprite.image)
    if sprite.position==1
        cx,cy = round(Int32, SpWidth/2), round(Int32, SpHeight/2)
    elseif  sprite.position==2
        cx,cy = round(Int32, SpWidth/2), SpHeight
    elseif sprite.position==3
        cx,cy = round(Int32, SpWidth/2), 0
    end
    left, top =  sprite.y-cy, sprite.x-cx

    for y in 1:SpWidth,  x in 1:SpHeight
        pixel(image, left+x, top+y, sprite.image[ x, y ] )
    end
end
# ==============================================================================
# This draws a pixel with Alpha chanel
# ==============================================================================
function pixel(image, X, Y, color )
    a = alpha(color)
    width, height = size(image)
    if X>0 && X < width && Y>0 && Y < height
        image[ X,Y ] = image[ X,Y ]*(1-a) + (color*a)
    end
end
# ==============================================================================
# This calculates the positions of all sprites draws them.
# ==============================================================================
function Paint(spritList)
     height, width  = size(img)
    clearScreen(img, RGBA(0.65625,0.796875,1,1))
    for sprit in spritList
        drawSprite(img, sprit)
        if sprit.direction == 0
        elseif sprit.direction == 1
            if sprit.x < width
                sprit.x += 4
            else
                sprit.direction =2
            end
        elseif sprit.direction == 2
            if sprit.x > 0
                sprit.x -= 4
            else
                sprit.direction = 1
            end
        elseif sprit.direction == 3
            if sprit.y < height
                sprit.y += 4
            else
                sprit.direction =4
            end
        elseif sprit.direction == 4
            if sprit.y > 0
                sprit.y -= 4
            else
                sprit.direction = 3
            end
        end
    end
    imshow(canvases[1,1], img)
end
# ==============================================================================
# Data structure to hold sprites
# ==============================================================================
mutable struct Sprite
    image           # Image or image class. for example it could be mario but mario could change depending on what he is doing
    x::Int          # Coordinates
    y::Int          # Coordinates
    direction::Int  # direction of movement.
    movement::Int   # Type of movement: walk, jump, float, fall...
    position::Int   # the positioning: centered, above, below...
end
# ==============================================================================


spritelist = []

push!(spritelist, Sprite(cloud, 100, 100, 1, 3, 2) )
push!(spritelist, Sprite(cloud, 100, 600, 1, 3, 2) )
push!(spritelist, Sprite(cloud2, 100, 400, 2, 3, 2) )
push!(spritelist, Sprite(cloud, 150, 200, 1, 3, 2) )

push!(spritelist, Sprite(LeftPlayer, 100, 150, 1, 3, 2) )
push!(spritelist, Sprite(LeftPlayer, 200, 150, 1, 3, 2) )
# mario = Sprite(LeftPlayer, 100, 150, 1, 3, 2)
# push!(spritelist, mario)

# key events in GTK -> gdk.jl
const Left = 0xff51
const Up = 0xff52
const Right = 0xff53
const Down = 0xff54

signal_connect(win, "key-press-event") do widget, event
    if event.keyval == Left
        spritelist[5].direction = 2
    elseif event.keyval == Up
        spritelist[5].direction = 4
    elseif event.keyval == Right
        spritelist[5].direction = 1
    elseif event.keyval == Down
        spritelist[5].direction = 3
    end
    if event.keyval == 97
        spritelist[6].direction = 2
    elseif event.keyval == 119
        spritelist[6].direction = 4
    elseif event.keyval == 100
        spritelist[6].direction = 1
    elseif event.keyval == 115
        spritelist[6].direction = 3
    end
    print(event.keyval)
end
signal_connect(win, "key-release-event") do widget, event
    #c = Char(event.keyval)
 # println("You released key $(c)") #.keyval
end

u1 = Timer(u1 -> Paint(spritelist), 0.0003, 0.001)
