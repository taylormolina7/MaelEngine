using ImageView, Images   # TestImages  just a reminder poop stinks!
using Gtk.ShortNames

grid, frames, canvases = canvasgrid((1,1))  # 1 row, 2 columns
img = fill(RGBA(0.65625,0.796875,1,1), 500, 800)
imshow(canvases[1,1], img)
win = Window(grid)
showall(win)
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
# This draws a rectrangle to a picture!
# ==============================================================================
function rect(image, left, top, width, height, color)
    for y in 1:height, x in 1:width
        pixel(image, top+y, left+x, color )
    end
end
# ==============================================================================
# This draws random rectrangles!
# ==============================================================================
function RandomPaint()
    left, top = rand( 1:800), rand( 1:500)
    rect(img, left, top,
              rand( 1:300), rand( 1:300),
              rand(RGBA{Float32})  )
    imshow(canvases[1,1], img)
end


u1 = Timer(u1 -> RandomPaint(), 0.01, 0.1)


#imshow(canvases[1,2], testimage("mandrill"))
#win = Window(grid)
# showall(win)
