Return-Path: <linux-kernel-owner@vger.kernel.org>
From: James Pack <jpack61108@gmail.com>
Subject: [PATCH] Fix minor typos and grammar in UML start_up help
Date: Tue,  8 Aug 2017 13:19:41 -0700
Message-Id: <1502223582-102437-1-git-send-email-jpack61108@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 
Cc: jpack61108@gmail.com, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: James Pack <jpack61108@gmail.com>
---
 arch/um/os-Linux/start_up.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index b1b6b75..82bf5f8 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -154,10 +154,10 @@ static int __init nosysemu_cmd_param(char *str, int* add)
 
 __uml_setup("nosysemu", nosysemu_cmd_param,
 "nosysemu\n"
-"    Turns off syscall emulation patch for ptrace (SYSEMU) on.\n"
+"    Turns off syscall emulation patch for ptrace (SYSEMU).\n"
 "    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
-"    behaviour of ptrace() and helps reducing host context switch rate.\n"
-"    To make it working, you need a kernel patch for your host, too.\n"
+"    behaviour of ptrace() and helps reduce host context switch rates.\n"
+"    To make it work, you need a kernel patch for your host, too.\n"
 "    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further \n"
 "    information.\n\n");
 
-- 
2.7.4


