
module Text.Markdown.Options

-- Default ----------------------------------------------------------

class Default a where
      def : a

-- ReaderOptions ----------------------------------------------------

record ReaderOptions : Type where
       MkReaderOptions : (readerStandalone : Bool) ->
                         ReaderOptions

instance Default ReaderOptions
         where def = MkReaderOptions
                        {readerStandalone = True}

-- WriterOptions ----------------------------------------------------

record WriterOptions : Type where
       MkWriterOptions : (writerStandalone : Bool) ->
                         WriterOptions

instance Default WriterOptions
         where def = MkWriterOptions
                        {writerStandalone = True}
