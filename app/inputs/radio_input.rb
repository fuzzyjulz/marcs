class RadioInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    #".text_field(attribute_name, merged_input_options)}".html_safe

    "#{@builder.input(attribute_name,
        label_method: :last,
        value_method: :first,
        label: false,
        as: :radio_buttons,
        collection: [[options[:value],options[:label]]],
        input_html: input_html_options)}".html_safe
  end
end
