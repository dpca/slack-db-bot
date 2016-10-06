class TableColumnMapper
  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def mapping
    @_mapping ||= connection.data_sources.each_with_object({}) do |table, hash|
      hash[table] = connection.columns(table).each_with_object({}) do |col, col_hash|
        col_hash[col.name] = col.sql_type
      end
    end
  end
end
