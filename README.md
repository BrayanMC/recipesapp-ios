# RecipesApp

RecipesApp es una aplicación móvil que sigue la arquitectura de microapp, utilizando Swift Package Manager como núcleo y la librería UIKit de Apple. Con Swift Package Manager (SPM), Xcode solo recompila los módulos modificados y sus dependencias directas, mejorando la eficiencia y reduciendo significativamente el tiempo de compilación.

## Table of Contents
- [Funcionalidades](#funcionalidades)
- [Características](#características)
- [Instalación](#instalación)
- [Uso](#uso)
- [Modularización](#modularización)

## Funcionalidades
- Pantalla Lista de Recetas.
- Pantalla Detalle de Receta.
- Pantalla Ubicación de la Receta.

## Características
- Arquitectura de microapp utilizando Swift Package Manager.
- Patrón MVVM.
- Interfaz de usuario con UIKit.
- Pruebas unitarias para las Views y View Models.

## Instalación
Para instalar y configurar el proyecto, sigue estos pasos:

1. Clona el repositorio:
    ```bash
    git clone <URL_DEL_REPOSITORIO>
    ```
2. Navega al directorio del proyecto:
    ```bash
    cd <NOMBRE_DEL_DIRECTORIO>
    ```
3. Abre el proyecto en Xcode:
    ```bash
    open RecipesApp.xcodeproj
    ```

## Uso
Para ejecutar la aplicación en un simulador o dispositivo, sigue estos pasos:

1. Abre el proyecto en Xcode.
2. Selecciona el esquema `RecipesApp`.
3. Elige un simulador o dispositivo.
4. Haz clic en el botón de Run o usa el atajo de teclado `Cmd + R`.

## Modularización
RecipesApp es una aplicación modularizada para asegurar la independencia entre sus componentes principales, facilitando el trabajo en equipo y la creación de pruebas unitarias.

Para la modularización, se utiliza Swift Package Manager, una herramienta de Apple. Se decidió no usar CocoaPods debido a la disminución de soporte por parte de sus contribuidores.

SPM permite gestionar fácilmente las dependencias mediante el archivo `Package.swift`, y Xcode solo recompila los módulos modificados y sus dependencias directas, mejorando la eficiencia y reduciendo significativamente el tiempo de compilación.

El proyecto está dividido en 7 módulos:

1. **UIComponents**: Contiene componentes personalizados y reutilizables en todo el proyecto.
2. **DIContainer**: Incluye la clase que registra y proporciona las instancias para la inyección de dependencias.
3. **Core**: Centraliza los métodos principales utilizados en el proyecto. Incluye clases base para reducir el código duplicado en las Views y ViewModels, la clase `BaseViewData` para facilitar el transporte de información entre features, y las clases `Factory` para la creación de ViewControllers y ViewModels.
4. **Data**: Implementa el consumo de servicios web utilizando Alamofire y RxSwift para la gestión de procesos en segundo plano. Incluye la clase genérica `NetworkManager` para reutilizar la lógica de procesamiento de respuestas del servidor en todos los servicios web, siguiendo el patrón Repositorio.
5. **Domain**: Contiene las clases con la lógica de negocio, como casos de uso y modelos.
6. **Common**: Centraliza los métodos utilizados en todo el proyecto.
7. **Features**: Incluye las pantallas `HomeView`, `RecipeDetailView` y `MapView`, cada una con su respectiva ViewModel. Cada feature tiene un archivo contenedor para proporcionar instancias de uso global. La clase `AppCoordinator` encapsula la inicialización de la app y maneja la navegación entre pantallas.

<img src="https://github.com/user-attachments/assets/14a456b5-4133-4f81-ad7c-204df3862b2a" width="300" />
<img src="https://github.com/user-attachments/assets/c73e2ca6-9a67-44c4-add6-c4cab4699eb0" width="300" />
<img src="https://github.com/user-attachments/assets/7109c144-e51d-46a7-8057-9e276e152c87" width="300" />
<img src="https://github.com/user-attachments/assets/694629f8-ec95-49b6-8f75-1e6f009826da" width="300" />
<img src="https://github.com/user-attachments/assets/8112f134-c18e-4ab4-b4ee-0442a22ee0ac" width="300" />
