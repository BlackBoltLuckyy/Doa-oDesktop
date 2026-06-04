cmake_minimum_required(VERSION 3.10)
project(painel_ong LANGUAGES C CXX)

set(FLUTTER_TARGET "lib/main.dart")

find_package(Flutter REQUIRED)
find_package(FlutterDesktop REQUIRED)

flutter_desktop_embedder_init()

set(WINDOWS_APP_NAME "Painel ONG — Sistema de Doações")
set(WINDOW_MANAGER_FLAGS "--size=1280,800 --min-size=1024,768")

# This file is a placeholder. Use flutter create to generate a complete windows project structure.
