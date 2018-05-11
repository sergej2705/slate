# Unique header generation
require 'middleman-core/renderers/redcarpet'
require 'digest'
require 'net/http'
require 'uri'
require 'open-uri'
require 'yaml'
 
class UniqueHeadCounter < Middleman::Renderers::MiddlemanRedcarpetHTML
  def initialize
    super
    @head_count = {}
  end
  def header(text, header_level)
    friendly_text = text.gsub(/<[^<]+>/,"").parameterize
    if friendly_text.strip.length == 0
      # Looks like parameterize removed the whole thing! It removes many unicode
      # characters like Chinese and Russian. To get a unique URL, let's just
      # URI escape the whole header
      friendly_text = Digest::SHA1.hexdigest(text)[0,10]
    end
    @head_count[friendly_text] ||= 0
    @head_count[friendly_text] += 1
    if @head_count[friendly_text] > 1
      friendly_text += "-#{@head_count[friendly_text]}"
    end
    return "<h#{header_level} id='#{friendly_text}'>#{text}</h#{header_level}>"
  end

  def preprocess(full_document)
    full_document = super(full_document) if defined?(super)
    full_document = ERB.new(full_document).result(binding)
    return full_document
  end

  def diagram(file)
    textfile = File.join(File.dirname(__FILE__), '../source/diagrams', file)
    pngfile = File.join(File.dirname(__FILE__), '../source/images', file + ".png")
    puts textfile
    text = File.read(textfile)
    response = Net::HTTP.post_form(URI.parse('http://www.websequencediagrams.com/index.php'), 'style' => 'modern-blue', 'message' => text)
 
    parsed = YAML.load(response.body);

    puts response.body
    url = "http://www.websequencediagrams.com" + parsed['img'];
    File.open(pngfile, "w+") { |f| f << open(url).read }

    #if response.body =~ /png: "(.+)"/
      return "<span class='lightgallery'><a href='images/" + file + ".png'><img src='images/" + file + ".png'></a></span>"
    #end
  end
end
