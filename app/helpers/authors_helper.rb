module AuthorsHelper

  def hintstable(id)
    @hintstable = Author.find(id).hints.joins(:group).group('hints.title, groups.name').select('COUNT(title), title, groups.name')
    return @hintstable
  end
end
