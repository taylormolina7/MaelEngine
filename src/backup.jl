using ImageView, Images   # TestImages  just a reminder poop stinks!
#
#img = load("/home/travis/Documents/Mael Engine/sprites/cloud.png")
cloud = load("/home/travis/Documents/Mael Engine/sprites/cloud.png")
cloud2 = load("/home/travis/Documents/Mael Engine/sprites/cloud2.png")
LeftPlayer = load("/home/travis/Documents/Mael Engine/sprites/leftplayer.png")
MiddlePlayer = load("/home/travis/Documents/Mael Engine/sprites/middleplayer.png")
img = fill(RGBA(0.65625,0.796875,1,1), 500, 800)


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
# This draws a pixel with Alpha chanel
# ==============================================================================
function pixel(image, X, Y, color )
    a = alpha(color)
    width, height = size(image)
    if X>0 && X < width && Y>0 && Y < height
        image[ X,Y ] = image[ X,Y ]*(1-a) + (color*a)
    end
end

rect(img, 200, 400, 150, 25, RGBA(0.65,0,0.5, 0.5) )
drawSprite(img, LeftPlayer, 400, 274, 2)
drawSprite(img, MiddlePlayer, 401, 477, 2)
rect(img, 0, 0, 50, 50, RGBA(0.65,0,0.5, 0.5) )

rect(img, 300, 410, 150, 25, RGBA(0.72,0.65,0.5, 0.8) )
# line(img, 100, 200, 250, 275, RGB(0,0.3,0.5))
drawSprite(img, cloud, 100, 100)backup
drawSprite(img, cloud, 100, 600)

drawSprite(img, cloud2, 100, 400)
drawSprite(img, cloud, 150, 200)
imshow(img)


#  type Player
#  	sprite::Sprite
#  	velocity::Vector2f
#  end
