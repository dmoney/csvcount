class NumCount
  attr_accessor :number, :count, :freq
  def initialize(number)
    @number=number
    @count=0
    @freq=0.0
  end
  def inc
    @count = @count + 1
  end
end
class NumCountList
  def initialize
    @counts={}
    @total = 0
  end
  def inc(number)
    @counts[number] = NumCount.new(number) if @counts[number] == nil
    @counts[number].inc
    @total = @total + 1
  end
  def get
    #if @counts[0] == nil
    #  @counts.shift
    #end
    counts_a = []
    @counts.keys.each {|i| counts_a << @counts[i]}
    counts_a.sort!{|a, b| b.count <=> a.count }.each do
      |count| count.freq = count.count.to_f / @total 
    end
    return counts_a
  end
end
  
list = NumCountList.new
skipped = 0
IO.readlines('yourfile.csv').each do |line| 
  skipped = skipped + 1
  if skipped > 2
    cols = line.split ','
    (11..11).each do |col_num|
      col = cols[col_num]
      if col && col.strip != ''
        c = col.to_i
        #nums[c] = 1 + (nums[c] ? nums[c] : 0) if c != nil
        list.inc(c) if c != nil
        puts line if c == 0
      end
    end
  end
end
#puts list.get
list.get.each do |count|
  #puts count
  puts '' + count.number.to_s + ":\t" + count.count.to_s + "\t(" + count.freq.to_s + ")"
end
# puts count