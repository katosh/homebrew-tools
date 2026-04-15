class Lab < Formula
  desc "Project-local JupyterLab management CLI for humans and AI agents"
  homepage "https://github.com/katosh/lab"
  url "https://github.com/katosh/lab/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "37ea0600bd594f2c69e71f82b1915ddeacf18c7d0280db20699e9f3091d21c12"
  license "MIT"

  depends_on "uv"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      lab manages project-local JupyterLab instances and provides CLI
      access to live Jupyter kernels.

      Quick start:
        cd /path/to/project
        lab kernel add            # create .venv and register kernel
        lab start                 # start JupyterLab in background
        lab kernel exec "print('hello')"
        lab help                  # full usage

      HTTPS with auto-generated self-signed certs:
        lab start --https

      Full documentation:
        #{share}/doc/lab/lab.md
        https://github.com/katosh/lab
    EOS
  end

  test do
    assert_match "Project-local JupyterLab", shell_output("#{bin}/lab help")
  end
end
