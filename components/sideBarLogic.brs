function setUpSideBar()
    sideBar = createObject("roSGNode", "sideBar")
    sideBar.id = "leftSideBar"
    sideBar.itemComponentName = "sideBarItem"
    sideBar.content = SetUpSideBarContent()
    sideBar.itemSize = [250, 70]
    sideBar.vertFocusAnimationStyle = "floatingFocus"
    sideBar.rowSpacings = [0, 0, 280]
    sideBar.translation = [0, 150]
    sideBar.observeField("itemSelected", "SideBarItemObserver")
    m.top.appendChild(sideBar)
end function

function SetUpSideBarContent() as object
    buttoninfos = [
        {
            name: "Live",
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_fast_forward-100.png"
        },
        {
            name: "Artists",
            icon: "https://cdn0.iconfinder.com/data/icons/party2-3/64/Concert-music-rock-singer-100.png"
        },
        {
            name: "Podcasts",
            icon: "https://cdn1.iconfinder.com/data/icons/celebrity-superstars/48/celebrity_-_singer-100.png"
        },
        {
            name: "Settings",
            icon: "https://cdn1.iconfinder.com/data/icons/media-player-button/48/media_player_-_equalizer-100.png"
    }]
    sideBarContent = CreateObject("roSGNode", "ContentNode")

    for each btncont in buttoninfos
        btnNode = Utils_AAToContentNode(btncont)
        sideBarContent.appendChild(btnNode)
    end for

    return sideBarContent
end function

function SideBarItemObserver(event as object)
    itemSelectedID = event.getData()
    if itemSelectedID <> 3
        buttonAA = [
            "Live",
            "Artists",
            "Podcasts"
        ]
        mode = buttonAA[itemSelectedID]
        customRowList = m.top.mainCustomRowList
        customRowList.content = m.top[mode]
        customRowList.findNode("contentGrid").jumpToRowItem = [0, 0]
        customRowList.setFocus(true)
    end if
end function