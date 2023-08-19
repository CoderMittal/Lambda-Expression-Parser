def solver(term, flag)
    # puts term

    # (\x.x) like terms
    if term[0]=='('
        if term[-1]!=')'
            puts "unmatched )"
            $flag = 0
            return
        end

        if term[1]!= '\\'
            puts "invalid matching for lambda function"
            $flag = 0
            return
        end

        if term[3]!= '.'
            puts "invalid matching for ."
            $flag = 0
            return
        end

    # [M][N] like terms
    elsif term[0]=='['
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount = bracCount + 1
            elsif term[i]==']'
                bracCount = bracCount - 1
                if bracCount == 0
                    # puts "why i am here"
                    solver(term[1..(i-1)],$flag)
                    break
                end
            end
        end
        if bracCount != 0
            puts "Unmatched Bracket ["
            $flag = 0
            return
        end
        i = i+1
        
        if term[i] == '['
            bracCount = 1
            for j in (i+1)..term.length-1
                if term[j]=='['
                    bracCount = bracCount + 1
                elsif term[j]==']'
                    bracCount = bracCount - 1
                    if bracCount == 0
                        if j==term.length-1
                            solver(term[(i+1)..(term.length-2)],$flag)
                            break
                        else
                            puts "terms occuring after completion"
                            $flag = 0
                            return
                        end
                    end
                end
            end
        else
            puts "error no two [] []"
            $flag = 0
            return

        end

    # terms like xy    
    else
        if term.length != 1
            $flag = 0

            return
        end
    end

end


# wrapper function for solver
def check(term)
    # status of flag returns whether the term is valid or not
    $flag =1
    puts
    solver(term,$flag)
    if $flag==1
        puts term + " is a VALID Lambda Term"
    else
        puts term + " is an INVALID Lambda Term"
    end
    # puts $flag
    print ("-------------------------------------\n")
    
end

# looking for test cases from "test_checker.txt"
File.foreach("./tests/test_checker.txt") { |line| check line.chomp }
