Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVAGy-0006BM-7Y
 for linux-um@lists.infradead.org; Wed, 21 Oct 2020 09:19:09 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Remove unnecessary snprintf in umid.c
Date: Wed, 21 Oct 2020 10:18:53 +0100
Message-Id: <20201021091853.2459-1-anton.ivanov@cambridgegreys.com>
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
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

1. We already perform the sprintf inside asprintf when allocating the
name for the pid file. There is no need to snprintf it again -
this is surplus code which was a leftover from the pre-asprintf
version.

2. The new code introduced in 0d4e5ac7e78035950d564e65c38ce148cb9af681
was not returning the same error as the old code upon failure.
This makes its behaviour identical with the old code.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/umid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 1d7558dac75f..c2d7a755521c 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -141,16 +141,7 @@ static inline int is_umdir_used(char *dir)
 
 	err = asprintf(&file, "%s/pid", dir);
 	if (err < 0)
-		return 0;
-
-	filelen = strlen(file);
-
-	n = snprintf(file, filelen, "%s/pid", dir);
-	if (n >= filelen) {
-		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
-		err = -E2BIG;
-		goto out;
-	}
+		return -E2BIG;
 
 	dead = 0;
 	fd = open(file, O_RDONLY);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

