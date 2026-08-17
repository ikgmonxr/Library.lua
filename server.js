const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

const ADMIN_KEY = process.env.ADMIN_KEY || "mi_clave_secreta_123";
const DISCORD_WEBHOOK_URL = process.env.DISCORD_WEBHOOK_URL || "https://discord.com/api/webhooks/1539040228873076837/4vpo5dQgn3F1XXpallGCECAEomiaTEIWVSGd7-czYVgcCPPwr7fS-hdp-hKaZvSajuyG";

// Estado en memoria
let statusData = {
    status_general: "Online",
    hub_script: "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ikgmonxr/Ikgonavi/refs/heads/main/Hub\"))()",
    mvs_script: "loadstring(game:HttpGet(\"https://https-api-ikg-com-api-v1-luascripts.onrender.com/api/script/34e93f16f26764708ccb5c63e2372341\"))()",
    mm2_script: "loadstring(game:HttpGet(\"https://https-api-ikg-com-api-v1-luascripts.onrender.com/api/script/7752d53d155a5d26715209fab1438cd9\"))()"
};

// Endpoint público que consulta tu página web
app.get('/api/status', (req, res) => {
    res.json(statusData);
});

// Endpoint protegido para modificar datos y notificar a Discord
app.post('/api/update-status', async (req, res) => {
    const { authKey, mvs_script, mm2_script, hub_script, status_general } = req.body;

    if (authKey !== ADMIN_KEY) {
        return res.status(403).json({ success: false, message: "Clave no autorizada" });
    }

    if (mvs_script) statusData.mvs_script = mvs_script;
    if (mm2_script) statusData.mm2_script = mm2_script;
    if (hub_script) statusData.hub_script = hub_script;
    if (status_general) statusData.status_general = status_general;

    // Notificación en Discord mediante el Webhook
    try {
        await fetch(DISCORD_WEBHOOK_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                username: "Ikgonavi Status Manager",
                embeds: [{
                    title: "🟢 Estado & Scripts Actualizados",
                    description: "Se han modificado los loadstrings en la página web en tiempo real.",
                    color: 5763719,
                    fields: [
                        { name: "Estado General", value: statusData.status_general, inline: true },
                        { name: "MVS Script", value: `\`\`\`lua\n${statusData.mvs_script}\n\`\`\`` },
                        { name: "MM2 Script", value: `\`\`\`lua\n${statusData.mm2_script}\n\`\`\`` }
                    ],
                    footer: { text: "IKGONAVI HUB — System Logs" },
                    timestamp: new Date().toISOString()
                }]
            })
        });
    } catch (err) {
        console.error("Error al enviar el webhook a Discord:", err);
    }

    res.json({ success: true, message: "Estado actualizado y notificado a Discord", data: statusData });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor activo en el puerto ${PORT}`));
