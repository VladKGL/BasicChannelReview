sub showcontent()
    btncont = m.top.itemContent
    m.top.labelText = btncont.name
    m.top.iconUri = btncont.icon
end sub

sub showfocus()
    m.itemcursor.opacity = m.top.focusPercent
    m.itemposter.opacity = m.top.focusPercent
end sub