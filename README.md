# Drawing App

This is a Flutter application that allows users to draw shapes on a canvas, move, scale, and rotate them using mouse or touch input. Users can also upload an image as a background for the canvas and get the coordinates of points on the image.

## Features

*   **Drawing Canvas**: A canvas where users can draw various shapes.
*   **Shape Manipulation**: Move, scale, and rotate shapes using mouse or touch gestures.
*   **Custom Background**: Upload an image to set as the canvas background.
*   **Coordinate System**: Get the coordinates of any point on the uploaded background image.

## Development Setup

### Prerequisites

*   Flutter SDK: Make sure you have the Flutter SDK installed. You can find instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   An editor like Visual Studio Code or Android Studio with the Flutter plugin.

### Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/drawing-app.git
    cd drawing-app
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

## Development Workflow

This section outlines the detailed development steps to implement the application's features.

### 1. Setting up the Canvas

*   **Goal**: Create a basic canvas where drawing can occur.
*   **File**: `lib/main.dart`
*   **Steps**:
    1.  Replace the `Center` widget in `_DrawingCanvasState` with a `GestureDetector` to capture user input.
    2.  Inside the `GestureDetector`, use a `CustomPaint` widget with a `CustomPainter` to draw on the canvas.
    3.  The `CustomPainter` will hold the logic for rendering shapes.

### 2. Drawing Shapes

*   **Goal**: Allow users to draw a simple shape (e.g., a rectangle).
*   **Files**: `lib/main.dart`, `lib/shape_painter.dart` (new file)
*   **Steps**:
    1.  Create a `Shape` class to model the properties of a shape (position, size, rotation, color).
    2.  In `_DrawingCanvasState`, maintain a list of `Shape` objects.
    3.  Use the `onPanUpdate` callback of the `GestureDetector` to add new shapes to the list.
    4.  Update the `CustomPainter` to iterate through the list of shapes and draw them on the canvas.

### 3. Shape Manipulation

*   **Goal**: Implement moving, scaling, and rotating shapes.
*   **Files**: `lib/main.dart`
*   **Steps**:
    1.  **Selection**: In the `onTapDown` callback of the `GestureDetector`, check if the tap occurred on an existing shape. If so, mark it as selected.
    2.  **Translation (Move)**: Use the `onPanUpdate` callback. If a shape is selected, update its position based on the drag details.
    3.  **Scaling and Rotation**: Use the `onScaleUpdate` callback of the `GestureDetector`. If a shape is selected, update its `scale` and `rotation` properties from the `ScaleUpdateDetails`.
    4.  Re-render the canvas by calling `setState`.

### 4. Custom Background Image

*   **Goal**: Allow users to upload an image and set it as the canvas background.
*   **Dependencies**: `image_picker` package.
*   **Steps**:
    1.  Add the `image_picker` package to `pubspec.yaml`.
    2.  Add a button to the UI that, when pressed, uses `image_picker` to let the user select an image from their gallery.
    3.  Store the selected image in the `_DrawingCanvasState`.
    4.  In the `build` method, wrap the canvas widget in a `Stack` and place the image behind it.

### 5. Coordinate System

*   **Goal**: Display the coordinates of a point on the background image when the user taps on it.
*   **Files**: `lib/main.dart`
*   **Steps**:
    1.  In the `onTapUp` callback of the `GestureDetector`, get the local position of the tap.
    2.  If there is a background image, you may need to transform the tap coordinates to match the image's coordinate system, especially if the image is scaled or positioned differently from the canvas.
    3.  Display the coordinates on the screen, for example, in a `Text` widget or a temporary overlay.

## Testing

A robust testing strategy is crucial for ensuring the quality of the application. This project is set up with a testing environment that includes unit, widget, and integration tests.

### Setup

Before running the tests, ensure you have the development dependencies installed:

```bash
flutter pub get
```

The necessary dependencies, including `flutter_test` and `integration_test`, are already included in `pubspec.yaml`.

### Unit Tests

*   **Goal**: Test individual functions and classes in isolation.
*   **Location**: `test/` directory.
*   **Example**: `test/unit_test.dart` contains a simple unit test for a `Shape` class.
*   **To run all unit and widget tests:**
    ```bash
    flutter test
    ```
*   **To run a specific unit test file:**
    ```bash
    flutter test test/unit_test.dart
    ```

### Widget Tests

*   **Goal**: Test individual widgets to ensure they render and behave as expected.
*   **Location**: `test/` directory.
*   **Example**: `test/widget_test.dart` contains a widget test that verifies a circle is drawn on tap.
*   **To run a specific widget test file:**
    ```bash
    flutter test test/widget_test.dart
    ```

### Integration Tests

*   **Goal**: Test a complete user flow, from drawing a shape to manipulating it.
*   **Location**: `integration_test/` directory.
*   **Setup**: The integration testing environment requires a test driver, which is located at `test_driver/integration_test.dart`.
*   **Example**: `integration_test/app_test.dart` contains a simple integration test.
*   **To run integration tests:**
    ```bash
    flutter test integration_test
    ```

### Running All Tests

To run all unit and widget tests in the project, simply run:

```bash
flutter test
```

To run all tests, including integration tests, you can run the commands for each type of test sequentially.