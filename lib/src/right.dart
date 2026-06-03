import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';
import 'core.dart';

/// Right-side content container widget.
///
/// This widget implements a typical admin dashboard layout:
/// 
/// 1. **Toolbar**: Displays opened pages as tabs, supporting selection and closing.
/// 2. **Content Area**: Renders the currently selected page with built-in caching
///    to improve performance.
class Right extends StatefulWidget {
  /// Creates a [Right] widget.
  const Right({super.key});

  @override
  State<Right> createState() => RightState();
}

/// State class for [Right].
///
/// Responsible for managing page caching [_pageCache]
/// and horizontal scrolling of the tab bar.
class RightState extends State<Right> with TickerProviderStateMixin {
  /// Scroll controller for the tab bar.
  late ScrollController _scrollController2;

  /// Page cache map.
  ///
  /// Key: page index  
  /// Value: built widget instance
  ///
  /// This cache ensures that page state (e.g., scroll position, input data)
  /// is preserved when switching tabs, avoiding repeated calls to [PageInfo.builder].
  final Map<int, Widget> _pageCache = {};

  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Tab toolbar
          toolbar(),

          // Main content area with padding and rounded styling
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _visiblePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the currently visible page.
  ///
  /// Listens to [Core.pageAction] and [Core.selectedNodeIndex].
  /// If no page is selected (index == -1), a welcome page is displayed.
  Widget _visiblePage() {
    return Rx.custom(
      deps: [
        Core.instance.pageAction,
        Core.instance.selectedNodeIndex
      ],
      builder: () {
        final selectedIndex =
            Core.instance.selectedNodeIndex.value;

        if (selectedIndex == -1) {
          _pageCache.clear();
          return _buildWelcomePage();
        }

        final page =
            Core.instance.pageMap.value[selectedIndex];

        if (page == null) {
          _pageCache.clear();
          return _buildWelcomePage();
        }

        // Ensure each page is built only once
        return _pageCache.putIfAbsent(
          page.index,
          () => page.builder(),
        );
      },
    );
  }

  /// ================= Page Display =================

  /// Builds the default welcome page.
  ///
  /// Displayed when no page is selected or no tabs are open.
  Widget _buildWelcomePage() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const FlutterLogo(size: 80),
          ),
          const SizedBox(height: 24),
          const Text(
            "Welcome to the Admin Dashboard",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Please select a feature from the left menu to get started",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the tab toolbar.
  ///
  /// This is a reactive widget that updates when
  /// [activePageKeys] or selection state changes.
  ///
  /// It contains a horizontally scrollable tab list.
  Widget toolbar() {
    return Rx.custom(
      deps: [
        Core.instance.activePageKeys,
        Core.instance.selectedNodeIndex,
        Core.instance.pageMap,
        Core.instance.isSidebarCollapsed,
      ],
      builder: () {
        final activePages = Core.instance.activePageKeys.value
            .map((k) => Core.instance.pageMap.value[k])
            .whereType<PageInfo>()
            .toList();

        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom:
                  BorderSide(color: Colors.grey.shade200),
            ),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activePages.map((page) {
                      final isSelected =
                          page.index ==
                              Core.instance
                                  .selectedNodeIndex
                                  .value;

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 4),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(8),
                            onTap: () =>
                                _handleSelection(page),
                            child: Container(
                              height: 42,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                          horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Core.instance
                                            .selectedColor ??
                                        Colors.blue[100]
                                    : Colors.grey[100],
                                borderRadius:
                                    BorderRadius.circular(
                                        8),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey[300]!,
                                  width: isSelected
                                      ? 1.5
                                      : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  if (page.icon != null)
                                    Icon(
                                      page.icon,
                                      size: 16,
                                      color: isSelected
                                          ? Colors.blue
                                              .shade600
                                          : Colors.grey
                                              .shade600,
                                    ),
                                  if (page.icon != null)
                                    const SizedBox(
                                        width: 6),
                                  Text(page.title),
                                  const SizedBox(
                                      width: 12),
                                  InkWell(
                                    onTap: () =>
                                        _handleIconButton(
                                            page),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= Events =================

  /// Handles tab selection.
  void _handleSelection(PageInfo page) {
    Core.instance.selectedNodeIndex.value =
        page.index;
    Core.instance.openPage(page.index);
  }

  /// Handles tab close action.
  ///
  /// Also removes the corresponding page from [_pageCache].
  void _handleIconButton(PageInfo page) {
    _pageCache.remove(page.index);
    Core.instance.closePage(page.index);
  }

  @override
  void dispose() {
    _scrollController2.dispose();
    super.dispose();
  }
}