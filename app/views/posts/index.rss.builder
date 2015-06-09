xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Lonely Proton"
    xml.description "A blog about software and other fun things"
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        if post.link?
          xml.title "#{post.title} (link)"
        else
          xml.title post.title
        end

        if post.link?
          xml.description(
            "#{post.html}<br><br><a href='#{post_url(post)}'>Permalink</a>"
          )
        else
          xml.description post.html
        end

        xml.pubDate post.published_at.to_s(:rfc822)

        if post.link?
          xml.link post.link
        else
          xml.link post_url(post)
        end

        xml.guid post_url(post)
      end
    end
  end
end
