module Ramaze
    module Helper
        module Markabatter
            HELPERS = [:Codebatter, :Tagalator, :Markabatter]
            def build_builder
                b = ::Markaby::Builder.new
                HELPERS.each{|h| b.extend(Ramaze::Helper.const_get(h))}
                return b
            end
            # string:: String of Markaby to translate
            # helpers:: Generally the calling controller. Not needed but can be helpful
            # This will take a string of Markaby and return the
            # results from Markaby. This allows for storing and
            # redisplaying of Markaby codes
            def smab(string, helper=nil)
                builder = build_builder
                builder.instance_eval(string)
                return builder.to_s
            end
            # helpers:: Generally all that will be needed is the controller
            # you are calling from.
            # args:: args to pass if needed (usually not)
            # block:: Block of Markaby
            # Executes the block of Markaby code and returns the
            # resulting HTML string.
            # Example from LogController:
            # 
            #   def stuff
            #       mab(self){ p "This is my paragraph" }
            #   end
            def mab(helpers=nil, args={}, &block)
                return ::Markaby::Builder.new(args, helpers, &block).to_s
            end
        end
    end
end