# TODO: add more cards for printing
# TODO: be able to make cards for a single faction/

module WarhammerCards

export Card, makeCard, makeCards, greet
import Luxor, JSON3
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
    imgpath = pkgdir(WarhammerCards, "data", "images", card.bimage)
    img = readpng(imgpath)
    # scale(img.width/bgw, img.height/bgh)
    placeimage(img, O, 0.2, centered = true)
    # title
    setcolor("grey7")
    fontface("Vollkorn")
    tbw, tbh = bgw, 180
    tbox = BoundingBox(box(Point(0, (-bgh + tbh)/2), tbw, tbh))
    textfit(card.title, tbox; horizontalmargin = 12)
    setline(6)
    line(Point(-w/2+50, -h/2+50+tbh), Point(w/2-50, -h/2+50+tbh), action = :stroke)
    # body of the card
    bbw, bbh = bgw, bgh - tbh
    bbox = BoundingBox(box(Point(0, (bgh - bbh)/2), bbw, bbh))
    textfit(card.body, bbox, 52; horizontalmargin = 12)
    finish()
end

function cardOfDict(d)
    Card(d[:title], d[:body], d[:pcolor], d[:scolor], d[:bimage])
end

function makeCards(fname :: String)
    cards = read(fname, String)
    cards = JSON3.read(cards)
    w, h = 600, 800
    r = 0.05
    imgpath = ""
    img = nothing
    for c ∈ cards
        card = cardOfDict(c)
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
        ppath = pkgdir(WarhammerCards, "data", "images", card.bimage) # possible path
        if imgpath != ppath
            # don't load the same image twice, 
            # just if it has to be changed
            imgpath = ppath
            img = readpng(imgpath)
            # scale(img.width/bgw, img.height/bgh)        
        end
        placeimage(img, O, 0.2, centered = true)
        # title
        setcolor("grey7")
        fontface("Vollkorn")
        tbw, tbh = bgw, 180
        tbox = BoundingBox(box(Point(0, (-bgh + tbh)/2), tbw, tbh))
        textfit(card.title, tbox; horizontalmargin = 12)
        setline(6)
        line(Point(-w/2+50, -h/2+50+tbh), Point(w/2-50, -h/2+50+tbh), action = :stroke)
        # body of the card
        bbw, bbh = bgw, bgh - tbh
        bbox = BoundingBox(box(Point(0, (bgh - bbh)/2), bbw, bbh))
        textfit(card.body, bbox, 52; horizontalmargin = 12)
        finish()
    end
end

greet() = print("Hello World!")

end # module WarhammerCards
