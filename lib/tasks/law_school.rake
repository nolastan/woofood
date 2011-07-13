# task :law_school => :environment do
#   require 'open-uri'
#   location_name = "Law School"
#   doc = Nokogiri::HTML(open("http://www.aramarkcafe.com/components/menu.aspx?locationid=3270&menuid=7385&pageid=20&print=yes&tmp=2011071223"))
#   doc.css('tr:nth-child(6) .menutext').each do |item|
#     # Determine "new" status of item at location
#     if(Item.where(:title => title, :location => location_name).exists?)
#       item = Item.find(:first, :conditions => ["title = ? and location = ?", title, location_name])
#     else
#       puts item.title
#       item = Item.new(:title => title, :new => true, :last => DateTime.now, :location => location_name)
#       item.save
#   end
#   puts "done"
# end
# 
