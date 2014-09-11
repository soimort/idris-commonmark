#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "bstrlib.h"
#include "stmd.h"

#include "commonmark.h"

int incorporateMarkdownLine(const char *str, int lineNumber, block **cur)
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

block *readMarkdownLines(char **lines)
{
    block *cur = make_document();

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

block *readMarkdown(char *str)
{
    char **lines = splitString(str, "\n");
    block *cur = readMarkdownLines(lines);

    for (int i = 0; lines[i]; i++)
        free(lines[i]);
    free(lines);
    return cur;
}

char *writeHtml(block *cur)
{
    bstring html;
    assert(blocks_to_html(cur, &html, false) == 0); // could not format as HTML
    char *result = (char *) malloc(sizeof(char) * strlen(html->data));
    strcpy(result, html->data);

    bdestroy(html);
    return result;
}

void printHtml(block *cur)
{
    bstring html;
    assert(blocks_to_html(cur, &html, false) == 0); // could not format as HTML
    printf("%s", html->data);
    bdestroy(html);
}

/* Inline */

const char *getInlineTag(inl *i) {
    switch (i->tag) {
    case str:
        return "str";
    case softbreak:
        return "softbreak";
    case linebreak:
        return "linebreak";
    case code:
        return "code";
    case raw_html:
        return "raw_html";
    case entity:
        return "entity";
    case emph:
        return "emph";
    case strong:
        return "strong";
    case link:
        return "link";
    case image:
        return "image";
    }
}

const char *getInlineContent_Literal(inl *i) {
    return bstr2cstr(i->content.literal, 0);
}

inline inl *getInlineContent_Inlines(inl *i) {
    return i->content.inlines;
}

inline inl *getInlineContent_Linkable_Label(inl *i) {
    return i->content.linkable.label;
}

const char *getInlineContent_Linkable_Url(inl *i) {
    return bstr2cstr(i->content.linkable.url, 0);
}

const char *getInlineContent_Linkable_Title(inl *i) {
    return bstr2cstr(i->content.linkable.title, 0);
}

inline inl *getInlineNext(inl *i) {
    return i->next;
}

/* Block */

const char *getBlockTag(block *cur) {
    switch (cur->tag) {
    case document:
        return "document";
        break;
    case block_quote:
        return "block_quote";
        break;
    case list:
        return "list";
        break;
    case list_item:
        return "list_item";
        break;
    case fenced_code:
        return "fenced_code";
        break;
    case indented_code:
        return "indented_code";
        break;
    case html_block:
        return "html_block";
        break;
    case paragraph:
        return "paragraph";
        break;
    case atx_header:
        return "atx_header";
        break;
    case setext_header:
        return "setext_header";
        break;
    case hrule:
        return "hrule";
        break;
    case reference_def:
        return "reference_def";
        break;
    }
}

inline int getBlockStartLine(block *cur) {
    return cur->start_line;
}

inline int getBlockStartColumn(block *cur) {
    return cur->start_column;
}

inline int getBlockEndLine(block *cur) {
    return cur->end_line;
}

inline bool getBlockOpen(block *cur) {
    return cur->open;
}

inline bool getBlockLastLineBlank(block *cur) {
    return cur->last_line_blank;
}

inline struct Block *getBlockChildren(block *cur) {
    return cur->children;
}

const char *getBlockStringContent(block *cur) {
    return bstr2cstr(cur->string_content, 0);
}

inline inl *getBlockInlineContent(block *cur) {
    return cur->inline_content;
}

const char *getBlockAttributes_ListData_ListType(block *cur) {
    switch (cur->attributes.list_data.list_type) {
    case bullet:
        return "bullet";
        break;
    case ordered:
        return "ordered";
        break;
    }
}

inline int getBlockAttributes_ListData_MarkerOffset(block *cur) {
    return cur->attributes.list_data.marker_offset;
}

inline int getBlockAttributes_ListData_Padding(block *cur) {
    return cur->attributes.list_data.padding;
}

inline int getBlockAttributes_ListData_Start(block *cur) {
    return cur->attributes.list_data.start;
}

const char *getBlockAttributes_ListData_Delimiter(block *cur) {
    switch (cur->attributes.list_data.delimiter) {
    case period:
        return "period";
        break;
    case parens:
        return "parens";
        break;
    }
}

inline char getBlockAttributes_ListData_BulletChar(block *cur) {
    return cur->attributes.list_data.bullet_char;
}

inline bool getBlockAttributes_ListData_Tight(block *cur) {
    return cur->attributes.list_data.tight;
}

inline int getBlockAttributes_FencedCodeData_FenceLength(block *cur) {
    return cur->attributes.fenced_code_data.fence_length;
}

inline int getBlockAttributes_FencedCodeData_FenceOffset(block *cur) {
    return cur->attributes.fenced_code_data.fence_offset;
}

inline char getBlockAttributes_FencedCodeData_FenceChar(block *cur) {
    return cur->attributes.fenced_code_data.fence_char;
}

const char *getBlockAttributes_FencedCodeData_Info(block *cur) {
    return bstr2cstr(cur->attributes.fenced_code_data.info, 0);
}

inline int getBlockAttributes_HeaderLevel(block *cur) {
    return cur->attributes.header_level;
}

inline struct Block *getBlockNext(block *cur) {
    return cur->next;
}
