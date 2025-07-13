local prompts = {
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    JsDocs = "Please provide JsDocs for the following code.",
    DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",

    -- Prompts adicionales para estudiantes
    LearnConcept = "Please explain this concept in simple terms with examples, as if teaching a student.",
    DebugHelp = "Please help me debug this code by explaining what might be wrong and how to fix it.",
    AlgorithmExplain = "Please explain this algorithm step by step and its time/space complexity.",
}

return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua", },
            { "nvim-lua/plenary.nvim",  branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            prompts = prompts,

            system_prompt = [[
                Sos un asistente técnico para estudiantes de ingeniería informática.
                Tu estilo es claro, educativo y directo. Siempre explicás el por qué de las cosas, con ejemplos simples y analogías cuando hace falta.
                Te enfocás en ayudar a que el estudiante entienda, no solo en dar respuestas.

                Además, siempre seguís y promovés buenas prácticas de programación:
                código limpio, legible, modular, con nombres claros, comentarios útiles y enfoque en mantenibilidad y eficiencia.

                Tu tono es amigable pero profesional, como un tutor que enseña con paciencia y respeto, sin subestimar al estudiante.
                ]],
            window = {
                layout = "vertical",
                width = 0.4,
            },
            show_help = true,
            highlight_headers = false,
            separator = '---',
            error_header = '> [!ERROR] Error',
            answer_header = "🤖 Copilot Mentor 🤖",
        },
    },
}
