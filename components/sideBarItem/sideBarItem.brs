sub showcontent()
    btncont = m.top.itemContent
    m.top.wasChoosen = btncont.focus
    m.top.labelText = btncont.name
    m.top.iconUri = btncont.icon
    m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
end sub

sub showfocus(event as object)
    if event.getData() > 0.5 then
        m.top.findNode("sideBarItemLabel").color = "#000000"
        m.top.wasChoosen = true
    else
        m.top.wasChoosen = false
        m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
    end if
end sub

sub dropColor(event as object)
    if m.top.listHasFocus = 0
        m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
        m.top.observeField("focusPercent", "")
    else 
        if m.top.wasChoosen then
            m.top.findNode("sideBarItemLabel").color = "#000000"
        end if
        m.top.observeField("focusPercent", "showfocus")
    end if
end sub