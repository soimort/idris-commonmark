
int incorporateMarkdownLine(const char *str, int lineNumber, cmark_block **cur);
char **splitString(const char *str, const char *delimiters);
cmark_block *readMarkdownLines(char **lines);
cmark_block *readMarkdown(char *str);
char *writeHtml(cmark_block *cur);
void printHtml(cmark_block *cur);

const char *getInlineTag(cmark_inl *i);
const char *getInlineContent_Literal(cmark_inl *i);
cmark_inl *getInlineContent_Inlines(cmark_inl *i);
cmark_inl *getInlineContent_Linkable_Label(cmark_inl *i);
const char *getInlineContent_Linkable_Url(cmark_inl *i);
const char *getInlineContent_Linkable_Title(cmark_inl *i);
cmark_inl *getInlineNext(cmark_inl *i);

const char *getBlockTag(cmark_block *cur);
int getBlockStartLine(cmark_block *cur);
int getBlockStartColumn(cmark_block *cur);
int getBlockEndLine(cmark_block *cur);
bool getBlockOpen(cmark_block *cur);
bool getBlockLastLineBlank(cmark_block *cur);
struct cmark_Block *getBlockChildren(cmark_block *cur);
const char *getBlockStringContent(cmark_block *cur);
cmark_inl *getBlockInlineContent(cmark_block *cur);
const char *getBlockAttributes_ListData_ListType(cmark_block *cur);
int getBlockAttributes_ListData_MarkerOffset(cmark_block *cur);
int getBlockAttributes_ListData_Padding(cmark_block *cur);
int getBlockAttributes_ListData_Start(cmark_block *cur);
const char *getBlockAttributes_ListData_Delimiter(cmark_block *cur);
char getBlockAttributes_ListData_BulletChar(cmark_block *cur);
bool getBlockAttributes_ListData_Tight(cmark_block *cur);
int getBlockAttributes_FencedCodeData_FenceLength(cmark_block *cur);
int getBlockAttributes_FencedCodeData_FenceOffset(cmark_block *cur);
char getBlockAttributes_FencedCodeData_FenceChar(cmark_block *cur);
const char *getBlockAttributes_FencedCodeData_Info(cmark_block *cur);
int getBlockAttributes_HeaderLevel(cmark_block *cur);
struct cmark_Block *getBlockNext(cmark_block *cur);
