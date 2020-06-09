import hljs from 'highlight.js'

document.addEventListener('DOMContentLoaded', (_event) => {
  document.querySelectorAll('pre code').forEach((block) => {
    hljs.highlightBlock(block);
  });
});
