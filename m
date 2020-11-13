Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdWHk-0001l9-3g
 for linux-um@lists.infradead.org; Fri, 13 Nov 2020 10:26:28 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Remove use of asprinf in umid.c
Date: Fri, 13 Nov 2020 10:26:17 +0000
Message-Id: <20201113102617.17954-1-anton.ivanov@cambridgegreys.com>
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

asprintf is not compatible with the existing uml memory allocation
mechanism. Its use on the "user" side of UML results in a corrupt slab
state.

Fixes: 492edce1306f (um: remove uses of variable length arrays)

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/umid.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 1d7558dac75f..a3dd61521d24 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -137,20 +137,13 @@ static inline int is_umdir_used(char *dir)
 {
 	char pid[sizeof("nnnnnnnnn")], *end, *file;
 	int dead, fd, p, n, err;
-	size_t filelen;
+	size_t filelen = strlen(dir) + sizeof("/pid") + 1;
 
-	err = asprintf(&file, "%s/pid", dir);
-	if (err < 0)
-		return 0;
-
-	filelen = strlen(file);
+	file = malloc(filelen);
+	if (!file)
+		return -ENOMEM;
 
-	n = snprintf(file, filelen, "%s/pid", dir);
-	if (n >= filelen) {
-		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
-		err = -E2BIG;
-		goto out;
-	}
+	snprintf(file, filelen, "%s/pid", dir);
 
 	dead = 0;
 	fd = open(file, O_RDONLY);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

