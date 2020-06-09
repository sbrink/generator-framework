import CodeMirror from 'codemirror';
import 'codemirror/mode/markdown/markdown.js';
import 'codemirror-mode-elixir/dist/codemirror-mode-elixir';

document.addEventListener("DOMContentLoaded", function () {
  const codeMirror = document.querySelectorAll('.code-mirror-elixir');

  for (var i = 0; i < codeMirror.length; i++) {
    let elem = codeMirror[i];

    CodeMirror.fromTextArea(elem, {
      mode: "elixir",
      theme: "default",
      lineNumbers: false,
      lineWrapping: true,
      tabSize: 2,
      viewportMargin: Infinity,
      tabMode: "indent"
    });
  }
});
