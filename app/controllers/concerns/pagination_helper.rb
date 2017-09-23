module PaginationHelper
  def meta_pagination(obj)
    {
      current_page: obj.current_page,
      total_pages: obj.total_pages,
      total_count: obj.total_count,
      first_page: obj.first_page?,
      prev_page: obj.prev_page,
      next_page: obj.next_page,
      last_page: obj.last_page?
    }
  end
end
