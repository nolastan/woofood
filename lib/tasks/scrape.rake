task :scrape => :environment do
  require 'open-uri'
  
# @TODO Make these dynamic
  scrape_date=Date.today
  locationNum = '05'

  dtdate = scrape_date.strftime('%m')+'%2F'+scrape_date.strftime('%e')+'%2F'+scrape_date.strftime('%Y')
  doc = Nokogiri::HTML(open("http://menus.wustl.edu/shortmenu.asp?locationNum="+locationNum+"&dtdate="+dtdate))
  doc.css('table td[width="30%"]').each do |location|
    location_name = location.css('div.shortmenumeals').text
    location.css('.shortmenurecipes a').each do |row|
      
      title = row.text
            
      # Determine "special" status of item at location
      if(Item.where(:title => title, :location => location_name).exists?)
        item = Item.find(:first, :conditions => ["title = ? and location = ?", title, location_name])
        if(item.last < scrape_date-1)
          item.special = true #item is special
        else 
          item.special = false # item is old
        end
        
      else #item is special
        item = Item.new(:title => title)
        item.special = true
               
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
           
      item.last = scrape_date
      item.save
    end
  end
  puts "done"
end