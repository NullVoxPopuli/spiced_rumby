module SpicedRumby
  module VedeuTest
    module Views
      class Contacts


        Vedeu.interface :contacts do
          border do
            title 'Contacts'
          end
          geometry do
            align :middle, :right, 40, 40
          end
        end

        def self.render_views
          Vedeu.render do
            view :contacts do
              lines do
                MeshChat::Node.all.each do |node|
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
