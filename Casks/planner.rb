cask "planner" do
  version "0.2"
  sha256 "6d9c70d9c9cf531828b5cd2453a80fc952b188825bfe87b096fc42abe89c0d11"

  url "https://github.com/ZitronenCitrat/homebrew-tap/releases/download/planner-v#{version}/Planner-#{version}.zip"
  name "Planner"
  desc "Personal planner for calendar, tasks, studies, habits and subscriptions"
  homepage "https://github.com/ZitronenCitrat/homebrew-tap"

  depends_on macos: :golden_gate

  app "Planner.app"

  zap trash: [
    "~/Library/Application Scripts/de.felixfischer-hh.planner",
    "~/Library/Containers/de.felixfischer-hh.planner",
  ]

  caveats <<~EOS
    A Planner account is required (created in the Supabase dashboard).

    This app is ad-hoc signed and not notarized, so macOS Gatekeeper refuses to
    open it the first time. Clear the quarantine flag once:

      xattr -dr com.apple.quarantine "#{appdir}/Planner.app"

    After each update macOS asks once whether Planner may access its saved
    login in the keychain — choose "Always Allow".
  EOS
end
