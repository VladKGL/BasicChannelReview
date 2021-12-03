sub showcontent()
    btncont = m.top.itemContent
    m.top.text = btncont.name
    m.top.iconUri = btncont.icon
    m.top.focusedIconUri = btncont.icon
end sub

sub showfocus()
    m.itemcursor.opacity = m.top.focusPercent
    m.itemposter.opacity = m.top.focusPercent
end sub