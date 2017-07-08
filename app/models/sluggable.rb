module Sluggable

  module ClassMethods
    def find_by_slug(slug_name)
      self.all.detect {|user| user.slug == slug_name}
    end
  end

  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ", "_")
    end
  end
end
