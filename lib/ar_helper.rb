module ARHelper
  
  def self.included klass
    if klass.column_names.any? {|col| col =~ DESC_COL_NAME_PATTERN}
      klass.instance_eval do
        before_save :downcase_attrs
        
        define_method :downcase_attrs do
          klass.column_names.select { |col|
            col =~ DESC_COL_NAME_PATTERN
          }.each { |col|
            send(col).send 'downcase!' unless send(col).blank?
          }
        end
      end
    end
  end
  
  private
  
  DESC_COL_NAME_PATTERN = /_desc$/
  
end