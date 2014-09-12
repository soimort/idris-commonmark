
module Main

import Text.Markdown

main : IO ()
main = printHtml def
                 $ readMarkdown def
                                $ "# Heading 1\n" ++
                                  "\n" ++
                                  "## Heading 2\n" ++
                                  "\n" ++
                                  "Here is a list:\n" ++
                                  "* One\n" ++
                                  "* Two\n" ++
                                  "* Three\n"
