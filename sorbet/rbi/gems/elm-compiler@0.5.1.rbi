# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `elm-compiler` gem.
# Please instead update this file by running `bin/tapioca gem elm-compiler`.

# source://elm-compiler//lib/elm/compiler/exceptions.rb#1
module Elm; end

# source://elm-compiler//lib/elm/compiler/exceptions.rb#2
class Elm::Compiler
  class << self
    # source://elm-compiler//lib/elm/compiler.rb#15
    def compile(elm_files, output_path: T.unsafe(nil), elm_path: T.unsafe(nil), debug: T.unsafe(nil), esm: T.unsafe(nil)); end

    # source://elm-compiler//lib/elm/compiler.rb#9
    def elm_path; end

    # source://elm-compiler//lib/elm/compiler.rb#8
    def elm_path=(_arg0); end

    # source://elm-compiler//lib/elm/compiler.rb#13
    def esm; end

    # source://elm-compiler//lib/elm/compiler.rb#13
    def esm=(_arg0); end

    private

    # source://elm-compiler//lib/elm/compiler.rb#26
    def compile_to_string(elm_path, elm_files, debug, esm); end

    # source://elm-compiler//lib/elm/compiler.rb#48
    def convert_file_to_esm!(path); end

    # source://elm-compiler//lib/elm/compiler.rb#58
    def elm_executable_exists?(path); end

    # source://elm-compiler//lib/elm/compiler.rb#64
    def elm_from_env_path; end

    # source://elm-compiler//lib/elm/compiler.rb#33
    def elm_make(elm_path, elm_files, output_path, debug, esm); end

    # source://elm-compiler//lib/elm/compiler.rb#68
    def our_elm_path; end
  end
end

# source://elm-compiler//lib/elm/compiler/exceptions.rb#5
class Elm::Compiler::CompileError < ::Elm::Compiler::Error; end

# source://elm-compiler//lib/elm/compiler/exceptions.rb#3
class Elm::Compiler::Error < ::StandardError; end

# source://elm-compiler//lib/elm/compiler/exceptions.rb#4
class Elm::Compiler::ExecutableNotFound < ::Elm::Compiler::Error; end

# source://elm-compiler//lib/elm/compiler/version.rb#3
Elm::Compiler::VERSION = T.let(T.unsafe(nil), String)
