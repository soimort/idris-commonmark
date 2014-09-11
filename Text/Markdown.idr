
module Text.Markdown

import Text.Markdown.Definition
import Text.Markdown.Options



-- Direct foreign function calls -----------------------------------

-- void free(void* ptr);
cFree : Ptr -> IO ()
cFree ptr = mkForeign (FFun "free" [FPtr] FUnit) ptr

-- void free_blocks(block* e);
cFreeBlocks : Ptr -> IO ()
cFreeBlocks ptr = mkForeign (FFun "free_blocks" [FPtr] FUnit) ptr

-- void print_blocks(block* b, int indent);
cPrintBlocks : Ptr -> Int -> IO ()
cPrintBlocks ptr indent = mkForeign (FFun "print_blocks" [FPtr, FInt] FUnit) ptr indent

-- void print_inlines(inl* ils, int indent);
cPrintInlines : Ptr -> Int -> IO ()
cPrintInlines ptr indent = mkForeign (FFun "print_inlines" [FPtr, FInt] FUnit) ptr indent

-- block *readMarkdown(char *str);
cReadMarkdown : String -> IO Ptr
cReadMarkdown str = mkForeign (FFun "readMarkdown" [FString] FPtr) str

-- char *writeHtml(block *cur);
cWriteHtml : Ptr -> IO String
cWriteHtml ptr = mkForeign (FFun "writeHtml" [FPtr] FString) ptr

-- void printHtml(block *cur);
cPrintHtml : Ptr -> IO ()
cPrintHtml ptr = mkForeign (FFun "printHtml" [FPtr] FUnit) ptr



-- High-level binding: struct Inline* => data Inline ---------------

-- const char *getInlineTag(inl *i);
cGetInlineTag : Ptr -> IO InlineTag
cGetInlineTag ptr = return $ case !(mkForeign (FFun "getInlineTag" [FPtr] FString) ptr) of
                                  "str"       => Str
                                  "softbreak" => SoftBreak
                                  "linebreak" => LineBreak
                                  "code"      => Code
                                  "raw_html"  => RawHtml
                                  "entity"    => Entity
                                  "emph"      => Emph
                                  "strong"    => Strong
                                  "link"      => Link
                                  "image"     => Image

-- const char *getInlineContent_Literal(inl *i);
cGetInlineContent_Literal : Ptr -> IO Literal
cGetInlineContent_Literal ptr = mkForeign (FFun "getInlineContent_Literal" [FPtr] FString) ptr >>= return . MkLiteral

-- inl *getInlineContent_Inlines(inl *i);
cGetInlineContent_Inlines : Ptr -> IO Ptr
cGetInlineContent_Inlines ptr = mkForeign (FFun "getInlineContent_Inlines" [FPtr] FPtr) ptr

-- inl *getInlineContent_Linkable_Label(inl *i);
cGetInlineContent_Linkable_Label : Ptr -> IO Ptr
cGetInlineContent_Linkable_Label ptr = mkForeign (FFun "getInlineContent_Linkable_Label" [FPtr] FPtr) ptr

-- const char *getInlineContent_Linkable_Url(inl *i);
cGetInlineContent_Linkable_Url : Ptr -> IO String
cGetInlineContent_Linkable_Url ptr = mkForeign (FFun "getInlineContent_Linkable_Url" [FPtr] FString) ptr

-- const char *getInlineContent_Linkable_Title(inl *i);
cGetInlineContent_Linkable_Title : Ptr -> IO String
cGetInlineContent_Linkable_Title ptr = mkForeign (FFun "getInlineContent_Linkable_Title" [FPtr] FString) ptr

-- inl *getInlineNext(inl *i);
cGetInlineNext : Ptr -> IO Ptr
cGetInlineNext ptr = mkForeign (FFun "getInlineNext" [FPtr] FPtr) ptr



-- High-level binding: struct Block* => data Block -----------------

-- const char *getBlockTag(block *cur);
cGetBlockTag : Ptr -> IO BlockTag
cGetBlockTag ptr = return $ case !(mkForeign (FFun "getBlockTag" [FPtr] FString) ptr) of
                                 "document"      => Document
                                 "block_quote"   => BlockQuote
                                 "list"          => GenericList
                                 "list_item"     => GenericListItem
                                 "fenced_code"   => FencedCode
                                 "indented_code" => IndentedCode
                                 "html_block"    => HtmlBlock
                                 "paragraph"     => Paragraph
                                 "atx_header"    => AtxHeader
                                 "setext_header" => SetExtHeader
                                 "hrule"         => HRule
                                 "reference_def" => ReferenceDef

-- int getBlockStartLine(block *cur);
cGetBlockStartLine : Ptr -> IO Int
cGetBlockStartLine ptr = mkForeign (FFun "getBlockStartLine" [FPtr] FInt) ptr

-- int getBlockStartColumn(block *cur);
cGetBlockStartColumn : Ptr -> IO Int
cGetBlockStartColumn ptr = mkForeign (FFun "getBlockStartColumn" [FPtr] FInt) ptr

-- int getBlockEndLine(block *cur);
cGetBlockEndLine : Ptr -> IO Int
cGetBlockEndLine ptr = mkForeign (FFun "getBlockEndLine" [FPtr] FInt) ptr

-- bool getBlockOpen(block *cur);
cGetBlockOpen : Ptr -> IO Bool
cGetBlockOpen ptr = mkForeign (FFun "getBlockOpen" [FPtr] FInt) ptr >>= return . (/= 0)

-- bool getBlockLastLineBlank(block *cur);
cGetBlockLastLineBlank : Ptr -> IO Bool
cGetBlockLastLineBlank ptr = mkForeign (FFun "getBlockLastLineBlank" [FPtr] FInt) ptr >>= return . (/= 0)

-- struct Block *getBlockChildren(block *cur);
cGetBlockChildren : Ptr -> IO Ptr
cGetBlockChildren ptr = mkForeign (FFun "getBlockChildren" [FPtr] FPtr) ptr

-- const char *getBlockStringContent(block *cur);
cGetBlockStringContent : Ptr -> IO String
cGetBlockStringContent ptr = mkForeign (FFun "getBlockStringContent" [FPtr] FString) ptr

-- inl *getBlockInlineContent(block *cur);
cGetBlockInlineContent : Ptr -> IO Ptr
cGetBlockInlineContent ptr = mkForeign (FFun "getBlockInlineContent" [FPtr] FPtr) ptr

-- const char *getBlockAttributes_ListData_ListType(block *cur);
cGetBlockAttributes_ListData_ListType : Ptr -> IO ListType
cGetBlockAttributes_ListData_ListType ptr = return $ case !(mkForeign (FFun "getBlockAttributes_ListData_ListType" [FPtr] FString) ptr) of
                                                          "bullet" => Bullet
                                                          "ordered" => Ordered

-- int getBlockAttributes_ListData_MarkerOffset(block *cur);
cGetBlockAttributes_ListData_MarkerOffset : Ptr -> IO Int
cGetBlockAttributes_ListData_MarkerOffset ptr = mkForeign (FFun "getBlockAttributes_ListData_MarkerOffset" [FPtr] FInt) ptr

-- int getBlockAttributes_ListData_Padding(block *cur);
cGetBlockAttributes_ListData_Padding : Ptr -> IO Int
cGetBlockAttributes_ListData_Padding ptr = mkForeign (FFun "getBlockAttributes_ListData_Padding" [FPtr] FInt) ptr

-- int getBlockAttributes_ListData_Start(block *cur);
cGetBlockAttributes_ListData_Start : Ptr -> IO Int
cGetBlockAttributes_ListData_Start ptr = mkForeign (FFun "getBlockAttributes_ListData_Start" [FPtr] FInt) ptr

-- const char *getBlockAttributes_ListData_Delimiter(block *cur);
cGetBlockAttributes_ListData_Delimiter : Ptr -> IO Delimiter
cGetBlockAttributes_ListData_Delimiter ptr = return $ case !(mkForeign (FFun "getBlockAttributes_ListData_Delimiter" [FPtr] FString) ptr) of
                                                           "period" => Period
                                                           "parens" => Parens

-- char getBlockAttributes_ListData_BulletChar(block *cur);
cGetBlockAttributes_ListData_BulletChar : Ptr -> IO Char
cGetBlockAttributes_ListData_BulletChar ptr = mkForeign (FFun "getBlockAttributes_ListData_BulletChar" [FPtr] FChar) ptr

-- bool getBlockAttributes_ListData_Tight(block *cur);
cGetBlockAttributes_ListData_Tight : Ptr -> IO Bool
cGetBlockAttributes_ListData_Tight ptr = mkForeign (FFun "getBlockAttributes_ListData_Tight" [FPtr] FInt) ptr >>= return . (/= 0)

-- int getBlockAttributes_FencedCodeData_FenceLength(block *cur);
cGetBlockAttributes_FencedCodeData_FenceLength : Ptr -> IO Int
cGetBlockAttributes_FencedCodeData_FenceLength ptr = mkForeign (FFun "getBlockAttributes_FencedCodeData_FenceLength" [FPtr] FInt) ptr

-- int getBlockAttributes_FencedCodeData_FenceOffset(block *cur);
cGetBlockAttributes_FencedCodeData_FenceOffset : Ptr -> IO Int
cGetBlockAttributes_FencedCodeData_FenceOffset ptr = mkForeign (FFun "getBlockAttributes_FencedCodeData_FenceOffset" [FPtr] FInt) ptr

-- char getBlockAttributes_FencedCodeData_FenceChar(block *cur);
cGetBlockAttributes_FencedCodeData_FenceChar : Ptr -> IO Char
cGetBlockAttributes_FencedCodeData_FenceChar ptr = mkForeign (FFun "getBlockAttributes_FencedCodeData_FenceChar" [FPtr] FChar) ptr

-- const char *getBlockAttributes_FencedCodeData_Info(block *cur);
cGetBlockAttributes_FencedCodeData_Info : Ptr -> IO String
cGetBlockAttributes_FencedCodeData_Info ptr = mkForeign (FFun "getBlockAttributes_FencedCodeData_Info" [FPtr] FString) ptr

-- int getBlockAttributes_HeaderLevel(block *cur);
cGetBlockAttributes_HeaderLevel : Ptr -> IO HeaderLevel
cGetBlockAttributes_HeaderLevel ptr = mkForeign (FFun "getBlockAttributes_HeaderLevel" [FPtr] FInt) ptr >>= return . MkHeaderLevel

-- struct Block *getBlockNext(block *cur);
cGetBlockNext : Ptr -> IO Ptr
cGetBlockNext ptr = mkForeign (FFun "getBlockNext" [FPtr] FPtr) ptr



-- High-level binding: cGetInline ----------------------------------

mutual
  cGetInlineContent_Linkable: Ptr -> IO Linkable
  cGetInlineContent_Linkable cur = return $ MkLinkable !(cGetInline !(cGetInlineContent_Linkable_Label cur))
                                                       !(cGetInlineContent_Linkable_Url cur)
                                                       !(cGetInlineContent_Linkable_Title cur)

  cGetInlineContent : Ptr -> InlineTag -> IO Content
  cGetInlineContent cur tag = case tag of
                                   Str       => cGetInlineContent_Literal cur >>= return . MkLiteralContent
                                   SoftBreak => return NullContent
                                   LineBreak => return NullContent
                                   Code      => cGetInlineContent_Literal cur >>= return . MkLiteralContent
                                   RawHtml   => cGetInlineContent_Literal cur >>= return . MkLiteralContent
                                   Entity    => cGetInlineContent_Literal cur >>= return . MkLiteralContent
                                   Emph      => cGetInlineContent_Linkable cur >>= return . MkLinkableContent
                                   Strong    => cGetInlineContent_Linkable cur >>= return . MkLinkableContent
                                   Link      => cGetInlineContent_Linkable cur >>= return . MkLinkableContent
                                   Image     => cGetInlineContent_Linkable cur >>= return . MkLinkableContent

  cGetInline : Ptr -> IO Inline
  cGetInline cur = if !(nullPtr cur)
                      then return NullInline
                      else do
                           tag <- cGetInlineTag cur
                           return $ MkInline
                                  $ MkInline' tag
                                              !(cGetInlineContent cur tag)
                                              !(cGetInline !(cGetInlineNext cur))



-- High-level binding: cGetBlock -----------------------------------

cGetBlockAttributes_ListData : Ptr -> IO ListData
cGetBlockAttributes_ListData cur = return $ MkListData !(cGetBlockAttributes_ListData_ListType cur)
                                                       !(cGetBlockAttributes_ListData_MarkerOffset cur)
                                                       !(cGetBlockAttributes_ListData_Padding cur)
                                                       !(cGetBlockAttributes_ListData_Start cur)
                                                       !(cGetBlockAttributes_ListData_Delimiter cur)
                                                       !(cGetBlockAttributes_ListData_BulletChar cur)
                                                       !(cGetBlockAttributes_ListData_Tight cur)

cGetBlockAttributes_FencedCodeData : Ptr -> IO FencedCodeData
cGetBlockAttributes_FencedCodeData cur = return $ MkFencedCodeData !(cGetBlockAttributes_FencedCodeData_FenceLength cur)
                                                                   !(cGetBlockAttributes_FencedCodeData_FenceOffset cur)
                                                                   !(cGetBlockAttributes_FencedCodeData_FenceChar cur)
                                                                   !(cGetBlockAttributes_FencedCodeData_Info cur)

cGetBlockAttributes : Ptr -> BlockTag -> IO Attributes
cGetBlockAttributes cur tag = case tag of
                                   Document        => return NullAttributes
                                   BlockQuote      => return NullAttributes
                                   GenericList     => cGetBlockAttributes_ListData cur >>= return . MkListDataAttributes
                                   GenericListItem => cGetBlockAttributes_ListData cur >>= return . MkListDataAttributes
                                   FencedCode      => cGetBlockAttributes_FencedCodeData cur >>= return . MkFencedCodeDataAttributes
                                   IndentedCode    => return NullAttributes
                                   HtmlBlock       => return NullAttributes
                                   Paragraph       => return NullAttributes
                                   AtxHeader       => cGetBlockAttributes_HeaderLevel cur >>= return . MkHeaderLevelAttributes
                                   SetExtHeader    => cGetBlockAttributes_HeaderLevel cur >>= return . MkHeaderLevelAttributes
                                   HRule           => return NullAttributes
                                   ReferenceDef    => return NullAttributes --FIXME!

cGetBlock : Ptr -> IO Block
cGetBlock cur = if !(nullPtr cur)
                   then return NullBlock
                   else do
                        tag <- cGetBlockTag cur
                        return $ MkBlock
                               $ MkBlock' tag
                                          !(cGetBlockStartLine cur)
                                          !(cGetBlockStartColumn cur)
                                          !(cGetBlockEndLine cur)
                                          !(cGetBlockOpen cur)
                                          !(cGetBlockLastLineBlank cur)
                                          !(cGetBlock !(cGetBlockChildren cur))
                                          !(cGetBlockStringContent cur)
                                          !(cGetInline !(cGetBlockInlineContent cur))
                                          !(cGetBlockAttributes cur tag)
                                          !(cGetBlock !(cGetBlockNext cur))



-- Idris API -------------------------------------------------------

readMarkdown : ReaderOptions -> String -> Markdown
readMarkdown opts s = unsafePerformIO $
                      do
                      cur <- cReadMarkdown s
                      block <- cGetBlock cur
                      cFreeBlocks cur
                      return $ MkMarkdown (MkMeta s)
                                          [block]

readMarkdown' : String -> Markdown
readMarkdown' = readMarkdown def

writeMarkdown : WriterOptions -> Markdown -> String
writeMarkdown opts m = unsafePerformIO $
                       do
                       let s = source (meta m)
                       return s

writeMarkdown' : Markdown -> String
writeMarkdown' = writeMarkdown def

writeHtml : WriterOptions -> Markdown -> String
writeHtml opts m = unsafePerformIO $
                   do
                   let s = source (meta m)
                   cur <- cReadMarkdown s
                   html <- cWriteHtml cur
                   cFreeBlocks cur
                   return html

writeHtml' : Markdown -> String
writeHtml' = writeHtml def

printMarkdown : WriterOptions -> Markdown -> IO ()
printMarkdown opts m = putStrLn $ writeMarkdown opts m

printMarkdown' : Markdown -> IO ()
printMarkdown' = printMarkdown def

printHtml : WriterOptions -> Markdown -> IO ()
printHtml opts m = putStrLn $ writeHtml opts m

printHtml' : Markdown -> IO ()
printHtml' = printHtml def

printAST : WriterOptions -> Markdown -> IO ()
printAST opts m = do
                  let s = source (meta m)
                  cur <- cReadMarkdown s
                  cPrintBlocks cur 0
                  cFreeBlocks cur

printAST' : Markdown -> IO ()
printAST' = printAST def
