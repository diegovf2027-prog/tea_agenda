import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.feed,
            color: selectedIndex == 0 ? Colors.blue : inActiveIconColor,
          ),
          activeIcon: const Icon(Icons.feed, color: Colors.blue),
          label: "Feed",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svgs/documento.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              inActiveIconColor,
              BlendMode.srcIn,
            ),
          ),
          activeIcon: SvgPicture.asset(
            "assets/svgs/documento.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          label: "Relatórios",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svgs/calendario.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              inActiveIconColor,
              BlendMode.srcIn,
            ),
          ),
          activeIcon: SvgPicture.asset(
            "assets/svgs/calendario.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          label: "Calendário",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svgs/botao-adicionar.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              inActiveIconColor,
              BlendMode.srcIn,
            ),
          ),
          activeIcon: SvgPicture.asset(
            "assets/svgs/botao-adicionar.svg",
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          label: "Adicionar",
        ),
      ],
    );
  }
}
