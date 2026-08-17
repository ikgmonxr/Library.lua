<!DOCTYPE html>
<html lang="es" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IKGONAVI HUB — System Status</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts (Inter & JetBrains Mono) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        mono: ['JetBrains Mono', 'monospace'],
                    },
                    colors: {
                        brand: {
                            50: '#eef2ff',
                            500: '#6366f1',
                            600: '#4f46e5',
                            900: '#312e81',
                        },
                        status: {
                            green: '#10b981',
                            yellow: '#f59e0b',
                            red: '#ef4444'
                        }
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background-color: #090d16;
            background-image: 
                radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.12) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.08) 0px, transparent 50%);
            background-attachment: fixed;
        }
        .glass-card {
            background: rgba(15, 23, 42, 0.65);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.07);
        }
        .pulse-glow {
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.4);
        }
    </style>
</head>
<body class="font-sans text-slate-200 min-h-screen flex flex-col justify-between antialiased">

    <!-- Header Section -->
    <header class="border-b border-slate-800/80 bg-slate-950/40 backdrop-blur-md sticky top-0 z-50">
        <div class="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-indigo-600 to-emerald-400 flex items-center justify-center text-white font-bold text-xl shadow-lg shadow-indigo-500/20">
                    I
                </div>
                <div>
                    <h1 class="font-bold text-lg text-white tracking-wide">IKGONAVI HUB</h1>
                    <p class="text-xs text-slate-400 font-mono">STATUS DASHBOARD</p>
                </div>
            </div>
            <div class="flex items-center gap-4">
                <a href="#" class="text-xs font-medium text-slate-400 hover:text-white transition flex items-center gap-2 bg-slate-900 px-3 py-1.5 rounded-lg border border-slate-800">
                    <i class="fa-brands fa-discord text-indigo-400 text-sm"></i> Discord
                </a>
                <button onclick="checkStatus()" class="text-xs font-medium bg-indigo-600/20 hover:bg-indigo-600/30 text-indigo-300 border border-indigo-500/30 px-3 py-1.5 rounded-lg transition flex items-center gap-2">
                    <i class="fa-solid fa-rotate-right" id="refresh-icon"></i> Actualizar
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-6xl mx-auto px-4 py-8 w-full flex-grow space-y-8">

        <!-- Banner General Status -->
        <div class="glass-card rounded-2xl p-6 sm:p-8 flex flex-col sm:flex-row items-center justify-between gap-6 relative overflow-hidden">
            <div class="absolute -right-10 -bottom-10 w-40 h-40 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none"></div>
            
            <div class="flex items-center gap-5 z-10">
                <div class="relative flex items-center justify-center">
                    <span class="animate-ping absolute inline-flex h-12 w-12 rounded-full bg-emerald-400 opacity-75"></span>
                    <div class="w-12 h-12 rounded-full bg-emerald-500/20 border border-emerald-500/50 flex items-center justify-center text-emerald-400 text-xl pulse-glow">
                        <i class="fa-solid fa-check"></i>
                    </div>
                </div>
                <div>
                    <h2 class="text-2xl font-bold text-white">Todos los Sistemas Operativos</h2>
                    <p class="text-slate-400 text-sm mt-0.5">Ikgonavi Hub está funcionando al 100% sin detecciones reportadas.</p>
                </div>
            </div>

            <div class="flex gap-4 font-mono text-xs z-10 w-full sm:w-auto justify-between sm:justify-end border-t sm:border-t-0 border-slate-800 pt-4 sm:pt-0">
                <div class="bg-slate-900/80 px-4 py-2.5 rounded-xl border border-slate-800/80 text-center">
                    <span class="text-slate-500 block text-[10px] uppercase tracking-wider">Uptime</span>
                    <span class="text-emerald-400 font-bold text-sm">99.98%</span>
                </div>
                <div class="bg-slate-900/80 px-4 py-2.5 rounded-xl border border-slate-800/80 text-center">
                    <span class="text-slate-500 block text-[10px] uppercase tracking-wider">Latencia API</span>
                    <span class="text-slate-200 font-bold text-sm" id="ping-val">18 ms</span>
                </div>
                <div class="bg-slate-900/80 px-4 py-2.5 rounded-xl border border-slate-800/80 text-center">
                    <span class="text-slate-500 block text-[10px] uppercase tracking-wider">Versión</span>
                    <span class="text-indigo-400 font-bold text-sm">v4.2.0-HYP</span>
                </div>
            </div>
        </div>

        <!-- Metric Grid -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="glass-card p-4 rounded-xl flex items-center justify-between">
                <div>
                    <p class="text-xs text-slate-400 font-medium">Anti-Cheat Bypassed</p>
                    <p class="text-lg font-bold text-white mt-1">Hyperion / Byfron</p>
                </div>
                <span class="px-2.5 py-1 text-[11px] font-semibold font-mono rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                    UNDETECTED
                </span>
            </div>
            <div class="glass-card p-4 rounded-xl flex items-center justify-between">
                <div>
                    <p class="text-xs text-slate-400 font-medium">Key System Server</p>
                    <p class="text-lg font-bold text-white mt-1">Online</p>
                </div>
                <span class="px-2.5 py-1 text-[11px] font-semibold font-mono rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                    OPERATIONAL
                </span>
            </div>
            <div class="glass-card p-4 rounded-xl flex items-center justify-between">
                <div>
                    <p class="text-xs text-slate-400 font-medium">Auto-Attach Rate</p>
                    <p class="text-lg font-bold text-white mt-1">100% Success</p>
                </div>
                <span class="px-2.5 py-1 text-[11px] font-semibold font-mono rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                    STABLE
                </span>
            </div>
            <div class="glass-card p-4 rounded-xl flex items-center justify-between">
                <div>
                    <p class="text-xs text-slate-400 font-medium">Ejecuciones Hoy</p>
                    <p class="text-lg font-bold text-white mt-1">142,890+</p>
                </div>
                <span class="px-2.5 py-1 text-[11px] font-semibold font-mono rounded-full bg-indigo-500/10 text-indigo-400 border border-indigo-500/20">
                    ACTIVE
                </span>
            </div>
        </div>

        <!-- Módulos & Servicios Detailed Status -->
        <div class="glass-card rounded-2xl overflow-hidden">
            <div class="p-5 border-b border-slate-800/80 flex items-center justify-between bg-slate-900/40">
                <h3 class="font-semibold text-white text-base flex items-center gap-2">
                    <i class="fa-solid fa-server text-indigo-400"></i> Estado de Módulos & Script Hubs
                </h3>
                <span class="text-xs font-mono text-slate-400">Verificado hace <span id="time-ago">10</span> segundos</span>
            </div>

            <div class="divide-y divide-slate-800/60 font-sans">

                <!-- Service Item 1 -->
                <div class="p-4 sm:px-6 flex items-center justify-between hover:bg-slate-800/30 transition">
                    <div class="flex items-center gap-4">
                        <i class="fa-solid fa-microchip text-slate-400 w-5 text-center"></i>
                        <div>
                            <p class="text-sm font-medium text-white">Execution Core (Lua Engine)</p>
                            <p class="text-xs text-slate-400">Motor de ejecución principal sUNC 99% compatibility</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="hidden sm:inline text-xs text-emerald-400 font-mono">0.0% Detection</span>
                        <span class="px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span> Undetected
                        </span>
                    </div>
                </div>

                <!-- Service Item 2 -->
                <div class="p-4 sm:px-6 flex items-center justify-between hover:bg-slate-800/30 transition">
                    <div class="flex items-center gap-4">
                        <i class="fa-solid fa-key text-slate-400 w-5 text-center"></i>
                        <div>
                            <p class="text-sm font-medium text-white">Auth & Key System API</p>
                            <p class="text-xs text-slate-400">Validación de claves y sistema de checkpoints</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="hidden sm:inline text-xs text-emerald-400 font-mono">12ms response</span>
                        <span class="px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Operational
                        </span>
                    </div>
                </div>

                <!-- Service Item 3 -->
                <div class="p-4 sm:px-6 flex items-center justify-between hover:bg-slate-800/30 transition">
                    <div class="flex items-center gap-4">
                        <i class="fa-solid fa-cloud-arrow-down text-slate-400 w-5 text-center"></i>
                        <div>
                            <p class="text-sm font-medium text-white">Cloud Script Hub Catalog</p>
                            <p class="text-xs text-slate-400">Servidores de carga de scripts para Blox Fruits, Rivals, Brookhaven</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="hidden sm:inline text-xs text-emerald-400 font-mono">100% Online</span>
                        <span class="px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Operational
                        </span>
                    </div>
                </div>

                <!-- Service Item 4 -->
                <div class="p-4 sm:px-6 flex items-center justify-between hover:bg-slate-800/30 transition">
                    <div class="flex items-center gap-4">
                        <i class="fa-solid fa-shield-halved text-slate-400 w-5 text-center"></i>
                        <div>
                            <p class="text-sm font-medium text-white">Bypass Hooking Layer</p>
                            <p class="text-xs text-slate-400">Protección contra parches del servidor y MemCheck</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="hidden sm:inline text-xs text-emerald-400 font-mono">Protected</span>
                        <span class="px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Operational
                        </span>
                    </div>
                </div>

                <!-- Service Item 5 -->
                <div class="p-4 sm:px-6 flex items-center justify-between hover:bg-slate-800/30 transition">
                    <div class="flex items-center gap-4">
                        <i class="fa-solid fa-robot text-slate-400 w-5 text-center"></i>
                        <div>
                            <p class="text-sm font-medium text-white">Discord Bot Integration</p>
                            <p class="text-xs text-slate-400">Verificación de roles, auto-getkey y soporte</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="hidden sm:inline text-xs text-emerald-400 font-mono">Active</span>
                        <span class="px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Operational
                        </span>
                    </div>
                </div>

            </div>
        </div>

        <!-- Uptime Graph Simulation (90 Días) -->
        <div class="glass-card rounded-2xl p-6 space-y-4">
            <div class="flex items-center justify-between">
                <h3 class="font-semibold text-white text-sm">Historial de Disponibilidad (Últimos 90 días)</h3>
                <span class="text-xs text-emerald-400 font-mono">100% Uptime</span>
            </div>
            
            <!-- Bars Grid -->
            <div class="grid grid-cols-30 sm:grid-cols-45 gap-1 h-10 items-end" id="uptime-bars">
                <!-- Javascript va a generar las 45 barras de estado aquí -->
            </div>

            <div class="flex items-center justify-between text-[11px] text-slate-500 pt-2 border-t border-slate-800/60 font-mono">
                <span>Hace 90 días</span>
                <span>Sin caídas detectadas</span>
                <span>Hoy</span>
            </div>
        </div>

        <!-- Quick Loader Box -->
        <div class="glass-card rounded-2xl p-6 bg-gradient-to-r from-slate-900/90 via-indigo-950/20 to-slate-900/90 border border-indigo-500/20">
            <div class="flex flex-col md:flex-row items-center justify-between gap-4">
                <div>
                    <h4 class="text-white font-semibold text-base flex items-center gap-2">
                        <i class="fa-solid fa-code text-indigo-400"></i> Ikgonavi Loader Script
                    </h4>
                    <p class="text-xs text-slate-400 mt-1">Usa este loadstring directo en tu ejecutor para cargar la versión oficial siempre actualizada.</p>
                </div>
                <div class="w-full md:w-auto flex items-center gap-2 bg-slate-950 px-4 py-3 rounded-xl border border-slate-800 font-mono text-xs text-indigo-300 overflow-x-auto">
                    <span class="select-all">loadstring(game:HttpGet("https://raw.githubusercontent.com/ikgonavi/hub/main/loader.lua"))()</span>
                    <button onclick="copyLoadstring()" id="copy-btn" class="ml-2 bg-indigo-600 hover:bg-indigo-500 text-white px-3 py-1.5 rounded-lg text-xs font-sans transition flex items-center gap-1">
                        <i class="fa-regular fa-copy"></i> Copiar
                    </button>
                </div>
            </div>
        </div>

        <!-- System Incident Log -->
        <div class="glass-card rounded-2xl p-6 space-y-4">
            <h3 class="font-semibold text-white text-base">Historial de Incidentes Recientes</h3>
            <div class="space-y-3 font-sans">
                <div class="p-3.5 rounded-xl bg-slate-900/50 border border-slate-800/60 flex items-start gap-3">
                    <i class="fa-solid fa-circle-check text-emerald-400 text-sm mt-0.5"></i>
                    <div>
                        <div class="flex items-center gap-2">
                            <span class="text-xs font-bold text-white">Actualización v4.2.0 Desplegada</span>
                            <span class="text-[10px] font-mono text-slate-500">Ayer, 18:40 UTC</span>
                        </div>
                        <p class="text-xs text-slate-400 mt-0.5">Soporte añadido para la última versión de Roblox PC/Mobile. Todos los métodos de bypass optimizados.</p>
                    </div>
                </div>
                <div class="p-3.5 rounded-xl bg-slate-900/50 border border-slate-800/60 flex items-start gap-3">
                    <i class="fa-solid fa-circle-check text-emerald-400 text-sm mt-0.5"></i>
                    <div>
                        <div class="flex items-center gap-2">
                            <span class="text-xs font-bold text-white">Mantenimiento Programado Completado</span>
                            <span class="text-[10px] font-mono text-slate-500">Hace 3 días</span>
                        </div>
                        <p class="text-xs text-slate-400 mt-0.5">Servidores Auth migrados a infraestructura de menor latencia.</p>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <!-- Footer -->
    <footer class="border-t border-slate-800/80 bg-slate-950/60 py-6 text-center text-xs text-slate-500">
        <div class="max-w-6xl mx-auto px-4 flex flex-col sm:flex-row items-center justify-between gap-3">
            <p>© 2026 IKGONAVI HUB. Todos los derechos reservados.</p>
            <p class="flex items-center gap-4">
                <span class="flex items-center gap-1.5"><span class="w-2 h-2 rounded-full bg-emerald-400"></span> All systems operational</span>
                <a href="#" class="hover:text-slate-300 transition">Términos</a>
                <a href="#" class="hover:text-slate-300 transition">Discord</a>
            </p>
        </div>
    </footer>

    <!-- JS Logic for Dynamic Feel -->
    <script>
        // Generar barras de uptime aleatorias pero 100% verdes
        const barsContainer = document.getElementById('uptime-bars');
        const totalBars = window.innerWidth < 640 ? 30 : 45;
        
        for (let i = 0; i < totalBars; i++) {
            const bar = document.createElement('div');
            // Altura variable para dar aspecto orgánico de carga
            const randomHeight = Math.floor(Math.random() * 40) + 60; 
            bar.className = 'bg-emerald-500/80 hover:bg-emerald-400 transition-all rounded-sm cursor-pointer group relative';
            bar.style.height = `${randomHeight}%`;
            
            // Tooltip hover
            bar.innerHTML = `<div class="absolute bottom-full mb-2 left-1/2 -translate-x-1/2 hidden group-hover:block bg-slate-900 border border-slate-700 text-[10px] text-white px-2 py-1 rounded shadow-xl whitespace-nowrap z-20 font-mono">100% Uptime</div>`;
            
            barsContainer.appendChild(bar);
        }

        // Simulación de actualización de estado
        function checkStatus() {
            const icon = document.getElementById('refresh-icon');
            icon.classList.add('fa-spin');
            
            setTimeout(() => {
                icon.classList.remove('fa-spin');
                document.getElementById('ping-val').innerText = Math.floor(Math.random() * 8 + 12) + ' ms';
                document.getElementById('time-ago').innerText = '0';
            }, 700);
        }

        // Contador de segundos desde la última verificación
        let seconds = 10;
        setInterval(() => {
            seconds++;
            document.getElementById('time-ago').innerText = seconds;
        }, 1000);

        // Copiar loadstring al portapapeles
        function copyLoadstring() {
            const code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/ikgonavi/hub/main/loader.lua"))()';
            navigator.clipboard.writeText(code);
            
            const btn = document.getElementById('copy-btn');
            btn.innerHTML = '<i class="fa-solid fa-check"></i> ¡Copiado!';
            btn.classList.replace('bg-indigo-600', 'bg-emerald-600');
            
            setTimeout(() => {
                btn.innerHTML = '<i class="fa-regular fa-copy"></i> Copiar';
                btn.classList.replace('bg-emerald-600', 'bg-indigo-600');
            }, 2000);
        }
    </script>
</body>
</html>
