Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1vbd-000541-FP
 for linux-um@lists.infradead.org; Tue, 19 Jan 2021 18:19:54 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id l10so24592050ybt.6
 for <linux-um@lists.infradead.org>; Tue, 19 Jan 2021 10:19:50 -0800 (PST)
Date: Tue, 19 Jan 2021 18:19:45 +0000
Message-Id: <20210119181945.2071053-1-paullawrence@google.com>
Mime-Version: 1.0
Subject: [PATCH] um: ubd: Fix crash from option parsing
From: Paul Lawrence <paullawrence@google.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Gabriel Krisman Bertazi <krisman@collabora.com>, Christopher Obbard <chris.obbard@collabora.com>, Paul Lawrence <paullawrence@google.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Below patch will cause NULL ptr dereferences if the optional filenames
are not present.

Fixes: ef3ba87cb7c9 (um: ubd: Set device serial attribute from cmdline)
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 arch/um/drivers/ubd_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 13b1fe694b90..704989088f28 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -371,15 +371,15 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 
 break_loop:
 	file = strsep(&str, ",:");
-	if (*file == '\0')
+	if (file && *file == '\0')
 		file = NULL;
 
 	backing_file = strsep(&str, ",:");
-	if (*backing_file == '\0')
+	if (backing_file && *backing_file == '\0')
 		backing_file = NULL;
 
 	serial = strsep(&str, ",:");
-	if (*serial == '\0')
+	if (serial && *serial == '\0')
 		serial = NULL;
 
 	if (backing_file && ubd_dev->no_cow) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

