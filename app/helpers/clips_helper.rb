module ClipsHelper
  def url_token(text)
    text.gsub(/\[([^\[]*)[\|]([^\]]*)\]/) {
      text = $1
      href = $2
      '<a href="' + (href.match('http://') == nil ? 'http://' : '') + href + '">' + text + '</a>'
    }
  end
end
