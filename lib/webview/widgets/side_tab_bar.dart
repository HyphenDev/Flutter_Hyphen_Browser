import 'package:flutter/material.dart';

class SideTabBar extends StatelessWidget {
  final List<String> pinnedUrls;
  final List<String> tabs;
  final int currentTabIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onNewTab;
  final ValueChanged<String> onPinnedUrlSelected;

  const SideTabBar({
    Key? key,
    required this.pinnedUrls,
    required this.tabs,
    required this.currentTabIndex,
    required this.onTabSelected,
    required this.onNewTab,
    required this.onPinnedUrlSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: const Color(0xFFB5B5D2), 
      child: Column(
        children: [
          _buildTopBar(),
          
          _buildAppGrid(),
          
          _buildMySection(),
          
          _buildNewTabButton(),
          
          Expanded(child: _buildTabList()),
          
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.folder_outlined, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Icon(Icons.arrow_back, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Icon(Icons.refresh, size: 16, color: Colors.grey[600]),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'google.com',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Translation Available',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppGrid() {
    final List<Map<String, dynamic>> apps = [
      {'icon': Icons.play_arrow_rounded, 'color': Colors.red, 'bg': Colors.grey[300]},
      {'icon': Icons.mail_rounded, 'color': Colors.red, 'bg': Colors.grey[300]},
      {'icon': Icons.circle, 'color': Colors.black, 'bg': Colors.grey[300]},
      {'icon': Icons.search, 'color': Colors.blue, 'bg': Colors.grey[300]},
      {'icon': Icons.code, 'color': Colors.black, 'bg': Colors.grey[300]},
      {'icon': Icons.photo_camera, 'color': Colors.pink, 'bg': Colors.grey[300]},
      {'icon': Icons.auto_awesome, 'color': Colors.orange, 'bg': Colors.grey[300]},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: apps[index]['bg'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                apps[index]['icon'],
                color: apps[index]['color'],
                size: 22,
              ),
              onPressed: () {
              },
              tooltip: 'App ${index + 1}',
            ),
          );
        },
      ),
    );
  }

  Widget _buildMySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.public, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            'my',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewTabButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(Icons.add, color: Colors.grey[600], size: 20),
          title: Text(
            'New Tab',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          onTap: onNewTab,
        ),
      ),
    );
  }

  Widget _buildTabList() {
    final List<Map<String, dynamic>> tabIcons = [
      {'icon': Icons.auto_awesome, 'color': Colors.orange},
      {'icon': Icons.search, 'color': Colors.blue},
      {'icon': Icons.search, 'color': Colors.blue},
      {'icon': Icons.description, 'color': Colors.blue},
      {'icon': Icons.apps, 'color': Colors.purple},
    ];

    return ListView.builder(
      itemCount: tabs.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      itemBuilder: (context, index) {
        final url = tabs[index];
        final bool isSelected = (index == currentTabIndex);
        
        final iconData = index < tabIcons.length 
            ? tabIcons[index]['icon'] 
            : Icons.public;
        final iconColor = index < tabIcons.length 
            ? tabIcons[index]['color'] 
            : Colors.blue;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(iconData, size: 20, color: iconColor),
            title: Text(
              url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            onTap: () => onTabSelected(index),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'New Arc Version Available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}