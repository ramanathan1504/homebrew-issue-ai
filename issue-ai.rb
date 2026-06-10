class IssueAi < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/issue-ai"
  url "https://github.com/ramanathan1504/issue-ai/releases/download/v1.0.2/issue-ai-1.0.2.jar"
  sha256 "f6002b71f11d61be8ebfe3c4027936159cc8e3ef305913918f5981df27976ffc"
  license "Apache-2.0"

  # FIX: Make sure this says 21!
  depends_on "openjdk@17"

  def install
    # Dynamically grabs the filename from the URL above
    jar_filename = File.basename(stable.url)

    # Installs it and renames it to a clean 'issue-ai.jar'
    libexec.install jar_filename => "issue-ai.jar"

    # Create the terminal wrapper script
    (bin/"issue-ai").write <<~EOS
      #!/bin/bash
      export JAVA_HOME="${Formula["openjdk@17"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/issue-ai.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/issue-ai", "--help"
  end
end