class DiffFinder
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def any_changes?
    old_mappings != new_mappings
  end

  def diffs
    HashDiff.diff(old_mappings, new_mappings)
  end

  def output
    HashDiffFormatter.new(database.name, diffs).to_s
  end

  def old_mappings
    @_oldm ||= TableCache.load(database.name)
  end

  def new_mappings
    @_newm ||= TableColumnMapper.new(database.connection).mapping
  end
end
