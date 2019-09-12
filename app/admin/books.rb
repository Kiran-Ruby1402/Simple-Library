ActiveAdmin.register Book do
  filter :title

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :quantity, :description, :category_id
  #
  # or
                                                                                                                                                                        #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do

    selectable_column
    id_column
    column :title
    column :description
    column :quantity
    column :category do |book|
       book.category.label
    end
    column :created_at
    actions
  end



  show do
    attributes_table do
      row :title
      row :quantity
      row :description
      row :category do |book|
         book.category.label
      end
    end
  end

  form do |f|
    f.inputs "Add/Edit Article" do
      f.input :title
      f.input :quantity
      f.input :description
      f.input :category, :as => :select, :collection => Category.all.collect {|category| [category.label, category.id] }
    end
    actions
  end
  
end
