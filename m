Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Sun,  8 May 2011 23:59:44 +0200
Message-Id: <1304891985-11569-3-git-send-email-richard@nod.at>
In-Reply-To: <1304891985-11569-1-git-send-email-richard@nod.at>
References: <1304891985-11569-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 3/4] um: remove SIGHUP handler
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The UML kernel ignores SIGHUP anyway.
This handler is in vain.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 39613ea..fb2a97a 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -142,7 +142,6 @@ int __init main(int argc, char **argv, char **envp)
 	 */
 	install_fatal_handler(SIGINT);
 	install_fatal_handler(SIGTERM);
-	install_fatal_handler(SIGHUP);
 
 	scan_elf_aux(envp);
 
-- 
1.7.4.2

