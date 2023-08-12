import { JSONEditor } from 'vanilla-jsoneditor'

document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".code-editor").forEach(field => {
        let node = document.createElement("div")
        field.after(node)
        field.classList.add("hidden")
        let content = {
            text: field.value
        }
        const editor = new JSONEditor({
            target: node,
            props: {
                mode: "text",
                mainMenuBar: false,
                statusBar: false,
                content,
                onChange: (updatedContent, previousContent, { contentErrors, patchResult }) => {
                    content = updatedContent
                    field.value = updatedContent.text || JSON.stringify(updatedContent.json)
                }
            }
        })
    })
})