function GetArtistsSchema(url)
    childChildrenRAR = ParseArtists(url, "102")
    childChildrenRB = ParseArtists(url, "104")
    childChildrenSP = ParseArtists(url, "14")
    root = {
        "children": [{
            "title":"Recommended Artist Radio",
            "children": childChildrenRAR,
        },
        {
        "title": "R&B",
        "children": childChildrenRB
        },
        {
        "title": "Sports",
        "children": childChildrenSP
        }]
    }
    m.top.content.Update(root)
end function


function ParseArtists(url as object, code as string)
    urlLink = "https://us.api.iheart.com/api/v2/recs/genre?genreId=" + code + "&template=CR"

    url.setUrl(urlLink)
    contentJSON = ParseJson(url.GetToString())
    
    if contentJSON <> invalid
        childChildren = []
        for each itemDict in contentJSON["values"]
            itemNode = Utils_AAToContentNode({
                "id": itemDict.contentId,
                "title": itemDict.label,
                "description": itemDict.subType,
                "hdPosterUrl": itemDict.imagePath,
            })
            childChildren.Push(itemNode)
        end for
        return childChildren
    end if
    
end function