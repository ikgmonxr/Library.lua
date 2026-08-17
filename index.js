const { Client, GatewayIntentBits, REST, Routes, SlashCommandBuilder, EmbedBuilder } = require('discord.js');

const DISCORD_TOKEN = "MTUzOTA0NzM2NDE2NDA2MzI1Mg.GT-xA_.bKMbwoUUSJjYtR1inmKlxEs8LZ6CkT0lFblxdg";
const CLIENT_ID = "1539047364164063252";
const GITHUB_TOKEN = "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";
const REPO_OWNER = "ikgmonxr";
const REPO_NAME = "Library.lua";
const FILE_PATH = "status.json";

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

const commands = [
    new SlashCommandBuilder()
        .setName('estado')
        .setDescription('Cambia el estado de la web ikgmonxr.github.io/Library.lua')
        .addStringOption(option =>
            option.setName('modo')
                .setDescription('Selecciona el nuevo estado')
                .setRequired(true)
                .addChoices(
                    { name: '🟢 Online', value: 'Online' },
                    { name: '🔴 Offline', value: 'Offline' },
                    { name: '🟠 Mantenimiento', value: 'Maintenance' }
                ))
];

const rest = new REST({ version: '10' }).setToken(DISCORD_TOKEN);

client.once('ready', async () => {
    console.log(`Bot activo como ${client.user.tag}`);
    try {
        await rest.put(Routes.applicationCommands(CLIENT_ID), { body: commands });
        console.log('Comando /estado registrado correctamente.');
    } catch (error) {
        console.error("Error al registrar comando:", error);
    }
});

client.on('interactionCreate', async interaction => {
    if (!interaction.isChatInputCommand()) return;

    if (interaction.commandName === 'estado') {
        await interaction.deferReply();
        const nuevoEstado = interaction.options.getString('modo');

        try {
            // 1. Obtener status.json de GitHub
            const getRes = await fetch(`https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}`, {
                headers: {
                    'Authorization': `Bearer ${GITHUB_TOKEN}`,
                    'Accept': 'application/vnd.github.v3+json',
                    'User-Agent': 'IkgonaviBot'
                }
            });

            if (!getRes.ok) throw new Error(`Error al leer GitHub (${getRes.status})`);
            const fileData = await getRes.json();
            
            const content = JSON.parse(Buffer.from(fileData.content, 'base64').toString('utf-8'));
            content.status_general = nuevoEstado;

            // 2. Modificar status.json en GitHub
            const putRes = await fetch(`https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${GITHUB_TOKEN}`,
                    'Accept': 'application/vnd.github.v3+json',
                    'Content-Type': 'application/json',
                    'User-Agent': 'IkgonaviBot'
                },
                body: JSON.stringify({
                    message: `Estado cambiado a ${nuevoEstado} desde Discord`,
                    content: Buffer.from(JSON.stringify(content, null, 2)).toString('base64'),
                    sha: fileData.sha
                })
            });

            if (!putRes.ok) throw new Error(`Error al guardar en GitHub (${putRes.status})`);

            const embed = new EmbedBuilder()
                .setTitle('✅ Estado Actualizado')
                .setDescription(`El estado en tu web ha cambiado a: **${nuevoEstado}**`)
                .setColor(nuevoEstado === 'Online' ? 0x10B981 : (nuevoEstado === 'Offline' ? 0xEF4444 : 0xF59E0B))
                .setTimestamp();

            await interaction.editReply({ embeds: [embed] });

        } catch (err) {
            await interaction.editReply(`❌ Error al actualizar GitHub: \`${err.message}\``);
        }
    }
});

client.login(DISCORD_TOKEN);
