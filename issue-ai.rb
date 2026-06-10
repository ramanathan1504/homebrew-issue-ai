class IssueAi < Formula
  desc "Offline-first, AI-powered Personal Copilot for Open Source Triage"
  homepage "https://github.com/ramanathan1504/issue-ai"
  url "https://github.com/ramanathan1504/issue-ai/releases/download/v1.0.9/issue-ai-1.0.9.jar"
  sha256 "fdec891cea199ed9275dd47390df2c6419c514736e259119d000a8ffee672219"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    # Dynamically grabs the filename from the URL above
    jar_filename = File.basename(stable.url)

    # Installs it and renames it to a clean 'issue-ai.jar'
    libexec.install jar_filename => "issue-ai.jar"

    # Create the terminal wrapper script
    (bin/"issue-ai").write <<~EOS
      #!/bin/bash
      # FIX: Notice the '#' here instead of '$'
      export JAVA_HOME="#{Formula["openjdk@17"].opt_prefix}"
      exec "${JAVA_HOME}/bin/java" -jar "#{libexec}/issue-ai.jar" "$@"
    EOS
  end

  test do
    system "#{bin}/issue-ai", "--help"
  end
end
