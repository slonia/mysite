module CollectionsHelper
  def terms_collection
    (1..10).to_a
  end

  def groups_by_term(selected = nil, groups = nil)
    groups ||= Group.all
    opts = groups.for_current_term.group_by(&:term).map do |term, term_groups|
      ids_and_names = term_groups.map do |t_group|
        [t_group.full_name, t_group.id]
      end
      [term.to_s + ' семестр', ids_and_names]
    end
    grouped_options_for_select(opts, selected)
  end
end
