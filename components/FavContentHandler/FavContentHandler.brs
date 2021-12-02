sub GetContent()
    childChildren = GetChildChildren()
    root = {
        "children": [{
            "title": "Favourites, to add something here push * on some item",
            "children": childChildren
        }]
    }
    m.top.content.Update(root)
end sub

function GetChildChildren()
    sec = CreateObject("roRegistrySection", "Favorites")
    childChildren = []
    for each key in sec.GetKeyList()
        item = sec.Read(key)
        itemDict = ParseJson(item)
        itemDict.id = key
        itemNode = Utils_AAToContentNode(itemDict)
        childChildren.Push(itemNode)
    end for
    return childChildren
end function