#!/usr/bin/env ruby
# encoding: BINARY
# Ruby tests for AMD secrng lib interface. Coded by Wojciech Lawren.
require_relative "amd_rng"
require "test/unit"

fail "RDRAND not supported" unless RNG.is_RDRAND_supported == RNG::SECRNG_SUPPORTED
fail "RDSEED not supported" unless RNG.is_RDSEED_supported == RNG::SECRNG_SUPPORTED

class RngTest < Test::Unit::TestCase
  include RNG
  @@retry = 3   # retry count
  @@length = 6  # array length
  @@rand = Random.rand 0...@@length # pseudorandom index

  def test_rdrand16u
    v = FFI::MemoryPointer.new :uint16
    assert (get_rdrand16u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint16, 0) > 0
  end

  def test_rdseed16u
    v = FFI::MemoryPointer.new :uint16
    assert (get_rdseed16u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint16, 0) > 0
  end

  def test_rdrand32u
    v = FFI::MemoryPointer.new :uint32
    assert (get_rdrand32u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint32, 0) > 0
  end

  def test_rdseed32u
    v = FFI::MemoryPointer.new :uint32
    assert (get_rdseed32u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint32, 0) > 0
  end

  def test_rdrand64u
    v = FFI::MemoryPointer.new :uint64
    assert (get_rdrand64u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint64, 0) > 0
  end

  def test_rdseed64u
    v = FFI::MemoryPointer.new :uint64
    assert (get_rdseed64u v, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint64, 0) > 0
  end

  def test_rdrand32u_arr
    v = FFI::MemoryPointer.new :uint32, @@length
    assert (get_rdrand32u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint32, @@rand) > 0
  end

  def test_rdseed32u_arr
    v = FFI::MemoryPointer.new :uint32, @@length
    assert (get_rdseed32u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint32, @@rand) > 0
  end

  def test_rdrand64u_arr
    v = FFI::MemoryPointer.new :uint64, @@length
    assert (get_rdrand64u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint64, @@rand) > 0
  end

  def test_rdseed64u_arr
    v = FFI::MemoryPointer.new :uint64, @@length
    assert (get_rdseed64u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get :uint64, @@rand) > 0
  end

  def test_rdrand_bytes_arr
    v = FFI::MemoryPointer.new :uint8, @@length
    assert (get_rdrand32u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get_bytes 0, @@length).encoding == Encoding::ASCII_8BIT
  end

  def test_rdseed_bytes_arr
    v = FFI::MemoryPointer.new :uint8, @@length
    assert (get_rdseed32u_arr v, @@length, @@retry) == SECRNG_SUCCESS
    assert (v.get_bytes 0, @@length).encoding == Encoding::ASCII_8BIT
  end
end # class RngTest
