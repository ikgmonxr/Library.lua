const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const ADMIN_KEY = process.env.ADMIN_KEY || "mi_clave_secreta_123";
const DISCORD_WEBHOOK_URL = process.env.DISCORD_WEBHOOK_URL || "https://discord.com/api/webhooks/1539040228873076837/4vpo5dQgn3F1XXpallGCECAEomiaTEIWVSGd7-czYVgcCPPwr7fS-hdp-hKaZvSajuyG";

let statusData = {
    status_general: "Online",
    hub_script: "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ikgmonxr/Ikgonavi/refs/heads/main/Hub\"))()",
    mvs_script: "loadstring(game:HttpGet(\"https://https-api-ikg-com-api-v1-luascripts.onrender.com/api/script/34e93f16f26764708ccb5c63e2372341\"))()",
    mm2_script: "loadstring(game:HttpGet(\"https://https-api-ikg-com-api-v1-luascripts.onrender.com/api/script/7752d53d155a5d26715209fab1438cd9\"))()"
};

// Endpoint público para el HTML
app.get('/api/status', (req, res) => {
    res.json(statusData);
});

// Panel para editar desde el navegador
app.get('/admin', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html lang="es">
        <head>
            <meta charset="UTF-8">
            <title>Panel de Administración — Ikgonavi</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>
        <body class="bg-slate-950 text-slate-100 p-8 flex justify-center">
            <div class="max-w-md w-full bg-slate-900 p-6 rounded-xl border border-slate-800 space-y-4">
                <h1 class="text-xl font-bold text-indigo-400">Panel de Control Web</h1>
                <form action="/api/update-status" method="POST" class="space-y-3">
                    <div>
                        <label class="block text-xs font-mono mb-1">Clave de Administrador:</label>
                        <input type="password" name="authKey" required class="w-full bg-slate-950 border border-slate-800 rounded p-2 text-sm text-white">
                    </div>
                    <div>
                        <label class="block text-xs font-mono mb-1">Estado General:</label>
                        <input type="text" name="status_general" value="${statusData.status_general}" class="w-full bg-slate-950 border border-slate-800 rounded p-2 text-sm text-white">
                    </div>
                    <div>
                        <label class="block text-xs font-mono mb-1">MVS Script (Loadstring):</label>
                        <textarea name="mvs_script" rows="2" class="w-full bg-slate-950 border border-slate-800 rounded p-2 text-xs font-mono text-indigo-300">${statusData.mvs_script}</textarea>
                    </div>
                    <div>
                        <label class="block text-xs font-mono mb-1">MM2 Script (Loadstring):</label>
                        <textarea name="mm2_script" rows="2" class="w-full bg-slate-950 border border-slate-800 rounded p-2 text-xs font-mono text-indigo-300">${statusData.mm2_script}</textarea>
                    </div>
                    <button type="submit" class="w-full bg-indigo-600 hover:bg-indigo-500 font-bold py-2 rounded text-sm transition">
                        Guardar y Notificar en Discord
                    </button>
                </form>
            </div>
        </body>
        </html>
    `);
});

// Endpoint POST que procesa los cambios
app.post('/api/update-status', async (req, res) => {
    const { authKey, mvs_script, mm2_script, hub_script, status_general } = req.body;

    if (authKey !== ADMIN_KEY) {
        return res.status(403).send("❌ Clave incorrecta. Acceso denegado.");
    }

    if (mvs_script) statusData.mvs_script = mvs_script;
    if (mm2_script) statusData.mm2_script = mm2_script;
    if (hub_script) statusData.hub_script = hub_script;
    if (status_general) statusData.status_general = status_general;

    // Enviar webhook a Discord
    try {
        await fetch(DISCORD_WEBHOOK_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                username: "Ikgonavi Status Manager",
                embeds: [{
                    title: "🟢 Estado & Scripts Actualizados",
                    description: "Se han modificado los datos del Hub desde el panel de control.",
                    color: 5763719,
                    fields: [
                        { name: "Estado General", value: statusData.status_general, inline: true },
                        { name: "MVS Script", value: `\`\`\`lua\n${statusData.mvs_script}\n\`\`\`` },
                        { name: "MM2 Script", value: `\`\`\`lua\n${statusData.mm2_script}\n\`\`\`` }
                    ],
                    timestamp: new Date().toISOString()
                }]
            })
        });
    } catch (err) {
        console.error("Error al enviar el webhook:", err);
    }

    res.send(`
        <body style="background:#020617;color:#fff;font-family:sans-serif;padding:40px;text-align:center;">
            <h2 style="color:#10b981;">¡Guardado Correctamente!</h2>
            <p>La página web y el webhook de Discord han sido actualizados.</p>
            <a href="/admin" style="color:#818cf8;">Volver al panel</a>
        </body>
    `);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor activo en el puerto ${PORT}`));
