sub Init()
    m.sideBarBttns = m.top
    m.buttoninfos = [
        {
            name: "Live",
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_fast_forward-100.png"
        },
        {
            name: "Artists",
            icon: "https://cdn0.iconfinder.com/data/icons/party2-3/64/Concert-music-rock-singer-100.png"
        },
        {
            name: "Podcasts",
            icon: "https://cdn1.iconfinder.com/data/icons/celebrity-superstars/48/celebrity_-_singer-100.png"
        },
        {
            name: "Favourites",
            icon: "https://cdn0.iconfinder.com/data/icons/music-instrument-7/48/music_-_vinyl_record0A-100.png"
        },
        {
            name: "Settings",
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_equalizer-100.png"
    }]

    m.sideBarBttns.observeField("buttonSelected", "buttonObserver")
    m.sideBarBttns.buttonFocused = m.top.GetScene().choosedButtonId
    m.sideBarBttns.minWidth = 300
    setUpSideBarChildren()
end sub

function setUpSideBarChildren()
    children = []
    for each btncont in m.buttoninfos
        buttonvar = CreateObject("roSGNode", "Button")
        buttonvar.text = btncont.name
        buttonvar.iconUri = btncont.icon
        buttonvar.focusedIconUri = btncont.icon
        buttonvar.height = 64
        buttonvar.minWidth = m.top.minWidth
        buttonvar.translation = [50, 0]
        children.Push(buttonvar)
    end for
    m.sideBarBttns.appendChildren(children)

end function

function buttonObserver()
    ' observer for OK button
    category_id = m.sideBarBttns.buttonSelected
    if category_id = 3
        FavoritesSelected()
    else if category_id <> 4
        OnButtonBarItemSelected(category_id)
    end if
end function

sub FavoritesSelected()
    contentFav = CreateObject("roSGNode", "ContentNode")
    contentFav.AddFields({
        HandlerConfigGrid: {
            name: "FavContentHandler"
        }
    })
    customRowList = m.top.GetScene().mainCustomRowList
    customRowList.content = contentFav
    customRowList.findNode("contentGrid").jumpToRowItem = [0, 0]
    customRowList.setFocus(true)
end sub

sub OnButtonBarItemSelected(id as integer)
    ' This is where you can handle a selection event
    itemSelected = id
    buttonAA = [
        "Live",
        "Artists",
        "Podcasts"
    ]
    mode = buttonAA[itemSelected]
    ' Creation new custom view
    customRowList = m.top.GetScene().mainCustomRowList
    customRowList.content = m.top.GetScene()[mode]
    customRowList.findNode("contentGrid").jumpToRowItem = [0, 0]
    customRowList.setFocus(true)
    ' m.top.GetScene().ComponentController.CallFunc("show", {
    '     view: customView
    ' })
end sub