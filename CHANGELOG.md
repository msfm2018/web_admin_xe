# Changelog
## 1.1.3

*  Code Cleanup: Minor internal improvements and code optimizations.
*  Documentation: Improved inline documentation and comments.

## 1.1.2

*  Static Analysis: Fixed "Missing type annotation" lints in lib/src/right.dart to improve type safety and achieve a perfect Pub.dev analysis score.

*  Refactoring: Explicitly defined String types for helper methods container() and text().

## 1.1.1

*  Fixes: Resolved lint warnings and deprecated API usage (withOpacity to withValues).
*  Naming: Normalized file naming to follow Dart's lower\_case\_with\_underscores convention.
*  Docs: Continued improvement of API documentation.

## 1.1.0

* **Documentation \& Standards:**:

  * Completed full API documentation; achieved 100% doc coverage for core libraries.
  * Optimized package structure to align with Pub.dev best practices.
* **Model Optimization:**:

  * Enhanced robustness of TreeNode.fromJson.
  * Fixed icon parsing logic to support mapping IconData via string names.
* **Visual Experience**:

  * Optimized responsive width calculation for the Sidebar (using a clamp strategy).
  * Improved visual differentiation between selected and unselected Tabs.

## 1.0.1

* **Automation Tools**: Introduced gen\_route.dart script to automatically generate route
* **Cleanup**: Removed redundant dependencies to reduce package size.

## 1.0.0

* **Core Architecture**:

  * Support dynamic tree generation from standard JSON format.
  * Integrated rxflare for state management, enabling partial UI refreshes during tab switching.
  * Added page caching mechanism to persist page states (e.g., scroll position) when switching tabs.

## 0.1.1

* **UI Enhancement**: Fixed background color display issues for the Toolbar in unselected states.

## 0.1.0

* **API Standardization**: Unified parameter naming conventions and added required field assertions for key constructors.

## 0.0.8

* **Parameter Optimization**: Refined internal state propagation logic and strengthened type constraints.

## 0.0.6

* **Layout Fixes**:

  * Resolved indentation calculation errors in nested tree structures.
  * Fixed naming conflicts within the TreeNode class.

## 0.0.5

* **Logic Fix**: Corrected the index determination logic for the tree node's selected state.

## 0.0.2

* **Performance**:Removed unnecessary third-party package references to minimize bundle size.

## 0.0.1

* **Initial Release**: Basic tree menu implementation with a responsive content area layout.
