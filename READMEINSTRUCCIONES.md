# 🐉 Dragon Ball Z - Sistema de Tarjetas

## Instrucciones de Uso

### 1. Pantalla de Login (`index.html`)

- **Campos a completar:**
  - *Nombre del Guerrero:* Escribí tu usuario (ejemplo: goku, vegeta, gohan).
  - *Código de Poder:* Ingresá tu contraseña secreta.
  
- **Botón "🚀 ¡Acceder a mis Tarjetas!":**
  - Al hacer clic, se validan tus datos.
  - Si son correctos, te redirige automáticamente a la página de tarjetas (`tarjetas.html`) mostrando solo tus cartas.
  - Si las credenciales son incorrectas, muestra un mensaje de error.

- **Enlaces:**
  - *👁️ Ver todas las tarjetas sin login:* Te lleva a la página `tarjetas.html` mostrando todas las cartas disponibles, sin filtrar por usuario.
  - *¿Olvidaste tu poder de combate?:* (Funcionalidad pendiente o para futuro).

---

### 2. Página de Tarjetas (`tarjetas.html`)

- Muestra las tarjetas cargadas dinámicamente según tu sesión:

  - Si estás logueado, se muestran solo tus tarjetas personales.
  - Si no estás logueado, se muestran todas las tarjetas del sistema.

- **Botón "Cerrar sesión":**
  - Termina tu sesión activa.
  - Te muestra automaticamente todas las tarjetas de todos los usuarios.
