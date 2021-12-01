function itemContentChanged()
    itemPoster = m.top.findNode("itemPoster")
    itemPoster.uri = m.top.itemContent.HDPOSTERURL
    
    itemTitleLabel = m.top.findNode("itemTitleLabel")
    itemTitleLabel.text = m.top.itemContent.title

    itemDescriptionLabel = m.top.findNode("itemDescriptionLabel")
    itemDescriptionLabel.text = m.top.itemContent.description
end function

