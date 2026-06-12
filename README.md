# NPCBot GM Panel (Enhanced Edition)

¡Bienvenido a la versión mejorada, optimizada y extendida de **NPCBot GM Panel**! Este addon para World of Warcraft proporciona una interfaz gráfica (UI) limpia y moderna para gestionar y equipar tus NPCBots de forma masiva en el servidor, ideal tanto para administradores (GMs) como para entornos de desarrollo y pruebas.

Esta edición soluciona problemas históricos de superposición visual, reestructura los paneles para dar una mayor comodidad e integra un completo sistema de equipamiento automatizado conectado directamente con las funciones del servidor.

---

## 🚀 Características y Funcionalidades Completas

### 👁️ 1. Gestión Principal de Bots (Panel Izquierdo)
* **Búsqueda por Clases:** Incluye un catálogo visual de 10 iconos interactivos que representan las clases del juego (Guerrero, Paladín, Cazador, Pícaro, Sacerdote, Caballero de la Muerte, Chamán, Mago, Brujo y Druida). Al hacer clic en cualquiera de ellos, se ejecuta automáticamente el comando de búsqueda masiva `.npcbot lookup [class_id]`.
* **Invocación por ID (Spawn):** Una caja de texto (`EditBox`) numérica integrada con un límite seguro de 7 dígitos que te permite escribir la ID exacta de un bot de la base de datos y traerlo al mundo al instante mediante el botón **Spawn**.
* **Eliminación Rápida:** Botón dedicado para limpiar o despedir al bot seleccionado mediante comandos automatizados.

### 📐 2. Rediseño Estructural y Control de Espacio
* **Cero Colisiones:** Se eliminaron las superposiciones de la interfaz base. El botón de acceso al equipo y el selector de idioma se reubicaron en zonas limpias, cómodas y simétricas.
* **Gran Panel de Equipamiento Avanzado (360x460):** Ampliación masiva de la altura y anchura del panel de equipo secundario. Los botones ahora tienen un tamaño generoso (`130x24`), están ordenados por categorías lógicas y sus textos jamás se solapan entre sí.
* **Cierre Inteligente en Cascada:** Al cerrar el panel principal interactuando con la cruz (`X`), el panel de equipamiento se ocultará de forma automática si se encontraba abierto en ese momento.

### 🛡️ 3. Sistema Inyectado de Equipamiento Automatizado
Conectado directamente a las tablas de objetos del servidor, el panel calcula el nivel de tu personaje (escalando de 10 en 10) para entregarte un lote completo de equipamiento adecuado a tu rango, dividiéndose en tres grandes bloques visuales:
* **Sets Raros (Nivel Bajo / Leveo):** Botones rápidos para invocar armaduras de calidad rara adaptadas a los roles de **Hechicero (Caster)**, **Tanque (Tank)**, **Placas DPS (Plate)**, **Cuero DPS (Leather)** y **Malla DPS (Mail)**.
* **Sets Épicos (Nivel 80):** Variantes de máxima calidad ideales para bots en nivel máximo, cubriendo los mismos 5 roles de armaduras.
* **Armas e Insumos:** Acceso inmediato a lotes de **Armas de 1 Mano (1M)**, **Armas de 2 Manos (2M)**, **Armas a Distancia (Ranged)** e insumos de proyectiles que añaden automáticamente **2000 unidades de Flechas o Balas** según la elección.

### ❓ 4. Botón de Ayuda Dinámica `[?]`
* Se incorporó un botón interactivo `[?]` en la esquina superior izquierda del panel de equipamiento.
* Al pasar el cursor por encima, despliega un Tooltip del juego con formato limpio, protección de salto de línea y la explicación exacta de la regla de uso del sistema.

---

## 🌍 Soporte Bilingüe Nativo

El addon cuenta con un sistema de traducción localizado que se actualiza en tiempo real con un solo clic a través del botón conmutador (sin necesidad de utilizar comandos de recarga de interfaz como `/reload`):
* **Español (ES)**
* **Inglés (EN)**

---

## ⌨️ Comandos Disponibles

* `/npcbotgp` : Comando de consola para mostrar u ocultar la interfaz completa de forma manual.
* **Botón del Minimapa:** El addon registra un cómodo y estético icono circular en el mapa de juego. Cuenta con tooltip informativo y es **completamente arrastrable** con el clic izquierdo del ratón para que lo posiciones donde prefieras.

---

## 📌 Requisitos y Regla de Uso

Para que el panel de equipamiento otorgue y asigne los objetos de manera correcta, recuerda la regla de uso estricta:
> 💡 *Para equipar un bot, tendrás que tener seleccionado al bot en tu objetivo (target) y posteriormente elegir el equipamiento en el panel para recibir dichos ítems en tu inventario y ser aplicados.*

*Nota: Las funciones de generación de objetos requieren de manera predeterminada que el usuario posea rango de Administrador (GM) activo en el servidor (`requireGMForItemCommands = true`).*

---

## 🤝 Créditos y Agradecimientos

Este proyecto combina la comodidad de una interfaz gráfica avanzada con la robustez lógica en el núcleo del servidor.

Un agradecimiento muy especial a **Dinkledork** por el desarrollo de su excelente script del lado del servidor (`BotCommands.lua`). Su arquitectura de código, comandos personalizados (`.bot items`), filtrado de roles, lógica de asignación de munición por volumen (2000 unidades)  actúan como el motor principal que procesa todas las solicitudes de esta interfaz gráfica.

<img width="1366" height="705" alt="Wow 2026-06-12 19-15-10" src="https://github.com/user-attachments/assets/ceddc145-ec7e-422a-878d-29e08e8b00d5" />
