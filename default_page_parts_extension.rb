class DefaultPagePartsExtension < Radiant::Extension
  version "0.2"
  description "Adds a default page part, or several, with default content."
  url "http://github.com/kgautreaux/radiant-default-page-parts-extension" 
  
  Page.instance_eval do
    def new_with_defaults(config = Radiant::Config)
      # Check if config file exists
      if File.exists?(File.join(File.dirname(__FILE__), "parts.yml"))
        page = new
        default_parts = YAML::load(File.open(File.join(File.dirname(__FILE__), "parts.yml"), "r"))
        
        # Set up the base parts
        default_parts.each do |part|
          page.parts << PagePart.new(:name => part['name'], :filter_id => (part['filter'] || config['defaults.page.filter']),
                                      :content => part['content'])
        end
  
        # Set the status
        default_status = config['defaults.page.status']
        page.status = Status[default_status] if default_status
        page
      else
        original_new_with_defaults(config)
      end
    end
  end
end
