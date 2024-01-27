# TODO: add reading card info from json files

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
    setcolor("grey7")
    fontface("URWBookman")
    tbw, tbh = bgw, 180
    tbox = BoundingBox(box(Point(0, (-bgh + tbh)/2), tbw, tbh))
    textfit(card.title, tbox)
    setline(6)
    line(Point(-w/2+50, -h/2+50+tbh), Point(w/2-50, -h/2+50+tbh), action = :stroke)
    # body of the card
    bbw, bbh = bgw, bgh - tbh
    bbox = BoundingBox(box(Point(0, (bgh - bbh)/2), bbw, bbh))
    textfit(card.body, bbox, 52; horizontalmargin = 12)
    finish()
end

greet() = print("Hello World!")

end # module WarhammerCards
