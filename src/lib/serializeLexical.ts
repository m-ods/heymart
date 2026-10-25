// Simple Lexical to HTML serializer
// For more complex needs, use Payload's built-in serializer

export function serializeLexical(content: any): string {
  if (!content || !content.root) {
    return ''
  }

  return serializeChildren(content.root.children)
}

function serializeChildren(children: any[]): string {
  if (!Array.isArray(children)) {
    return ''
  }

  return children.map(serializeNode).join('')
}

function serializeNode(node: any): string {
  if (!node) return ''

  switch (node.type) {
    case 'paragraph':
      return `<p>${serializeChildren(node.children)}</p>`
    
    case 'heading':
      const tag = `h${node.tag || '2'}`
      return `<${tag}>${serializeChildren(node.children)}</${tag}>`
    
    case 'list':
      const listTag = node.listType === 'bullet' ? 'ul' : 'ol'
      return `<${listTag}>${serializeChildren(node.children)}</${listTag}>`
    
    case 'listitem':
      return `<li>${serializeChildren(node.children)}</li>`
    
    case 'link':
      const href = node.fields?.url || node.url || '#'
      return `<a href="${href}">${serializeChildren(node.children)}</a>`
    
    case 'text':
      let text = node.text || ''
      if (node.format) {
        if (node.format & 1) text = `<strong>${text}</strong>` // bold
        if (node.format & 2) text = `<em>${text}</em>` // italic
        if (node.format & 4) text = `<s>${text}</s>` // strikethrough
        if (node.format & 8) text = `<u>${text}</u>` // underline
        if (node.format & 16) text = `<code>${text}</code>` // code
      }
      return text
    
    case 'linebreak':
      return '<br>'
    
    default:
      if (node.children) {
        return serializeChildren(node.children)
      }
      return ''
  }
}
