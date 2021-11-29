function GetPodcastsSchema(url)
    childChildrenONE = ParsePodcasts(url, "101")
    childChildrenTWO = ParsePodcasts(url, "102")
    childChildrenTHREE = ParsePodcasts(url, "103")
    root = {
        "children": [{
            "title":"Humor",
            "children": childChildrenONE,
        },
        {
        "title": "Finance",
        "children": childChildrenTWO
        },
        {
        "title": "Life",
        "children": childChildrenTHREE
        }]
    }
    m.top.content.Update(root)
end function


function ParsePodcasts(url as object, code as string)
    urlLink = "https://us.api.iheart.com/api/v3/podcast/categories/" + code

    url.setUrl(urlLink)
    contentJSON = ParseJson(url.GetToString())
    
    if contentJSON <> invalid
        childChildren = []
        for each itemDict in contentJSON["podcasts"]
            itemNode = Utils_AAToContentNode({
                "id": itemDict.id,
                "title": itemDict.title,
                "description": itemDict.subtitle,
                "hdPosterUrl": itemDict.imageUrl,
            })
            childChildren.Push(itemNode)
        end for
        return childChildren
    end if
    
end function