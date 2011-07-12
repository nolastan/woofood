class MenuController < ApplicationController
require 'open-uri'  
  def show
    @response = Array.new
    doc = Nokogiri::HTML(open("http://menus.wustl.edu/shortmenu.asp?sName=Dining+Services&locationNum=05&locationName=%3CBR%3EDUC%3A+%3Cbr%3E+-+1853+Diner+-+Delicioso+-+Trattoria+Verde+-+Wash+U+Wok&naFlag=1"))
    doc.css('.shortmenurecipes a span span').each do |node|
      @response << node.text
    end
  end
  
end
