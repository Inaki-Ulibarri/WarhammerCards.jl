module WarhammerCards

export Card, makeCard, greet
import Luxor
using Luxor

struct Card
    title :: String
    body :: String
    pcolor :: String
    scolor :: String
    bimage :: String # path to background image
end


function makeCard(card :: Card, r)
    w, h = 600, 800
    Drawing(w, h, card.title * ".png")
    origin()
    # chanfers
    setcolor(card.scolor) 
    squircle(O, w/2, h/2, action = :fill, rt = r)
    # background
    bgw, bgh = w-100, h-100
    setcolor(card.pcolor)
    squircle(O, bgw/2, bgh/2, action = :fill, rt = r)
    squircle(O, bgw/2, bgh/2, action = :clip, rt = r)
    img = readpng(card.bimage) 
    placeimage(img, O, 0.2, centered = true)
    # title
    tbw, tbh = bgw, 180
    setcolor(0, 0, 0, 0) # don't write into the canvas, just get dimesions
    bbox = BoundingBox(box(Point(0, -bgh/2 + tbh/2), tbw, tbh))
    (fs, l, fp) = textfit(card.title, bbox)
    setcolor("grey7")
    fontsize(fs) # actually write into the canvas
    text(card.title, Point(0, -h/2+50+100), halign = :center, valign = :center) 
    setline(6)
    line(Point(-w/2+50, -h/2+50+tbh), Point(w/2-50, -h/2+50+tbh), action = :stroke)
    finish()
end

greet() = print("Hello World!")

end # module WarhammerCards
