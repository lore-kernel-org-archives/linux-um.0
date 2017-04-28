Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 7/7] um: console: Ignore console= option
Date: Fri, 28 Apr 2017 19:27:58 +0900
Message-Id: <149337526798.14717.4167125770768748331.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Ignore linux kernel's console= option at uml's console
option handler. Since uml's con= option is only for
setting up new console, and Linux kernel's console=
option specify to which console kernel output its
message, we can use both option for different purpose.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/drivers/stdio_console.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 7b361f3..43b12a5 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -192,6 +192,9 @@ __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
+	if (!strncmp(str, "sole=", 5))	/* This may passed to tty */
+		return 0;
+
 	line_setup(vt_conf, MAX_TTYS, &def_conf, str, "console");
 	return 1;
 }


