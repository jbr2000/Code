def main
  num_procs = [1, 4, 8, 12, 16, 20]
  num_cores = [1, 2, 4, 6, 8, 10]
  ppn = [1, 2, 2, 2, 2, 2]
  form = ["ijk", "ikj", "kij"]
  results = File.open("test_results", "w")

  3.times do |h|
    6.times do |i|
      results << "\n\t#{form[h]}:#{num_procs[i]}\n"
      5.times do
        puts "mpirun -hostfile #{num_cores[i]}cores -ppn #{ppn[i]} matrixmult < testin#{h} > test_results"
        results << `mpirun -hostfile #{num_cores[i]}cores -ppn #{ppn[i]} matrixmult < testin#{h}`
      end
    end
  end
end

main
