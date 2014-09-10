
module Text.Markdown

import Text.Markdown.Definition
import Text.Markdown.Options



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



------------------------------------------------------------- Inline

-- const char *getInlineTag(inl *i);
cGetInlineTag : Ptr -> IO String
cGetInlineTag ptr = mkForeign (FFun "getInlineTag" [FPtr] FString) ptr

-- const char *getInlineContent_Literal(inl *i);
cGetInlineContent_Literal : Ptr -> IO String
cGetInlineContent_Literal ptr = mkForeign (FFun "getInlineContent_Literal" [FPtr] FString) ptr

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

-------------------------------------------------------------- Block

-- const char *getBlockTag(block *cur);
cGetBlockTag : Ptr -> IO String
cGetBlockTag ptr = mkForeign (FFun "getGlockTag" [FPtr] FString) ptr

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
cGetBlockAttributes_ListData_ListType : Ptr -> IO String
cGetBlockAttributes_ListData_ListType ptr = mkForeign (FFun "getBlockAttributes_ListData_ListType" [FPtr] FString) ptr

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
cGetBlockAttributes_ListData_Delimiter : Ptr -> IO String
cGetBlockAttributes_ListData_Delimiter ptr = mkForeign (FFun "getBlockAttributes_ListData_Delimiter" [FPtr] FString) ptr

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
cGetBlockAttributes_HeaderLevel : Ptr -> IO Int
cGetBlockAttributes_HeaderLevel ptr = mkForeign (FFun "getBlockAttributes_HeaderLevel" [FPtr] FInt) ptr

-- struct Block *getBlockNext(block *cur);
cGetBlockNext : Ptr -> IO Ptr
cGetBlockNext ptr = mkForeign (FFun "getBlockNext" [FPtr] FPtr) ptr
