sub showcontent()
    btncont = m.top.itemContent
    m.top.labelText = btncont.name
    m.top.iconUri = btncont.icon
    m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
    m.top.observeField("focusPercent", "showfocus")
end sub

sub showfocus(event as object)
    if event.getData() > 0.7 and m.top.listHasFocus = 1 then
        m.top.findNode("sideBarItemLabel").color = "#000000"
    else
        m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
    end if
end sub

sub dropColor(event as object)
    if m.top.listHasFocus = 0
        m.top.findNode("sideBarItemLabel").color = "#FFFFFF"
    else 
        m.top.focusPercent += 0.01
    end if
end sub
