module SpicedRumby
  module GUI
    module Views
      class Contacts < Vedeu::ApplicationView


        def render
          Vedeu.render do
            view :contacts do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              lines do
                nodes = MeshChat::Node.order(alias_name: :desc)

                nodes.each do |node|
                  line{
                    foreground '#ffffff' if node.online?
                    foreground '#333333' if !node.online?
                    right "#{node.alias_name}"
                  }
                end
              end
            end
          end
        end

      end
    end
  end
end
