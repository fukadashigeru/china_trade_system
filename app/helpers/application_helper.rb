module ApplicationHelper
  def current_company
    if current_user
      if session[:current_company_id] && current_user.companies.find_by(id: session[:current_company_id])
        company = current_user.companies.find(session[:current_company_id])
      else
        company = nil
      end
      company
    end
  end

  def current_company_user
    if current_company && current_user
      CompanyUser.find_by(company: current_company, user: current_user)
    else
      nil
    end
  end
end
