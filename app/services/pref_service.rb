# frozen_string_literal: true

class PrefService
  def main
    Pref.all[0].main
  end

  def company
    Pref.all[0].company
  end

  def update(obj)
    pref = Pref.find(1)
    obj.each do |k, v|
      pref.update_attribute(k, v)
    end
  end
end
