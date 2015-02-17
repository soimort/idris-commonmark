
/* int incorporateMarkdownLine(const char *str, int lineNumber, node_block **cur); */
char **splitString(const char *str, const char *delimiters);
node_block *readMarkdownLines(char **lines);
node_block *readMarkdown(char *str);
char *writeHtml(node_block *cur);
void printHtml(node_block *cur);

const char *getInlineTag(node_inl *i);
const char *getInlineContent_Literal(node_inl *i);
node_inl *getInlineContent_Inlines(node_inl *i);
node_inl *getInlineContent_Linkable_Label(node_inl *i);
const char *getInlineContent_Linkable_Url(node_inl *i);
const char *getInlineContent_Linkable_Title(node_inl *i);
node_inl *getInlineNext(node_inl *i);

const char *getBlockTag(node_block *cur);
int getBlockStartLine(node_block *cur);
int getBlockStartColumn(node_block *cur);
int getBlockEndLine(node_block *cur);
bool getBlockOpen(node_block *cur);
bool getBlockLastLineBlank(node_block *cur);
node_block *getBlockChildren(node_block *cur);
const char *getBlockStringContent(node_block *cur);
node_inl *getBlockInlineContent(node_block *cur);
const char *getBlockAttributes_ListData_ListType(node_block *cur);
int getBlockAttributes_ListData_MarkerOffset(node_block *cur);
int getBlockAttributes_ListData_Padding(node_block *cur);
int getBlockAttributes_ListData_Start(node_block *cur);
const char *getBlockAttributes_ListData_Delimiter(node_block *cur);
char getBlockAttributes_ListData_BulletChar(node_block *cur);
bool getBlockAttributes_ListData_Tight(node_block *cur);
int getBlockAttributes_FencedCodeData_FenceLength(node_block *cur);
int getBlockAttributes_FencedCodeData_FenceOffset(node_block *cur);
char getBlockAttributes_FencedCodeData_FenceChar(node_block *cur);
const char *getBlockAttributes_FencedCodeData_Info(node_block *cur);
int getBlockAttributes_HeaderLevel(node_block *cur);
node_block *getBlockNext(node_block *cur);
