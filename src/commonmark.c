#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "bstrlib.h"
#include "stmd.h"

#include "commonmark.h"

int incorporateMarkdownLine(const char *str, int lineNumber, cmark_block **cur)
{
    bstring bstr = bfromcstr(str);
    int returnCode = incorporate_line(bstr, lineNumber, cur);
    bdestroy(bstr);

    return returnCode;
}

char **splitString(const char *str, const char *delimiters)
{
    int lineCount = 0;
    char **result = (char **) malloc(sizeof(char *) * ++lineCount);
    char *tempStr = (char *) malloc(sizeof(char) * strlen(str));

    strcpy(tempStr, str);
    char *token = strtok(tempStr, delimiters);
    while (token != NULL) {
        result[lineCount - 1] = (char *) malloc(sizeof(char) * strlen(token));
        strcpy(result[lineCount - 1], token);
        result = (char **) realloc(result, sizeof(char *) * ++lineCount);
        token = strtok(NULL, delimiters);
    }

    free(tempStr);
    return result;
}

cmark_block *readMarkdownLines(char **lines)
{
    cmark_block *cur = make_document();

    for (int i = 0; lines[i]; i++)
        assert(incorporateMarkdownLine(lines[i], i + 1, &cur) == 0);

    while (cur != cur->top) {
        finalize(cur, 1);
        cur = cur->parent;
    }
    assert(cur == cur->top); // problems finalizing open containers
    finalize(cur, 1);

    process_inlines(cur, cur->attributes.refmap);

    return cur;
}

cmark_block *readMarkdown(char *str)
{
    char **lines = splitString(str, "\n");
    cmark_block *cur = readMarkdownLines(lines);

    for (int i = 0; lines[i]; i++)
        free(lines[i]);
    free(lines);
    return cur;
}

char *writeHtml(cmark_block *cur)
{
    bstring html;
    assert(blocks_to_html(cur, &html, false) == 0); // could not format as HTML
    char *result = (char *) malloc(sizeof(char) * strlen(html->data));
    strcpy(result, html->data);

    bdestroy(html);
    return result;
}

void printHtml(cmark_block *cur)
{
    bstring html;
    assert(blocks_to_html(cur, &html, false) == 0); // could not format as HTML
    printf("%s", html->data);
    bdestroy(html);
}

/* Inline */

const char *getInlineTag(cmark_inl *i) {
    switch (i->tag) {
    case cmark_str:
        return "str";
    case cmark_softbreak:
        return "softbreak";
    case cmark_linebreak:
        return "linebreak";
    case cmark_code:
        return "code";
    case cmark_raw_html:
        return "raw_html";
    case cmark_entity:
        return "entity";
    case cmark_emph:
        return "emph";
    case cmark_strong:
        return "strong";
    case cmark_link:
        return "link";
    case cmark_image:
        return "image";
    }
}

const char *getInlineContent_Literal(cmark_inl *i) {
    return bstr2cstr(i->content.literal, 0);
}

inline cmark_inl *getInlineContent_Inlines(cmark_inl *i) {
    return i->content.inlines;
}

inline cmark_inl *getInlineContent_Linkable_Label(cmark_inl *i) {
    return i->content.linkable.label;
}

const char *getInlineContent_Linkable_Url(cmark_inl *i) {
    return bstr2cstr(i->content.linkable.url, 0);
}

const char *getInlineContent_Linkable_Title(cmark_inl *i) {
    return bstr2cstr(i->content.linkable.title, 0);
}

inline cmark_inl *getInlineNext(cmark_inl *i) {
    return i->next;
}

/* Block */

const char *getBlockTag(cmark_block *cur) {
    switch (cur->tag) {
    case cmark_document:
        return "document";
        break;
    case cmark_block_quote:
        return "block_quote";
        break;
    case cmark_list:
        return "list";
        break;
    case cmark_list_item:
        return "list_item";
        break;
    case cmark_fenced_code:
        return "fenced_code";
        break;
    case cmark_indented_code:
        return "indented_code";
        break;
    case cmark_html_block:
        return "html_block";
        break;
    case cmark_paragraph:
        return "paragraph";
        break;
    case cmark_atx_header:
        return "atx_header";
        break;
    case cmark_setext_header:
        return "setext_header";
        break;
    case cmark_hrule:
        return "hrule";
        break;
    case cmark_reference_def:
        return "reference_def";
        break;
    }
}

inline int getBlockStartLine(cmark_block *cur) {
    return cur->start_line;
}

inline int getBlockStartColumn(cmark_block *cur) {
    return cur->start_column;
}

inline int getBlockEndLine(cmark_block *cur) {
    return cur->end_line;
}

inline bool getBlockOpen(cmark_block *cur) {
    return cur->open;
}

inline bool getBlockLastLineBlank(cmark_block *cur) {
    return cur->last_line_blank;
}

inline struct cmark_Block *getBlockChildren(cmark_block *cur) {
    return cur->children;
}

const char *getBlockStringContent(cmark_block *cur) {
    return bstr2cstr(cur->string_content, 0);
}

inline cmark_inl *getBlockInlineContent(cmark_block *cur) {
    return cur->inline_content;
}

const char *getBlockAttributes_ListData_ListType(cmark_block *cur) {
    switch (cur->attributes.list_data.list_type) {
    case cmark_bullet:
        return "bullet";
        break;
    case cmark_ordered:
        return "ordered";
        break;
    }
}

inline int getBlockAttributes_ListData_MarkerOffset(cmark_block *cur) {
    return cur->attributes.list_data.marker_offset;
}

inline int getBlockAttributes_ListData_Padding(cmark_block *cur) {
    return cur->attributes.list_data.padding;
}

inline int getBlockAttributes_ListData_Start(cmark_block *cur) {
    return cur->attributes.list_data.start;
}

const char *getBlockAttributes_ListData_Delimiter(cmark_block *cur) {
    switch (cur->attributes.list_data.delimiter) {
    case cmark_period:
        return "period";
        break;
    case cmark_parens:
        return "parens";
        break;
    }
}

inline char getBlockAttributes_ListData_BulletChar(cmark_block *cur) {
    return cur->attributes.list_data.bullet_char;
}

inline bool getBlockAttributes_ListData_Tight(cmark_block *cur) {
    return cur->attributes.list_data.tight;
}

inline int getBlockAttributes_FencedCodeData_FenceLength(cmark_block *cur) {
    return cur->attributes.fenced_code_data.fence_length;
}

inline int getBlockAttributes_FencedCodeData_FenceOffset(cmark_block *cur) {
    return cur->attributes.fenced_code_data.fence_offset;
}

inline char getBlockAttributes_FencedCodeData_FenceChar(cmark_block *cur) {
    return cur->attributes.fenced_code_data.fence_char;
}

const char *getBlockAttributes_FencedCodeData_Info(cmark_block *cur) {
    return bstr2cstr(cur->attributes.fenced_code_data.info, 0);
}

inline int getBlockAttributes_HeaderLevel(cmark_block *cur) {
    return cur->attributes.header_level;
}

inline struct cmark_Block *getBlockNext(cmark_block *cur) {
    return cur->next;
}
