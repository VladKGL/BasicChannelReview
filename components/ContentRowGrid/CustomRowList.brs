function ChangeContent(event as object)
    m.top.content = m.top.contentsDict[event.getData()]
    m.top.findNode("contentGrid").jumpToRowItem = [0, 0]
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press and key = "back"
        if m.top.GetScene().ComponentController.allowCloseChannelOnLastView
            m.top.GetScene().exitChannel = false
            m.top.GetScene().FindNode("leftSideBar").setFocus(true)
        end if
        return true
    end if

    return false
end function

