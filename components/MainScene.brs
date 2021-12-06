sub Show(args as object)

    setUpCustomViewContent()
    setUpSideBar()

    m.top.ComponentController.CallFunc("show", {
        view: m.top.findNode("idCustomView")
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
    customView = m.top.findNode("idCustomView")
    customView.findNode("contentGrid").observeField("itemSelected", "SelectedHandler")

    contentLive = CreateObject("roSGNode", "ContentNode")
    contentLive.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: "Live"
        }
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
    customView.contentsDict = {
        Live: contentLive,
        Podcasts: contentPodcasts,
        Artists: contentArtists
    }
    customView.query = "Live"
end function

function SelectedHandler(event as object)
    ' METHOD FOR HANDLING SELECTED NODE
    RowList = m.top.findNode("idCustomView")
    customRowListElement = RowList.findNode("contentGrid")
    item = RowList.content.GetChild(customRowListElement.rowItemSelected[0]).GetChild(customRowListElement.rowItemSelected[1])

    if item.streamUrl <> invalid
        videoContent = createObject("RoSGNode", "ContentNode")
        videoContent.url = item.streamUrl
        videoContent.title = item.TITLE
        videoContent.streamformat = "hls"

        video = createObject("RoSGNode", "CustomVideo")
        video.content = videoContent
        video.control = "play"
        video.pourl = item.HDPOSTERURL

        m.top.FindNode("leftSideBar").visible = false
        m.top.FindNode("channelName").visible = false

        m.top.ComponentController.CallFunc("show", {
            view: video
        })
    else
        dialog = createObject("roSGNode", "Dialog")
        dialog.title = "Error"
        dialog.optionsDialog = true
        dialog.message = "Sorry but we cant play it now, Press * To Dismiss"
        m.top.dialog = dialog
    end if
end function

' SETTING UP SIDE BAR
function setUpSideBar()
    sideBar = m.top.findNode("leftSideBar")
    sideBar.content = SetUpSideBarContent()
    sideBar.observeField("itemSelected", "SideBarItemSelectedObserver")
end function

function SetUpSideBarContent() as object
    buttoninfos = [
        {
            name: "Live",
            focus: true,
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_fast_forward-100.png"
        },
        {
            name: "Artists",
            focus: false,
            icon: "https://cdn0.iconfinder.com/data/icons/party2-3/64/Concert-music-rock-singer-100.png"
        },
        {
            name: "Podcasts",
            focus: false,
            icon: "https://cdn1.iconfinder.com/data/icons/celebrity-superstars/48/celebrity_-_singer-100.png"
        },
        {
            name: "Settings",
            focus: false,
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_equalizer-100.png"
    }]
    sideBarContent = CreateObject("roSGNode", "ContentNode")

    for each btncont in buttoninfos
        btnNode = Utils_AAToContentNode(btncont)
        sideBarContent.appendChild(btnNode)
    end for

    return sideBarContent
end function

function SideBarItemSelectedObserver(event as object)
    itemSelectedID = event.getData()
    if itemSelectedID <> 3
        buttonAA = [
            "Live",
            "Artists",
            "Podcasts"
        ]
        customRowList = m.top.findNode("idCustomView")
        customRowList.query = buttonAA[itemSelectedID]
        customRowList.setFocus(true)
    end if
end function
