class Article < ActiveRecord::Base
  def active_img
    if self.active then
      "Play.png"
    else
      "Pause.png"
    end
  end
  
  def is_intime?
    self.start <= Time.now && self.stop >= Time.now  
  end
end
