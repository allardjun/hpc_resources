module test

function main()
    s1 = 0
    Threads.@threads for i = 1:10000
        s1+=i
    end
    
    s2 = 0
    for i = 1:10000
        s2+=i
    end

    s3 = 0
    myLock = ReentrantLock()
    Threads.@threads for i = 1:10000
        @lock myLock s3+=i
    end

    return [s2 s1 s3]
end

x=[main() for i = 1:20]
m = zeros(Int64, 20,3)
m[:,1] = [x[i][1] for i = 1:20]
m[:,2] = [x[i][2] for i = 1:20]
m[:,3] = [x[i][3] for i = 1:20]
display(m)

end