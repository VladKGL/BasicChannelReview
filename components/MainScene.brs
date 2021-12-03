sub Show(args as object)
    ' Add global field for side bar

    ' m.top.backgroundColor = "#000000"

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
