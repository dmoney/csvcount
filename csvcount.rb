# check command line args
if ARGV.length < 3
  puts "Usage: ruby csvcount.rb YOURFILENAME.csv START_COLUMN END_COLUMN [LINES_TO_SKIP]"
  exit
end

# parse command line args 
filename = ARGV[0]
start_column = ARGV[1].to_i - 1 # make zero-based
end_column = ARGV[2].to_i - 1   # make zero-based
lines_to_skip = ARGV[3] ? ARGV[3].to_i : 2

# class to store the occurrences and frequency of a particular number
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

# a list of counts and frequencies of numbers
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
    counts_a = []
    @counts.keys.each {|i| counts_a << @counts[i]}
    counts_a.sort!{|a, b| b.count <=> a.count }.each do
      |count| count.freq = count.count.to_f / @total 
    end
    return counts_a
  end
end
 
# iterate over the specified lines and columns
# and count the stuff
list = NumCountList.new
skipped = 0
IO.readlines(filename).each do |line| 
  skipped = skipped + 1
  if skipped > lines_to_skip
    cols = line.split ','
    (start_column..end_column).each do |col_num|
      col = cols[col_num]
      if col && col.strip != ''
        c = col.to_i
        list.inc(c) if c != nil
        puts line if c == 0
      end
    end
  end
end

# display the results
list.get.each do |count|
  puts '' + count.number.to_s + ":\t" + count.count.to_s + "\t(" + count.freq.to_s + ")"
end
