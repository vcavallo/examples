require 'pry'

class RunFinder
  attr_reader :array, :indexes
  attr_accessor :array_size

  EXAMPLE_ARRAY =[1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7]

  def initialize(supplied_array, array_size = 20)
    @array = supplied_array || []
    @array_size = array_size
    @indexes = []

    if @array.empty?
      self.setup!
    end
  end

  def find_indexes
    @indexes = []

    @array.each_with_index do |n, index|
      if (index <= @array.length - 3)
        @indexes << (next_three_consecutive?(nil, index) ? index : nil)
      end
    end

    @indexes.compact!
    return @indexes
  end

  def spiel
    puts "Finding run of ONLY 3s from array: #{@array}"
    puts "... ... ..."
    puts "Beginning indexes of runs of threes are: #{find_indexes.to_s}"
    puts "all done!"
  end

  def self.perform_example!
    a = RunFinder.new(EXAMPLE_ARRAY)
    a.spiel
    puts "try running this in irb with RunFinder.run(some_array) to supply an array\n"\
         "or RunFinder.run(nil, some_array_size) to get a random array of desired size."
    puts "to see this again, its RunFinder.perform_example!"
  end

  def self.run(supplied_array, array_size = 20)
    a = RunFinder.new(supplied_array, array_size)
    a.spiel
  end

  def setup!
    if @array.empty?
      @array_size.times do
        @array << (1..10).to_a.sample
      end
    end
  end

  def next_three_consecutive?(array = @array, starting_index)
    array = @array if array.nil?

    true if three_run_up?(
      array[starting_index],
      array[starting_index +1],
      array[starting_index + 2]
    ) || three_run_down?(
      array[starting_index],
      array[starting_index +1],
      array[starting_index + 2]
    )
  end

  def is_one_less?(n1, n2)
    n1 - n2 == 1
  end

  def is_one_greater?(n1, n2)
    n1 - n2 == -1
  end

  def three_run_up?(n1, n2, n3)
    is_one_greater?(n1, n2) && is_one_greater?(n2, n3)
  end

  def three_run_down?(n1, n2, n3)
    is_one_less?(n1, n2) && is_one_less?(n2, n3)
  end

  def find_indexes_single_method
    indexes = []

    @array.each_with_index do |n, index|
      if (index <= @array.length - 3)

        test = 3.times.select do
          ((n - @array[index + 1] == 1) && (@array[index + 1] - @array[index + 2] == 1)) ||
            ((n - @array[index + 1] == -1 ) && (@array[index + 1] - @array[index + 2] == -1))
        end

        if test.length == 3
          indexes << index
        end
      end
    end

    indexes
  end

end

RunFinder.perform_example!

