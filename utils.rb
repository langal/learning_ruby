require 'ostruct'
require 'yaml'

class Utils

    def self.makeStruct(hash)
        #struct = OpenStruct.new(hash)
        object = OpenStruct.new()
        if (!hash.kind_of?(Hash))
            raise ArgumentError('Argument is not of type Hash')
        end
        hash.keys.each do |key|
            #puts key + " " + hash[key].class().to_s()
            if hash[key].respond_to?(:keys)
                object[key] = makeStruct(hash[key])
            elsif hash[key].kind_of?(Array)
                subArray = Array.new()
                hash[key].each do |subValue|
                    if subValue.respond_to?(:keys)
                        subArray << makeStruct(subValue)
                    else
                        subArray << subValue
                    end
                    object[key] = subArray
                end
            else
                object[key] = hash[key]
            end
        end
        return object
    end

    def self.log(msg,location='/tmp/ruby_log')
        file = open(location,'a+')
        if (msg.is_a?(String) || msg.is_a?(Fixnum) || msg.is_a?(Float) || msg.is_a?(FalseClass) || msg.is_a?(TrueClass))
            file.puts msg
        else
            file.puts YAML::dump(msg)
        end
        file.close()
    end

end
