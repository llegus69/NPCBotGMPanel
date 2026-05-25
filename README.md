# NPCBotGMPanel

Un addon ligero, estético y multilenguaje para **World of Warcraft 3.3.5a (Wrath of the Lich King)** diseñado para Maestros de Juego (GMs). Facilita la gestión de **NPCBots** en emuladores como TrinityCore o AzerothCore a través de una interfaz visual intuitiva.

## 🚀 Características

- **Soporte Multilenguaje Dinámico (ES / EN):** Incluye un botón selector en la esquina superior izquierda que cambia instantáneamente todos los textos y tooltips del panel entre Español e Inglés en tiempo real.
- **Interfaz Visual Confortable:** Panel central con iconos nativos 100% compatibles con la versión 3.3.5a para identificar rápidamente las 10 clases del juego.
- **Búsqueda Automatizada:** Al hacer clic en el icono de cualquier clase, se ejecuta automáticamente el comando `.npcbot lookup [ID_Clase]`.
- **Invocación Inteligente (Spawn):** Caja de texto numérica integrada para introducir la ID del bot. Al pulsar "Spawn Bot", se envía el comando `.npcb spawn [ID]` y **se limpia automáticamente el cuadro de texto**, quitando el foco del cursor para mayor comodidad.
- **Eliminación Rápida:** Botón dedicado para borrar el bot seleccionado mediante `.npcb delete`.
- **Botón del Minimapa Arrastrable:** Icono circular estético (con forma de engranaje) que se puede arrastrar libremente con el clic izquierdo por todo el borde del minimapa para mostrar u ocultar el panel principal.
- **Ventana Movible:** El panel principal se puede desplazar por la pantalla haciendo clic izquierdo y arrastrando el fondo de la interfaz.
- **Comando de Consola:** Alternativa rápida escribiendo `/npcbotgp` en el chat.

## 🛠️ Instalación

1. Descarga el repositorio o crea una carpeta llamada `NPCBotGMPanel`.
2. Asegúrate de que la estructura dentro del directorio de WoW sea exactamente la siguiente:
   ```text
   World of Warcraft/Interface/AddOns/NPCBotGMPanel/
   ├── NPCBotGMPanel.toc
   └── NPCBotGMPanel.lua

   Si tenías el juego abierto, ciérralo por completo y vuelve a iniciarlo para que el cliente detecte el addon.

En la pantalla de selección de personaje, comprueba que NPCBotGMPanel está activo en el menú de "Accesorios" (AddOns).

🎮 Guía de Uso
Abrir el panel: Haz clic en el botón del minimapa o escribe /npcbotgp en el chat.

Cambiar de idioma: Haz clic en el botón pequeño de la esquina superior izquierda (ES / EN) para alternar el idioma de la interfaz según tu preferencia.

Buscar Bots: Haz clic en el icono de la clase que desees buscar. El addon enviará la petición y verás la lista de IDs disponibles en la ventana de chat.

Invocar un Bot: Escribe la ID numérica del bot en el cuadro "ID del Bot" y presiona "Spawn Bot". El bot aparecerá frente a ti y el cuadro se vaciará solo, quedando listo para el siguiente.

Borrar un Bot: Selecciona al bot o colócate cerca de él y presiona "Borrar Bot".

📝 Comandos Nativos Soportados
El addon automatiza las siguientes funciones del emulador:

.npcbot lookup #class

.npcb spawn #botID

.npcb delete

<img width="1366" height="705" alt="Wow 2026-05-25 17-46-13" src="https://github.com/user-attachments/assets/9e451d7f-685b-4c9c-8443-796e7ca3c21e" />

# NPCBotGMPanel

A lightweight, aesthetic, and multilingual addon for **World of Warcraft 3.3.5a (Wrath of the Lich King)** designed for Game Masters (GMs). It simplifies the management of **NPCBots** on emulators like TrinityCore or AzerothCore through an intuitive visual interface.

## 🚀 Features

- **Dynamic Multilingual Support (EN / ES):** Includes a small selector button in the top-left corner that instantly toggles all texts and tooltips between English and Spanish in real-time.
- **Clean Visual Interface:** Central panel featuring native icons 100% compatible with version 3.3.5a to quickly identify the 10 in-game classes.
- **Automated Lookup:** Clicking on any class icon automatically executes the `.npcbot lookup [Class_ID]` command.
- **Smart Summoning (Spawn):** Integrated numeric edit box to enter the bot's ID. Pressing "Spawn Bot" sends the `.npcb spawn [ID]` command, **automatically clears the text box**, and removes the cursor focus for maximum convenience.
- **Quick Deletion:** Dedicated button to delete the selected bot using `.npcb delete`.
- **Draggable Minimap Button:** An aesthetic, gear-shaped circular icon that can be freely dragged with a left-click around the minimap border to show or hide the main panel.
- **Movable Window:** The main panel can be moved around the screen by left-clicking and dragging the interface background.
- **Console Command:** A quick chat alternative by typing `/npcbotgp`.

## 🛠️ Installation

1. Download the repository or create a folder named `NPCBotGMPanel`.
2. Ensure the directory structure inside your WoW folder looks exactly like this:
   ```text
   World of Warcraft/Interface/AddOns/NPCBotGMPanel/
   ├── NPCBotGMPanel.toc
   └── NPCBotGMPanel.lua
If your game was open, close it completely and restart it so the client can detect the new addon.

On the character selection screen, verify that NPCBotGMPanel is enabled in the AddOns menu.

🎮 How to Use
Open the panel: Click the minimap button or type /npcbotgp in the chat.

Change language: Click the small button in the top-left corner (EN / ES) to toggle the interface language according to your preference.

Lookup Bots: Click on the icon of the class you want to search for. The addon will send the request, and you will see the list of available IDs in your chat frame.

Spawn a Bot: Type the bot's numeric ID into the "Bot ID" text box and press "Spawn Bot". The bot will appear in front of you, and the box will clear itself, ready for the next one.

Delete a Bot: Target the bot or stand near it and press "Delete Bot".

📝 Supported Native Commands
The addon automates the following emulator functions:

.npcbot lookup #class

.npcb spawn #botID

.npcb delete
