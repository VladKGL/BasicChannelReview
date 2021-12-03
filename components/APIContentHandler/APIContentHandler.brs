sub GetContent()
    url = CreateObject("roUrlTransfer")
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    url.AddHeader("X-Roku-Reserved-Dev-Id", "")
    mode = m.top.query

    if mode = "Live" then
        GetLiveSchema(url)
    else if mode = "Artists" then
        GetArtistsSchema(url)
    else if mode = "Podcasts" then
        GetPodcastsSchema(url)
    end if
    
end sub



