class HashDiffFormatter
  attr_reader :connection, :diff

  def initialize(connection, diff)
    @connection = connection
    @diff = diff
  end

  def to_s
    diff.map do |change, column, value, new_value|
      case change
      when '-'
        "#{connection} dropped #{column_formatter(column)} - `#{value}`"
      when '+'
        "#{connection} new #{column_formatter(column)} - `#{value}`"
      when '~'
        "#{connection} #{column_formatter(column)} changed from `#{value}` to `#{new_value}`"
      else
        raise "Don't recognize change #{change}"
      end
    end.join("\n")
  end

  private

  def column_formatter(column)
    if column.include?('.')
      "column `#{column}`"
    else
      "table `#{column}`"
    end
  end
end
