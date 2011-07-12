module ItemsHelper
  
  def remove_nonascii(replacement)
    n=self.split("")
    self.slice!(0..self.size)
    n.each { |b|
     if b[0].to_i< 33 || b[0].to_i>127 then
       self.concat(replacement)
     else
       self.concat(b)
     end
    }
    self.to_s
  end
  
end
