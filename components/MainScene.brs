sub Show(args as object)
    ' Add global field for side bar
    m.top.Addfields({
        buttondid: 0,
    })

    m.top.backgroundColor = "#000000"

    setUpCustomView()

    m.top.ComponentController.CallFunc("show", {
        view: m.top.grid
    })
end sub

function setUpCustomView()
    ' Creation of custom view where all main content will be placed
    customView = CreateObject("roSGNode", "ContentRowGrid")
    customView.id = "idCustomView"

    content = CreateObject("roSGNode", "ContentNode")
    content.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: "Live"
        }
    })

    customView.content = content
    ' add custom view to main scene fields
    m.top.AddFields({
        grid: customView
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
    customView = CreateObject("roSGNode", "ContentRowGrid")
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
