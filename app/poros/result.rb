Result =
  Struct.new(:data, :error) do
    def ok?
      error.blank?
    end
  end
