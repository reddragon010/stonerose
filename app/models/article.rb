class Article < ActiveRecord::Base
  def active?
    self.active
  end
  
  def is_intime?
    self.start <= Time.now && self.stop >= Time.now  
  end
end
