module ApplicationHelper
  def current_order
    company = current_user.japanese_retailer_orders.find(session[:current_order_id])
  end

  def current_company
    if current_user
      if session[:current_company_id]
        company = current_user.companies.find(session[:current_company_id])
      else
        company = nil
      end
      company
    end
  end
end
