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

  # Ad-hoc signed, not notarized: without this Gatekeeper refuses the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PokePortfolio.app"]
  end

  uninstall quit: "de.felixfischer.PokedexPortfolioDesktop"

  zap trash: "~/Library/Containers/de.felixfischer.PokedexPortfolioDesktop"

  caveats <<~EOS
    On the first launch of every new version the app copies your collection
    (User.store) to its container before anything is migrated:
      ~/Library/Containers/de.felixfischer.PokedexPortfolioDesktop/Data/Library/
      Application Support/de.felixfischer.PokedexPortfolioDesktop/Backups/

    `brew uninstall` keeps your data; `brew uninstall --zap` deletes it,
    including the collection and those backups.

    After an update macOS may ask once whether the app may access its own
    data — choose "Allow".
  EOS
end
