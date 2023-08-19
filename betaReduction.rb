
def FreeV(term)
    if(term[0] == "(")
        tempList = FreeV(term[4..-2])
        tempList.delete(term[2])
        return tempList
    elsif(term[0] == '[')
        bracCount = 1
        tempList = []
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    tempList1 = FreeV(term[1..(i-1)])
                    tempList2 = FreeV(term[(i+2)..(term.length-2)])
                    tempList = tempList1 | tempList2
                    break
                end
            end
        end
        return tempList
    else
        return [term]
    end
end

def Subst(term, var, subst)
    if(term[0] == "(")
        if(term[2] == var)
            return term
        elsif(FreeV(subst).include?(term[2]))
            temp = Alpha(term, term[2])
            return Subst(temp, var, subst)
        else
            return "(\\" + term[2] + "." + Subst(term[4..-2], var, subst) + ")"
        end
    elsif(term[0] == '[')
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    return "[" + Subst(term[1..(i-1)], var, subst) + "]" +  "[" + Subst(term[(i+2)..(term.length-2)], var, subst) +"]"
                end
            end
        end
    else
        if(term == var)
            return subst
        else
            return term
        end
    end
end

def Alpha(term, var)
    if(term[0] == "(")
        if(term[2] == var)
            for i in 2..term.length
                if term[i] == var
                    term[i] = term[i].upcase
                end
            end
            return term
        else
            return  term[0..3] + Alpha(term[4..(-2)], var) + term[-1]
        end
    elsif(term[0] == '[')
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    return "[" + Alpha(term[1..(i-1)], var) + "]" +  "[" +  Alpha(term[(i+2)..(term.length-2)], var) +"]"
                end
            end
        end
    else
        return term
    end
end


def Beta(term,count)

    $count = $count+1
    if $count > 500
        # print "I think its going out of my hands, take this as ans: "
        # $count=1
        return term
    end
    # puts term
    if(term[0] == "(")
        if(term[4] == "(")
            return term[0..3] + Beta(term[4..-2],count) + term[-1] 
        elsif(term[4] == "[")
            return term[0..3] + Beta(term[4..-2],count) + term[-1]
        else
            return term
        end
    elsif(term[0] == "[")
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    if term[1]=='('
                        return Beta(Subst(term[5..(i-2)],term[3],Beta(term[(i+2)..(term.length-2)],$count)),$count)
                    else
                        return "[" + Beta(term[1..(i-1)],$count) + "]" +  "[" +  Beta(term[(i+2)..(term.length-2)],$count) +"]"
                    end
                end
            end
        end
    else
        return term
    end
end

def reduction (term)
    $count =1
    return Beta(term, $count)
    print $count

end
File.foreach("./tests/test_beta.txt") { |line| puts reduction line.chomp }



