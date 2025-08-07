<p align="center">
  <img width="548" height="193" alt="pokedex" src="https://github.com/user-attachments/assets/5fcdd856-72e8-4041-bcfb-653879960bc4" />
</p>

<h1 align="center">📱 PokéPod - Flutter Pokédex App</h1>

<p align="center">
  A clean and modern Pokédex built with Flutter + Riverpod.<br/>
  Includes favorites, detailed stats, and a splash screen.<br/>
</p>

<hr/>

<h2>🚀 Features</h2>
<ul>
  <li>Splash screen with Pokédex image and transition</li>
  <li>Beautiful UI with AppBar image title</li>
  <li>Favorites section (single-row horizontal scroll)</li>
  <li>Main Pokédex list (major screen portion)</li>
  <li>Pokemon details in modal (name, image, stats)</li>
  <li>Riverpod for state management</li>
</ul>

<h2>🗂️ Folder Structure</h2>

<pre><code>
pokipod/
├── assets/
│   └── pokedex.png
├── controllers/
│   └── home_page_controller.dart
├── models/
│   └── pokemon.dart
│   └── page_data.dart
├── pages/
│   ├── home_page.dart
│   ├── splash_screen.dart
├── providers/
│   ├── pokemon_data_providers.dart
│   └── favourite_pokemons_provider.dart
├── services/
│   ├── database_service.dart
│   ├── http_service.dart
├── widgets/
│   ├── pokemon_card.dart
│   └── pokemon_list_tile.dart
│   ├── pokemon_stats_card.dart
├── pokedex.dart
├── main.dart
├── pubspec.yaml
└── README.md
</code></pre>

<h2>📸 Screenshots</h2>

<p align="center">
  
  <img src="./assets/app_screenshot.jpg" alt="Main Screen" width="500" height="600">
</p>


<h2>⚙️ Getting Started</h2>

<pre><code>
git clone git@github.com:your-username/pokipod.git
cd pokipod
flutter pub get
flutter run
</code></pre>

<h2>🎯 Roadmap</h2>
<ul>
  <li>Animations on splash and cards</li>
  <li>Bottom navigation for filtering (types/regions)</li>
  <li>Detailed Pokémon view (abilities, evolution, etc.)</li>
  <li>Custom Pokémon-themed fonts and colors</li>
</ul>

