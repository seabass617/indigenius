module ApplicationHelper
  def full_title(page_title="")
    base_title = "indigenius"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def price_mask_real(price)
    number_to_currency(price, unit: 'R$', separator: ',', delimiter: '.')
  end
  
  def format_date(date)
    date.strftime("%d-%m-%Y")
  end
  
  def format_hour(hour)
    hour.strftime("%H:%M")
  end

end
