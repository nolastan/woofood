task :scrape => :environment do
  require 'open-uri'
  doc = Nokogiri::HTML(open("http://menus.wustl.edu/shortmenu.asp?sName=Dining+Services&locationNum=05&locationName=%3CBR%3EDUC%3A+%3Cbr%3E+-+1853+Diner+-+Delicioso+-+Trattoria+Verde+-+Wash+U+Wok&naFlag=1&WeeksMenus=This+Week%27s+Menus&myaction=read&dtdate=7%2F13%2F2011"))
  doc.css('table td[width="30%"]').each do |location|
    location_name = location.css('div.shortmenumeals').text
    location.css('.shortmenurecipes a').each do |row|
      
      title = row.text
            
      # Determine "new" status of item at location
      if(Item.where(:title => title, :location => location_name).exists?)
        item = Item.find(:first, :conditions => ["title = ? and location = ?", title, location_name])
        if(item.last < DateTime.yesterday)
          item.new = true #item is special
        else 
          item.new = false # item is old
        end
        
      else #item is new
        item = Item.new(:title => title)
        item.new = true
               
        # Get nutritional info
        nutrition = Nokogiri::HTML(open('http://menus.wustl.edu/'+row['href']))
        item.calories = nutrition.xpath('html/body/table/tr/td/table/tr/td/font[4]').text[/[0-9\.]+/]
        item.fat_calories = nutrition.xpath('html/body/table/tr/td/table/tr/td/font[5]').text[/[0-9\.]+/]  
        item.fat =       nutrition.xpath('html/body/table/tr/td/table/tr[2]/td[1]/font[2]').text    
        item.sat_fat =   nutrition.xpath('html/body/table/tr/td/table/tr[3]/td[1]/font[2]').text    
        item.trans_fat = nutrition.xpath('html/body/table/tr/td/table/tr[4]/td[1]/font[2]').text    
        item.cholesterol=nutrition.xpath('html/body/table/tr/td/table/tr[5]/td/font[2]').text    
        item.sodium =    nutrition.xpath('html/body/table/tr/td/table/tr[6]/td/font[2]').text    
        item.carb =      nutrition.xpath('html/body/table/tr/td/table/tr[2]/td[3]/font[2]').text    
        item.fiber =     nutrition.xpath('html/body/table/tr/td/table/tr[3]/td[3]/font[2]').text    
        item.sugar =     nutrition.xpath('html/body/table/tr/td/table/tr[4]/td[3]/font[2]').text    
        item.protein =   nutrition.xpath('html/body/table/tr/td/table/tr[5]/td[3]/font[2]').text    
        item.location =  location_name
        item.group = ''
      end
           
      item.last = DateTime.now
      item.save
    end
  end
  puts "done"
end