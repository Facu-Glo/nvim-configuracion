return {
    'pchampio/comfy-line-numbers.nvim',
    branch = 'gitsigns.nvim',
    config = function()
        require('comfy-line-numbers').setup({
            labels = {
                -- Nivel 1
                '1', '2', '3', '4',
                -- Nivel 2
                '11', '12', '13', '14', '21', '22', '23', '24',
                '31', '32', '33', '34', '41', '42', '43', '44',
                -- Nivel 3
                '111', '112', '113', '114', '121', '122', '123', '124',
                '131', '132', '133', '134', '141', '142', '143', '144',
                '211', '212', '213', '214', '221', '222', '223', '224',
                '231', '232', '233', '234', '241', '242', '243', '244',
                '311', '312', '313', '314', '321', '322', '323', '324',
                '331', '332', '333', '334', '341', '342', '343', '344',
            },
            up_key = 'k',
            down_key = 'j',

            min_numberwidth = 3,
            gitsigns = {
                enabled = true,
            },

            hidden_file_types = { 'undotree' },
            hidden_buffer_types = { 'terminal', 'nofile' }
        })
    end
}
