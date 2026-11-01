cask "pokedex-portfolio" do
  version "1.3"
  sha256 "88f19601b2082e3d060c15173532a911545dcf826800215e4cf7ecc2b4055208"

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
    This app is ad-hoc signed and not notarized. The cask clears the quarantine
    flag for you; if macOS still refuses to open the app, run once:

      xattr -dr com.apple.quarantine "#{appdir}/PokePortfolio.app"

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
