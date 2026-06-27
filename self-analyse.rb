class SelfAnalyse < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/self-analyse"
  url "https://github.com/ramanathan1504/self-analyse/releases/download/v1.0.0/self-analyse-1.0.0-jar-with-dependencies.jar"
  sha256 "cfc1972fe9d71f8fa67861ac9d9569ec3b36f6e0454567dcbda422aa2b410a4a"
  license "Apache-2.0"

  # FIX: Make sure this says 21!
  depends_on "openjdk@17"

  def install
    # Dynamically grabs the filename from the URL above
    jar_filename = File.basename(stable.url)

    # Installs it and renames it to a clean 'self-analyse.jar'
    libexec.install jar_filename => "self-analyse.jar"

    # Create the terminal wrapper script
    (bin/"self-analyse").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="${Formula["openjdk@17"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/self-analyse.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/self-analyse", "--help"
  end
end