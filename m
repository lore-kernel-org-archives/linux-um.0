Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krAsQ-0005MH-Pn
 for linux-um@lists.infradead.org; Mon, 21 Dec 2020 02:24:47 +0000
Received: by mail-pl1-x62a.google.com with SMTP id g3so4853429plp.2
 for <linux-um@lists.infradead.org>; Sun, 20 Dec 2020 18:24:45 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH] um: ubd: fix command line handling of ubd
Date: Mon, 21 Dec 2020 11:24:34 +0900
Message-Id: <20201221022434.21725-1-thehajime@gmail.com>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: Hajime Tazaki <thehajime@gmail.com>, Christopher Obbard <chris.obbard@collabora.com>

This commit fixes a regression to handle command line parameters of ubd.
With a simple line "./linux ubd0="./disk-ext4.img", it fails at
ubd_setup_common().  The commit adds additional checks to the variables
in order to properly parse the paremeters which previously worked.

Fixes: ef3ba87cb7c9 ("um: ubd: Set device serial attribute from
cmdline")
Cc: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 13b1fe694b90..bd16b17ba4d6 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -375,11 +375,11 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
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
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

