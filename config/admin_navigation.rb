SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.active_leaf_class = nil
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'

    primary.item :cathedras, 'Cathedras', admin_cathedras_path,
      :highlights_on => proc { controller_name == 'cathedras' } if can? :read, Cathedra

    primary.item :teachers, 'Teachers', admin_teachers_path,
      :highlights_on => proc { controller_name == 'teachers' } if can? :read, Teacher
  end
end
