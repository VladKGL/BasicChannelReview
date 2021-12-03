sub Show(args as object)

    setUpCustomViewContent()
    setUpSideBar()

    m.top.ComponentController.CallFunc("show", {
        view: m.top.mainCustomRowList
    })
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ' handling left button so we set focus on row list
    if press and key = "left" and m.top.FindNode("idCustomView").isInFocusChain()
        m.top.FindNode("leftSideBar").setFocus(true)
        return true
    end if
    if (key = "right") then
        m.top.findNode("contentGrid").setFocus(true)
        return true
    end if
    return false
end function

function setUpCustomViewContent()
    customView = CreateObject("roSGNode", "CustomRowList")
    customView.id = "idCustomView"

    contentLive = CreateObject("roSGNode", "ContentNode")
    contentLive.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: "Live"
        }
    })

    customView.content = contentLive
    ' add custom view to main scene fields
    m.top.AddFields({
        mainCustomRowList: customView,
        Live: contentLive,
    })

    contentArtists = CreateObject("roSGNode", "ContentNode")
    contentArtists.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: "Artists"
        }
    })
    contentPodcasts = CreateObject("roSGNode", "ContentNode")
    contentPodcasts.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: "Podcasts"
        }
    })
    m.top.AddFields({
        Podcasts: contentPodcasts,
        Artists: contentArtists
    })
end function

function setUpSideBar()
    sideBar = m.top.findNode("leftSideBar")
    sideBar.content = SetUpSideBarContent()
    sideBar.observeField("itemSelected", "SideBarItemObserver")
end function

function SetUpSideBarContent() as object
    buttoninfos = [
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
            name: "Settings",
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_equalizer-100.png"
    }]
    sideBarContent = CreateObject("roSGNode", "ContentNode")

    for each btncont in buttoninfos
        btnNode = Utils_AAToContentNode(btncont)
        sideBarContent.appendChild(btnNode)
    end for

    return sideBarContent
end function

function SideBarItemObserver(event as object)
    itemSelectedID = event.getData()
    if itemSelectedID <> 3
        buttonAA = [
            "Live",
            "Artists",
            "Podcasts"
        ]
        mode = buttonAA[itemSelectedID]
        customRowList = m.top.mainCustomRowList
        customRowList.content = m.top[mode]
        customRowList.findNode("contentGrid").jumpToRowItem = [0, 0]
        customRowList.setFocus(true)
    end if
end function