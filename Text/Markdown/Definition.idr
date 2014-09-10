
module Text.Markdown.Definition

------------------------------------------------------------- Inline

data Literal = MkLiteral String

data InlineTag = Str
               | SoftBreak
               | LineBreak
               | Code
               | RawHtml
               | Entity
               | Emph
               | Strong
               | Link
               | Image

mutual
  data Inline = NullInline | MkInline Inline'

  record Linkable : Type where
         MkLinkable : (label : Inline) ->
                      (url   : String) ->
                      (title : String) ->
                      Linkable

  data Content = NullContent
               | MkLiteralContent  Literal
               | MkInlineContent   Inline
               | MkLinkableContent Linkable

  record Inline' : Type where
         MkInline' : (tag     : InlineTag) ->
                     (content : Content)   ->
                     (next    : Inline)    ->
                     Inline'

-------------------------------------------------------------- Block

data BlockTag = Document
              | BlockQuote
              | GenericList
              | GenericListItem
              | FencedCode
              | IndentedCode
              | HtmlBlock
              | Paragraph
              | AtxHeader
              | SetExtHeader
              | HRule
              | ReferenceDef

data ListType = Bullet
              | Ordered

data Delimiter = Period
               | Parens

record ListData : Type where
       MkListData : (listType     : ListType)  ->
                    (markerOffset : Int)       ->
                    (padding      : Int)       ->
                    (start        : Int)       ->
                    (delimiter    : Delimiter) ->
                    (bulletChar   : Char)      ->
                    (tight        : Bool)      ->
                    ListData

record FencedCodeData : Type where
       MkFencedCodeData : (fenceLength : Int)    ->
                          (fenceOffset : Int)    ->
                          (fenceChar   : Char)   ->
                          (info        : String) ->
                          FencedCodeData

data HeaderLevel = MkHeaderLevel Int

-- data RefMap --FIXME!

data Attributes = NullAttributes
                | MkListDataAttributes       ListData
                | MkFencedCodeDataAttributes FencedCodeData
                | MkHeaderLevelAttributes    HeaderLevel
                -- | MkRefMapAttributes      RefMap --FIXME!

mutual
  data Block = NullBlock | MkBlock Block'

  record Block' : Type where
         MkBlock' : (tag           : BlockTag)   ->
                    (startLine     : Int)        ->
                    (startColumn   : Int)        ->
                    (endLine       : Int)        ->
                    (open          : Bool)       ->
                    (lastLineBlank : Bool)       ->
                    (children      : Block)      ->
                    (stringContent : String)     ->
                    (inlineContent : Inline)     ->
                    (attributes    : Attributes) ->
                    (next          : Block)      ->
                    Block'

------------------------------------------------------------ MarkDoc

data MarkDoc = MkMarkDoc Block
