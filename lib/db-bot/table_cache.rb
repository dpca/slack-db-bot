module TableCache
  def self.load(name)
    file = filename(name)
    unless File.exist?(file)
      raise "Couldn't find #{file}!"
    end
    YAML.load(File.read(file))
  end

  def self.save(name, mapping)
    File.open(filename(name), 'w') do |file|
      file.write(YAML.dump(mapping))
    end
  end

  def self.filename(name)
    "tmp/#{name}.yml"
  end
end
