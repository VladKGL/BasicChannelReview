sub Show(args as object)
    ' Add global field for side bar
    m.top.Addfields({
        choosedButtonId: 0,
    })

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

function setUpSideBar()
    sideBar = createObject("roSGNode", "sideBar")
    sideBar.id = "leftSideBar"
    sideBar.translation = [0, 150]
    sideBar.itemSpacings = [0, 0, 300]
    m.top.appendChild(sideBar)
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


function SetUpButtonBar()
    ' NOT USING
    ' alternative way of Side Bar solution(built in with SGDEX)
    m.top.buttonBar.visible = true
    m.top.buttonBar.translation = [-100, 100]
    m.top.buttonBar.alignment = "left"
    m.top.buttonBar.overlay = true
    m.top.buttonBar.renderOverContent = true
    m.top.buttonBar.autoHide = false
    m.top.buttonBar.enableFootprint = true
    m.top.buttonBar.theme = {
        buttonColor: "#000000",

    }
    m.top.buttonBar.content = retrieveButtonBarContent()
    m.top.buttonBar.ObserveField("itemSelected", "OnButtonBarItemSelected")

    m.top.buttonBar.setFocus(true)
end function


function retrieveButtonBarContent() as object
    ' NOT USING
    ' FUNCTION FOR SGDEX BUTTON BAR
    ' alternative way of Side Bar solution(built in with SGDEX)
    buttonBarContent = CreateObject("roSGNode", "ContentNode")
    buttonBarContent.Update({
        children: [{
                title: "Live",
                id: "Live"
            }, {
                title: "Artists",
                id: "Artists"
            }, {
                title: "Podcasts",
                id: "Podcasts",
        },]
    }, true)

    return buttonBarContent
end function

sub OnButtonBarItemSelected(event as object)
    ' NOT USING
    ' FUNCTION FOR SGDEX BUTTON BAR
    ' This is where you can handle a selection event
    itemSelected = event.GetData()
    buttonAA = [
        "Live",
        "Artists",
        "Podcasts"
    ]
    mode = buttonAA[itemSelected]
    customView = CreateObject("roSGNode", "CustomRowList")
    content = CreateObject("roSGNode", "ContentNode")
    content.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: mode
        }
    })
    customView.content = content
    m.top.ComponentController.CallFunc("show", {
        view: customView
    })
end sub
