#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "cmark.h"
#include "buffer.h"

#include "commonmark.h"

inline node_block *readMarkdown(char *str)
{
    return cmark_parse_document(str, strlen(str));
}

char *writeHtml(node_block *cur)
{
    strbuf html;
    cmark_render_html(&html, cur);
    return strbuf_detach(&html);
}

void printHtml(node_block *cur)
{
    strbuf html;
    cmark_render_html(&html, cur);
    printf("%s", strbuf_cstr(&html));
    strbuf_free(&html);
}

/* Inline */

const char *getInlineTag(node_inl *i) {
    switch (i->tag) {
    case INL_STRING:
        return "str";
    case INL_SOFTBREAK:
        return "softbreak";
    case INL_LINEBREAK:
        return "linebreak";
    case INL_CODE:
        return "code";
    case INL_RAW_HTML:
        return "raw_html";
    case INL_EMPH:
        return "emph";
    case INL_STRONG:
        return "strong";
    case INL_LINK:
        return "link";
    case INL_IMAGE:
        return "image";
    }
}

const char *getInlineContent_Literal(node_inl *i) {
    return chunk_to_cstr(&i->content.literal);
}

inline node_inl *getInlineContent_Inlines(node_inl *i) {
    return i->content.inlines;
}

inline node_inl *getInlineContent_Linkable_Label(node_inl *i) {
    return i->content.linkable.label;
}

const char *getInlineContent_Linkable_Url(node_inl *i) {
    return i->content.linkable.url;
}

const char *getInlineContent_Linkable_Title(node_inl *i) {
    return i->content.linkable.title;
}

inline node_inl *getInlineNext(node_inl *i) {
    return i->next;
}

/* Block */

const char *getBlockTag(node_block *cur) {
    switch (cur->tag) {
    case BLOCK_DOCUMENT:
        return "document";
        break;
    case BLOCK_BQUOTE:
        return "bquote";
        break;
    case BLOCK_LIST:
        return "list";
        break;
    case BLOCK_LIST_ITEM:
        return "list_item";
        break;
    case BLOCK_FENCED_CODE:
        return "fenced_code";
        break;
    case BLOCK_INDENTED_CODE:
        return "indented_code";
        break;
    case BLOCK_HTML:
        return "html";
        break;
    case BLOCK_PARAGRAPH:
        return "paragraph";
        break;
    case BLOCK_ATX_HEADER:
        return "atx_header";
        break;
    case BLOCK_SETEXT_HEADER:
        return "setext_header";
        break;
    case BLOCK_HRULE:
        return "hrule";
        break;
    case BLOCK_REFERENCE_DEF:
        return "reference_def";
        break;
    }
}

inline int getBlockStartLine(node_block *cur) {
    return cur->start_line;
}

inline int getBlockStartColumn(node_block *cur) {
    return cur->start_column;
}

inline int getBlockEndLine(node_block *cur) {
    return cur->end_line;
}

inline bool getBlockOpen(node_block *cur) {
    return cur->open;
}

inline bool getBlockLastLineBlank(node_block *cur) {
    return cur->last_line_blank;
}

inline struct node_Block *getBlockChildren(node_block *cur) {
    return cur->children;
}

const char *getBlockStringContent(node_block *cur) {
    return strbuf_detach(&cur->string_content);
}

inline node_inl *getBlockInlineContent(node_block *cur) {
    return cur->inline_content;
}

const char *getBlockAttributes_ListData_ListType(node_block *cur) {
    switch (cur->as.list.list_type) {
    case bullet:
        return "bullet";
        break;
    case ordered:
        return "ordered";
        break;
    }
}

inline int getBlockAttributes_ListData_MarkerOffset(node_block *cur) {
    return cur->as.list.marker_offset;
}

inline int getBlockAttributes_ListData_Padding(node_block *cur) {
    return cur->as.list.padding;
}

inline int getBlockAttributes_ListData_Start(node_block *cur) {
    return cur->as.list.start;
}

const char *getBlockAttributes_ListData_Delimiter(node_block *cur) {
    switch (cur->as.list.delimiter) {
    case period:
        return "period";
        break;
    case parens:
        return "parens";
        break;
    }
}

inline char getBlockAttributes_ListData_BulletChar(node_block *cur) {
    return cur->as.list.bullet_char;
}

inline bool getBlockAttributes_ListData_Tight(node_block *cur) {
    return cur->as.list.tight;
}

inline int getBlockAttributes_FencedCodeData_FenceLength(node_block *cur) {
    return cur->as.code.fence_length;
}

inline int getBlockAttributes_FencedCodeData_FenceOffset(node_block *cur) {
    return cur->as.code.fence_offset;
}

inline char getBlockAttributes_FencedCodeData_FenceChar(node_block *cur) {
    return cur->as.code.fence_char;
}

const char *getBlockAttributes_FencedCodeData_Info(node_block *cur) {
    return strbuf_detach(&cur->as.code.info);
}

inline int getBlockAttributes_HeaderLevel(node_block *cur) {
    return cur->as.header.level;
}

inline struct node_Block *getBlockNext(node_block *cur) {
    return cur->next;
}
