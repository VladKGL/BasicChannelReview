function onKeyEvent(key as String, press as Boolean) as Boolean
    ' Adding behavior for back button
    if press and key = "back"
        if m.top.GetScene().ComponentController.allowCloseChannelOnLastView
            m.top.GetScene().FindNode("leftSideBar").visible = true 
            m.top.GetScene().FindNode("channelName").visible = true
        end if
        return false
    end if
   
    return false
end function