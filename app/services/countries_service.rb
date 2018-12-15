class CountriesService
  def initialize
    @full_list = ISO3166::Country.find_all_countries_by_world_region('EMEA')
  end

  def make_list
    list = []

    flatten = flatten_obj(@full_list)
    flatten.sort_by! { |hsh| hsh[:name] }

    flatten.each_with_index do |obj, i|
      list.push(make_hash(obj))
    end
    list
  end

  def make_hash(obj)
    {
      name: obj[:name],
      value: obj[:value]
    }
  end

  def flatten_obj(obj)
    list = []
    gb = 'United Kingdom of Great Britain and Northern Ireland'
    obj.each do |i|
      if i.in_eu?
        list.push(
          name: i.name,
          value: i.alpha2
        )
      end
    end
    list.select { |x| x[:name] == gb }[0][:name] = 'United Kingdom'
    list.select { |x| x[:name] == 'Greece' }[0][:value] = 'EL'
    list
  end
end
