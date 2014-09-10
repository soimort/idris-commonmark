
int incorporateMarkdownLine(const char *str, int lineNumber, block **cur);
char **splitString(const char *str, const char *delimiters);
block *readMarkdownLines(char **lines);
block *readMarkdown(char *str);
void writeAST(block *cur, int indent);

const char *getInlineTag(inl *i);
const char *getInlineContent_Literal(inl *i);
inl *getInlineContent_Inlines(inl *i);
inl *getInlineContent_Linkable_Label(inl *i);
const char *getInlineContent_Linkable_Url(inl *i);
const char *getInlineContent_Linkable_Title(inl *i);
inl *getInlineNext(inl *i);

const char *getBlockTag(block *cur);
int getBlockStartLine(block *cur);
int getBlockStartColumn(block *cur);
int getBlockEndLine(block *cur);
bool getBlockOpen(block *cur);
bool getBlockLastLineBlank(block *cur);
struct Block *getBlockChildren(block *cur);
const char *getBlockStringContent(block *cur);
inl *getBlockInlineContent(block *cur);
const char *getBlockAttributes_ListData_ListType(block *cur);
int getBlockAttributes_ListData_MarkerOffset(block *cur);
int getBlockAttributes_ListData_Padding(block *cur);
int getBlockAttributes_ListData_Start(block *cur);
const char *getBlockAttributes_ListData_Delimiter(block *cur);
char getBlockAttributes_ListData_BulletChar(block *cur);
bool getBlockAttributes_ListData_Tight(block *cur);
int getBlockAttributes_FencedCodeData_FenceLength(block *cur);
int getBlockAttributes_FencedCodeData_FenceOffset(block *cur);
char getBlockAttributes_FencedCodeData_FenceChar(block *cur);
const char *getBlockAttributes_FencedCodeData_Info(block *cur);
int getBlockAttributes_HeaderLevel(block *cur);
struct Block *getBlockNext(block *cur);
