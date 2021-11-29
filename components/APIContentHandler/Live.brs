function GetLiveSchema(url as object)
    childChildrenUS = ParseLiveCountry(url, "us")
    childChildrenCA = ParseLiveCountry(url, "ca")
    childChildrenMX = ParseLiveCountry(url, "mx")
    childChildrenGN = ParseLiveGenres(url)
    root = {
        "children": [{
            "title":"US",
            "children": childChildrenUS,
        },
        {
        "title": "CA",
        "children": childChildrenCA
        },
        {
        "title": "MX",
        "children": childChildrenMX
        },
        {
        "title": "Genres",
        "children": childChildrenGN
        }]
    }
    m.top.content.Update(root) 
end function

function ParseLiveCountry(url as object, countryCode as string)
   
    urlLink = "https://" + countryCode + ".api.iheart.com/api/v2/content/liveStations?countryCode=" + countryCode

    url.setUrl(urlLink)
    contentJSON = ParseJson(url.GetToString())
    
    if contentJSON <> invalid
        childChildren = []
        for each itemDict in contentJSON["hits"]
            itemNode = Utils_AAToContentNode({
                "id": itemDict.id,
                "title": itemDict.name,
                "description": itemDict.description,
                "hdPosterUrl": itemDict.logo,
                "streamUrl": itemDict.streams.secure_hls_stream,
            })
            childChildren.Push(itemNode)
        end for
        return childChildren
    end if
    
end function

function ParseLiveGenres(url)
    url.setUrl("https://us.api.iheart.com/api/v3/catalog/genres?genreType=livestation")
    contentJSON = ParseJson(url.GetToString())

    if contentJSON <> invalid
        childChildren = []
        for each itemDict in contentJSON["genres"]
            itemNode = Utils_AAToContentNode({
                "id": itemDict.id,
                "title": itemDict.genreName,
                "description": itemDict.genreGroup,
                "hdPosterUrl": itemDict.image,
            })
            childChildren.Push(itemNode)
        end for
        return childChildren
    end if
    
end function