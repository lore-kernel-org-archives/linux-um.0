Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ubd: remove dead code in ubd_setup_common
Date: Mon, 28 Jun 2021 11:39:37 +0200
Message-Id: <20210628093937.1325608-1-hch@lst.de>
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
To: axboe@kernel.dk, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-block@vger.kernel.org

Remove some leftovers of the fake major number parsing that cause
complains from some compilers.

Fixes: aebbd9fdb0cc ("ubd: remove the code to register as the legacy IDE driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0b86aa1b12f1..e3093071406d 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -243,22 +243,12 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 	if(index_out) *index_out = -1;
 	n = *str;
 	if(n == '='){
-		char *end;
-		int major;
-
 		str++;
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
 			return err;
 		}
 
-		err = -EINVAL;
-		major = simple_strtoul(str, &end, 0);
-		if((*end != '\0') || (end == str)){
-			*error_out = "Didn't parse major number";
-			return err;
-		}
-
 		pr_warn("fake major not supported any more\n");
 		return 0;
 	}
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

