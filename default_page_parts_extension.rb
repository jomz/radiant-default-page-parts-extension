class DefaultPagePartsExtension < Radiant::Extension
  version "0.2"
  description "Enables auto-creation of default page parts for a page's children"
  url "http://github.com/santry/radiant-default-page-parts-extension"

  Page.class_eval do
    alias :original_parent_equals :parent=
    
    def parent=(parent)  
      string = parent.render_part("page_part_config")
      unless string.empty?
        config = YAML::load(string)
      else
        config = {}
      end
      default_filter = config["filter"].to_s.camelize
      filter = ["SmartyPants", "Markdown", "Textile"].include?(default_filter) ? "#{default_filter}" : nil
      if config["parts"].is_a?(Array) && config["parts"].size > 0
        self.parts = []
        config["parts"].each do |name|
          self.parts << PagePart.new(:name => name, :filter_id => filter)
        end
      end
      original_parent_equals(parent)
    end
    
    
  end

end