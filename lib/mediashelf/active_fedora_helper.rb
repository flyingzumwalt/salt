# Stanford SolrHelper is a controller layer mixin. It is in the controller scope: request params, session etc.
# 
# NOTE: Be careful when creating variables here as they may be overriding something that already exists.
# The ActionController docs: http://api.rubyonrails.org/classes/ActionController/Base.html
#
# Override these methods in your own controller for customizations:
# 
# class HomeController < ActionController::Base
#   
#   include Stanford::SolrHelper
#   
#   def solr_search_params
#     super.merge :per_page=>10
#   end
#   
# end
#
module MediaShelf
  module ActiveFedoraHelper

    private
  
    def require_fedora
      Fedora::Repository.register(ActiveFedora.fedora_config[:url],  session[:user])
      return true
    end
  
    def require_solr
      ActiveFedora::SolrService.register(ActiveFedora.solr_config[:url])
    end
    
    #underscores are escaped w/ + signs, which are unescaped by rails to spaces
    def unescape_keys(attrs)
      h=Hash.new
      attrs.each do |k,v|
        h[k.gsub(/ /, '_')]=v

      end
      h
    end
    def escape_keys(attrs)
      h=Hash.new
      attrs.each do |k,v|
        h[k.gsub(/_/, '+')]=v

      end
      h
    end
    
  end
end
