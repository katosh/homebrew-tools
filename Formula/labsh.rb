class Labsh < Formula
  desc "Project-local JupyterLab management CLI for humans and AI agents"
  homepage "https://github.com/katosh/labsh"
  url "https://github.com/katosh/labsh/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "8a523dfedb659cd1c706767464c42a9994e4cbfea9d9f32d92975a55f917fa2b"
  license "MIT"

  depends_on "uv"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def post_install
    # Symlink the Claude Code skill into ~/.claude/commands/ so the /labsh
    # slash command is available. This runs outside brew's sandbox, unlike
    # the Makefile's install-skill target which silently fails during build.
    commands_dir = Pathname.new("#{Dir.home}/.claude/commands")
    commands_dir.mkpath
    skill_src = lib/"labsh/commands/labsh.md"
    skill_dst = commands_dir/"labsh.md"
    skill_dst.unlink if skill_dst.symlink? || skill_dst.exist?
    skill_dst.make_symlink(skill_src)
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
    assert_match version.to_s, shell_output("#{bin}/labsh version").strip
  end
end
