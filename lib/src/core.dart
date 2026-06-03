import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';

/// Core event types used to bind business events to reactive states.
///
/// Each event can be mapped to a corresponding [RxState] in [Core]
/// using the [getTarget] method.
enum CoreEvent {
  /// Page navigation event
  page,

  /// Button click event
  btn,

  /// List item action event
  item;

  /// Returns the corresponding [RxState<int>] from [Core]
  /// based on the current enum value.
  RxState<int> getTarget(Core core) => switch (this) {
        CoreEvent.page => core.pageAction,
        CoreEvent.btn => core.btnAction,
        CoreEvent.item => core.itemAction,
      };
}

/// Global singleton manager responsible for state handling,
/// page navigation logic, and UI configuration.
///
/// This class follows the reactive programming model provided by `rxflare`.
/// All variables ending with `.obs` are observable states.
class Core {
  /// Private constructor to enforce singleton pattern.
  Core._();

  /// The global singleton instance of [Core].
  static final Core instance = Core._();

  /// Whether the sidebar is currently collapsed.
  final isSidebarCollapsed = false.obs;

  /// List of active page indexes (supports multi-tab behavior).
  final activePageKeys = <int>[].obs;

  /// Reactive state: tracks page navigation actions.
  final pageAction = (-1).obs;

  /// Reactive state: tracks button actions.
  final btnAction = (-1).obs;

  /// Reactive state: tracks item actions.
  final itemAction = (-1).obs;

  /// Map of all available pages.
  ///
  /// Key: page index  
  /// Value: [PageInfo]
  final pageMap = <int, PageInfo>{}.obs;

  /// Currently selected node index in the UI.
  final selectedNodeIndex = (-1).obs;

  // --- UI configuration ---

  /// Background color for selected nodes.
  Color? selectedColor = Colors.blue[200];

  /// Whether all tree nodes are expanded by default.
  bool isAllExpanded = false;

  /// Internal text style storage.
  TextStyle? _style;

  /// Toggles the sidebar collapsed/expanded state.
  void toggleSidebar() {
    isSidebarCollapsed.value = !isSidebarCollapsed.value;
  }

   /// Default text style configuration.
  static const _defaultStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(129, 19, 9, 9),
  );

  /// Returns the current text style.
  /// Falls back to default if [_style] is not set.
  TextStyle get style => _style ?? _defaultStyle;

  /// Sets a custom text style.
  set style(TextStyle? newStyle) => _style = newStyle;

  /// Notifies a specific reactive state.
  ///
  /// [type] specifies the event type.  
  /// [value] is the associated index.
  void notify(CoreEvent type, int value) {
    type.getTarget(this).value = value;
  }

  /// Core navigation logic: switches to a page by index.
  ///
  /// If [index] is -1, resets the selection state.  
  /// If the page is not active, it will be added and activated.
  void switchPage(int index) {
    if (index == -1) {
      selectedNodeIndex.value = -1;
      return;
    }

    if (!activePageKeys.contains(index)) {
      activePageKeys.add(index);

      final page = pageMap.value[index];
      if (page != null) {
        updatePageInfo(index, page.copyWith(isActive: true));
      }
    }

    selectedNodeIndex.value = index;

    // Notify all related events
    for (var event in CoreEvent.values) {
      notify(event, index);
    }
  }

  /// Initializes page data.
  ///
  /// [initialPages] defines the initial set of pages.
  /// This will reset [activePageKeys].
  void initPages(Iterable<PageInfo> initialPages) {
    pageMap.value = {for (var p in initialPages) p.index: p};
    activePageKeys.value = [];
  }

  /// Opens a page (wrapper around [switchPage]).
  void openPage(int index) {
    switchPage(index);
  }

  /// Closes a page by index.
  ///
  /// If the closed page is currently active,
  /// switches to the last available page.
  void closePage(int index) {
    final page = pageMap.value[index];
    if (page == null) return;

    if (activePageKeys.value.contains(index)) {
      activePageKeys.value.remove(index);
      activePageKeys.refresh(); // ensure update
    }

    // Update page state
    updatePageInfo(index, page.copyWith(isActive: false));

    // If closing current page, switch to last one
    if (selectedNodeIndex.value == index) {
      final next =
          activePageKeys.value.isNotEmpty ? activePageKeys.value.last : -1;
      switchPage(next);
    }
  }

  /// Updates page information.
  ///
  /// Uses [Map.of] to create a new instance to trigger reactive updates.
  void updatePageInfo(int index, PageInfo newInfo) {
    pageMap.value = Map.of(pageMap.value)..[index] = newInfo;
  }

  /// Removes a page from the map.
  void removePageInfo(int index) {
    if (!pageMap.value.containsKey(index)) return;
    pageMap.value = Map.of(pageMap.value)..remove(index);
  }

  /// Selects a node without triggering page navigation.
  void selectNode(int index) => selectedNodeIndex.value = index;

  /// Disposes all reactive objects to release resources.
  void dispose() {
    pageAction.dispose();
    btnAction.dispose();
    itemAction.dispose();
    pageMap.dispose();
    selectedNodeIndex.dispose();
  }
}
