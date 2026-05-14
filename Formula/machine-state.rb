class MachineState < Formula
  desc "Local-first machine awareness daemon for macOS"
  homepage "https://github.com/sashreek-das/machine-state"
  version "0.1.0"
  license "MIT"

  # Pre-built binaries — no Python required on the target machine.
  # SHA256 values are printed by the GitHub Actions release job.
  on_arm do
    url "https://github.com/sashreek-das/machine-state/releases/download/v#{version}/machine-state-arm64.tar.gz"
    sha256 "REPLACE_WITH_ARM64_SHA256"
  end

  on_intel do
    url "https://github.com/sashreek-das/machine-state/releases/download/v#{version}/machine-state-x86_64.tar.gz"
    sha256 "REPLACE_WITH_X86_64_SHA256"
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    bin.install "machine-state-#{arch}" => "machine-state"
  end

  def post_install
    # Runtime data lives in ~/.machine-state — create on first install
    (Dir.home + "/.machine-state").tap { |d| FileUtils.mkdir_p(d) }
  end

  test do
    assert_match "usage: machine-state", shell_output("#{bin}/machine-state --help 2>&1")
  end
end
