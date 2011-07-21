Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 22 Jul 2011 00:18:45 +0200
Message-Id: <1311286725-27137-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml: drivers/net_user.c memory leak fix
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Vitaliy Ivanov <vitalivanov@gmail.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Vitaliy Ivanov <vitalivanov@gmail.com>

Perform memory cleanup on exit.
On receiving invalid 'pid' we still should clean 'output' variable.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/net_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 9415dd9..5201188 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -228,7 +228,10 @@ static void change(char *dev, char *what, unsigned char *addr,
 		       "buffer\n");
 
 	pid = change_tramp(argv, output, output_len);
-	if (pid < 0) return;
+	if (pid < 0) {
+		kfree(output);
+		return;
+	}
 
 	if (output != NULL) {
 		printk("%s", output);
-- 
1.7.6

