#!/usr/bin/env ruby
# encoding: BINARY
# Ruby benchmark for AMD secrng lib interface. Coded by Wojciech Lawren.
require_relative "amd_rng"
require "benchmark"

include RNG
include Benchmark

fail "RDRAND not supported" unless is_RDRAND_supported == SECRNG_SUPPORTED
fail "RDSEED not supported" unless is_RDSEED_supported == SECRNG_SUPPORTED

N = 3       # retry count
n = 10_000  # block loops

v16 = FFI::MemoryPointer.new :uint16
v32 = FFI::MemoryPointer.new :uint32
v64 = FFI::MemoryPointer.new :uint64

bmbm 6 do |x|
  x.report "rdrand16" do n.times do get_rdrand16u v16, N end end
  x.report "rdseed16" do n.times do get_rdseed16u v16, N end end
  x.report "rdrand32" do n.times do get_rdrand32u v32, N end end
  x.report "rdseed32" do n.times do get_rdseed32u v32, N end end
  x.report "rdrand64" do n.times do get_rdrand64u v64, N end end
  x.report "rdseed64" do n.times do get_rdseed64u v64, N end end
end # bmbm block
