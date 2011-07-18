task :law_school => :environment do
  require 'open-uri'
  location_name = "Law School"
  cur_date = DateTime.
  doc = Nokogiri::HTML(open("http://www.aramarkcafe.com/components/menu.aspx?locationid=3270&menuid=7385&pageid=20&print=yes&tmp=2011071223"))
  doc.css('tr:nth-child(6) .menutext').each do |item|
    title = item.inner_html.split('<br>').first
    if(Item.where(:title => title, :location => location_name).exists?)
      item = Item.find(:first, :conditions => ["title = ? and location = ?", title, location_name])
    else
      item = Item.new(:title => title, :special => true, :last => DateTime.now, :location => location_name)
      item.save
      puts item.title
    end
  end
  puts "done"
end



