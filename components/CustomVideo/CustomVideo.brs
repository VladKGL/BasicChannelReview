function onKeyEvent(key as string, press as boolean) as boolean
    ' IDK HOW TO MAKE IT IN MAIN SCENE
    ' Adding behavior for back button
    if press and key = "back"
        m.top.GetScene().FindNode("leftSideBar").visible = true
        m.top.GetScene().FindNode("channelName").visible = true
        return false
    end if
    return false
end function