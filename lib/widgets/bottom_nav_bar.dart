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
    final int currentIndex = selectedIndex < 0 ? 0 : selectedIndex;
    final bool hasSelection = selectedIndex >= 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: hasSelection
              ? const Color(0xFF2196F3)
              : inActiveIconColor,
          unselectedItemColor: inActiveIconColor,
          iconSize: 28,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/documento.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  selectedIndex == 0
                      ? const Color(0xFF2196F3)
                      : inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/svgs/documento.svg",
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2196F3),
                  BlendMode.srcIn,
                ),
              ),
              label: "Relatórios",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/calendario.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  selectedIndex == 1
                      ? const Color(0xFF2196F3)
                      : inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/svgs/calendario.svg",
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2196F3),
                  BlendMode.srcIn,
                ),
              ),
              label: "Calendário",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/botao-adicionar.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  selectedIndex == 2
                      ? const Color(0xFF2196F3)
                      : inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/svgs/botao-adicionar.svg",
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2196F3),
                  BlendMode.srcIn,
                ),
              ),
              label: "Adicionar",
            ),
          ],
        ),
      ),
    );
  }
}