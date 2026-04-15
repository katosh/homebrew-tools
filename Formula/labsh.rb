class Labsh < Formula
  desc "Project-local JupyterLab management CLI for humans and AI agents"
  homepage "https://github.com/katosh/labsh"
  url "https://github.com/katosh/labsh/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "dca437a02f4b92ba896216c5e30c79c9423dceb6275734f47a57bef263b8ff86"
  license "MIT"

  depends_on "uv"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      labsh manages project-local JupyterLab instances and provides CLI
      access to live Jupyter kernels.

      Quick start:
        cd /path/to/project
        labsh kernel add            # create .venv and register kernel
        labsh start                 # start JupyterLab in background
        labsh kernel exec "print('hello')"
        labsh help                  # full usage

      HTTPS with auto-generated self-signed certs:
        labsh start --https

      Claude Code skill:
        The `/labsh` slash command is installed to ~/.claude/commands/
        for use as an AI agent skill.

      Full documentation:
        #{share}/doc/labsh/labsh.md
        https://github.com/katosh/labsh
    EOS
  end

  test do
    assert_match "Project-local JupyterLab", shell_output("#{bin}/labsh help")
  end
end
