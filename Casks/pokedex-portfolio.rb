cask "pokedex-portfolio" do
  version "1.0"
  sha256 "1f565c4f8dc496a4f246132e756f172d64dd4a76f730a9e8fe8b0b6e91cbe0e2"

  url "https://github.com/ZitronenCitrat/homebrew-tap/releases/download/pokedex-portfolio-v#{version}/PokePortfolio-#{version}.zip"
  name "Pokédex Portfolio"
  desc "Pokémon TCG collection manager with Pokédex, EN/DE/JA card catalog and prices"
  homepage "https://github.com/ZitronenCitrat/homebrew-tap"

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "PokePortfolio.app"

  # The collection lives only in User.store; a new version may migrate it. Copy it before every install/upgrade.
  preflight_steps do
    if_path_exists "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
                   "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store", base: :home do
      copy "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
           "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store",
           "Documents/PokedexPortfolio-Backups/brew-before-{{version}}/User.store",
           source_base: :home, target_base: :home
    end
    if_path_exists "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
                   "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store-wal", base: :home do
      copy "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
           "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store-wal",
           "Documents/PokedexPortfolio-Backups/brew-before-{{version}}/User.store-wal",
           source_base: :home, target_base: :home
    end
    if_path_exists "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
                   "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store-shm", base: :home do
      copy "Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/" \
           "Application Support/de.felixfischer.PokedexPortfolioDesktop/User.store-shm",
           "Documents/PokedexPortfolio-Backups/brew-before-{{version}}/User.store-shm",
           source_base: :home, target_base: :home
    end
  end

  # Ad-hoc signed, not notarized: without this Gatekeeper refuses the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PokePortfolio.app"]
  end

  uninstall quit: "de.felixfischer.PokedexPortfolioDesktop"

  zap trash: "~/Library/Containers/de.felixfischer.PokedexPortfolioDesktop"

  caveats <<~EOS
    Before every install and upgrade your collection (User.store) is copied to
    ~/Documents/PokedexPortfolio-Backups/brew-before-<version>/. `brew uninstall` keeps your data;
    `brew uninstall --zap` deletes it, including the collection.

    After an update macOS may ask once whether the app may access its own
    data — choose "Allow".
  EOS
end
