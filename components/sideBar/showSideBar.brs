sub Init()
    m.sideBarBttns = m.top
    m.sideBarBttns.buttons = ["Live", "Artists", "Podcasts", "Settings"]
    m.sideBarBttns.observeField("buttonSelected", "buttonObserver")
    m.sideBarBttns.buttonFocused = m.top.GetScene().buttondid
end sub

function buttonObserver()
    ' observer for OK button
    category_id = m.sideBarBttns.buttonSelected
    if category_id <> 3
        OnButtonBarItemSelected(category_id)
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    ' FOR RIGHT BUTTON
    handled = false
    if press then
        if (key = "right") then
            Scene = m.top.GetScene()
            Scene.findNode("contentGrid").setFocus(true)
            handled = true
        end if
    end if
    return handled
  end function

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
    customView = CreateObject("roSGNode", "ContentRowGrid")

    content = CreateObject("roSGNode", "ContentNode")
    content.AddFields({
        HandlerConfigGrid: {
            name: "APIContentHandler",
            query: mode
        }
    })

    customView.content = content
    m.top.GetScene().grid = customView
    
    m.top.GetScene().ComponentController.CallFunc("show", {
        view: customView
    })
end sub