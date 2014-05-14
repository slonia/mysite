SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.active_leaf_class = nil
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'

    primary.item :cathedras, t('navigation.cathedras'), admin_cathedras_path,
      :highlights_on => proc { controller_name == 'cathedras' } if can? :read, Cathedra

    primary.item :teachers, t('navigation.teachers'), admin_teachers_path,
      :highlights_on => proc { controller_name == 'teachers' } if can? :read, Teacher

    primary.item :rooms, t('navigation.rooms'), admin_rooms_path,
      :highlights_on => proc { controller_name == 'rooms' } if can? :read, Room

    primary.item :subjects, t('navigation.subjects'), admin_subjects_path,
      :highlights_on => proc { controller_name == 'subjects' } if can? :read, Subject

    primary.item :groups, t('navigation.groups'), admin_groups_path,
      :highlights_on => proc { controller_name == 'groups' } if can? :read, Group

    primary.item :tweet_logs, t('navigation.tweet_logs'), admin_tweet_logs_path,
      :highlights_on => proc { controller_name == 'tweet_logs' } if can? :read, TweetLog

    primary.item :normal, t('navigation.normal'), root_path
  end
end
