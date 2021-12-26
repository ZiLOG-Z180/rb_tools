#!/usr/bin/env ruby
# encoding: BINARY
# Ruby interface for AMD secrng lib. Coded by Wojciech Lawren.
require "ffi"
# RDRAND RDSEED
module RNG
  extend FFI::Library
  ffi_lib "amdsecrng"
  # Success return values
  SECRNG_SUPPORTED = 1
  SECRNG_SUCCESS = 2

  attach_function :is_RDRAND_supported, [], :int32
  attach_function :is_RDSEED_supported, [], :int32

  attach_function :get_rdrand16u, [:pointer, :uint32], :int32
  attach_function :get_rdseed16u, [:pointer, :uint32], :int32
  attach_function :get_rdrand32u, [:pointer, :uint32], :int32
  attach_function :get_rdseed32u, [:pointer, :uint32], :int32
  attach_function :get_rdrand64u, [:pointer, :uint32], :int32
  attach_function :get_rdseed64u, [:pointer, :uint32], :int32

  attach_function :get_rdrand32u_arr, [:pointer, :uint32, :uint32], :int32
  attach_function :get_rdseed32u_arr, [:pointer, :uint32, :uint32], :int32
  attach_function :get_rdrand64u_arr, [:pointer, :uint32, :uint32], :int32
  attach_function :get_rdseed64u_arr, [:pointer, :uint32, :uint32], :int32
  attach_function :get_rdrand_bytes_arr, [:pointer, :uint32, :uint32], :int32
  attach_function :get_rdseed_bytes_arr, [:pointer, :uint32, :uint32], :int32
end # module RNG
