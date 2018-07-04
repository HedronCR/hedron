require "../../src/hedron.cr"

class ButtonTab < Hedron::Widget
  @@buttons = [] of Hedron::Button
  @counter = 0

  def initialize
    @display = Hedron::HDML.render <<-HDML
      VerticalBox #box {
        padded: true;
        stretchy: true;

        Label #label {
          @text: "You have made 0 new buttons.";
        }
      }
    HDML
  end

  def self.widget_name; return "ButtonTab"; end
  def self.init_markup; return self.new; end

  def new_button
    button = Hedron::HDML.render <<-HDML
      Button #btab#{@counter} {
        @text: "Button #{@counter}";
      }
    HDML
    button = button.widget.as(Hedron::Button)

    button.on_click do |this|
      this.text = "Button 0"
    end

    @@buttons.push(button)

    @counter += 1

    @display.not_nil!["box"].widget.as(Hedron::VerticalBox).add(button)
    @display.not_nil!["label"].widget.as(Hedron::Label).text = "You have made #{@counter} new buttons."
  end

  def index=(i : String)
    @index = i
    @display.not_nil!["box"].widget.index = i
  end
end