ActiveAdmin.register Borrow do
    config.filters = false
    actions :index, :show
    config.batch_actions = false
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :user, :book, :status, :due_date, :created_at
  
  index do
    index_column
    column(:user)
    column(:book)
    column(:created_at)
    column(:due_date)
    column(:status)

    actions
  end

  show do
    attributes_table do
      row(:user)
      row(:book)
      row :issued_date do |borrow|
        borrow.created_at.to_date
      end
      row :due_date do |borrow|
        borrow.due_date.to_date
      end
      row(:status)
      row(:due_amount) do |borrow|
      due_days = Date.today - borrow.due_date.to_date 
      if borrow.status == "issued" and due_days > 0
         "#{due_days * 10}" + " Rupees"
      else
        "0" + " Rupees"
      end
    end
    end
  end
  
end
