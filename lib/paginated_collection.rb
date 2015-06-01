class PaginatedCollection
  include Enumerable

  def initialize(objs, page:, per_page:)
    @objs = objs
    @page = page
    @per_page = per_page
  end

  def each(&block)
    posts_in_current_page.each(&block)
  end

  def next_page
    @page + 1
  end

  def next_page?
    posts_in_next_page.present?
  end

  delegate :present?, to: :posts_in_current_page

  private

  attr_reader :objs, :page, :per_page

  def posts_in_current_page
    posts_in_page(page)
  end

  def posts_in_next_page
    posts_in_page(page + 1)
  end

  def posts_in_page(n)
    objs.each_slice(per_page).to_a[n-1] || []
  end
end
