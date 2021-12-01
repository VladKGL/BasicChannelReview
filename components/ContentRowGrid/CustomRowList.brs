sub init()
    m.top.translation = [0, 0]
    customRowListElement = m.top.FindNode("contentGrid")
    customRowListElement.Update({
        translation: [310, 50]
        itemComponentName: "CustomRowListItem"
    })
    customRowListElement.observeField("itemSelected", "SelectedHandler")
end sub


function SelectedHandler(event as object)
    ' METHOD FOR HANDLING SELECTED NODE
    customRowListElement = m.top.FindNode("contentGrid")
    item = m.top.GetScene().mainCustomRowList.content.GetChild(customRowListElement.rowItemSelected[0]).GetChild(customRowListElement.rowItemSelected[1])

    if item.streamUrl <> invalid
        videoContent = createObject("RoSGNode", "ContentNode")
        videoContent.url = item.streamUrl
        videoContent.title = item.TITLE
        videoContent.streamformat = "hls"

        video = createObject("RoSGNode", "CustomVideo")
        video.content = videoContent
        video.control = "play"
        video.pourl = item.HDPOSTERURL

        m.top.GetScene().FindNode("leftSideBar").visible = false
        m.top.GetScene().FindNode("channelName").visible = false

        m.top.GetScene().ComponentController.CallFunc("show", {
            view: video
        })
    else
        dialog = createObject("roSGNode", "Dialog")
        dialog.title = "Error"
        dialog.optionsDialog = true
        dialog.message = "Sorry but we cant play it now, Press * To Dismiss"
        m.top.GetScene().dialog = dialog
    end if
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

