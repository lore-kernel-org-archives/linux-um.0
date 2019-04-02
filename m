Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBF1R-0003pA-J9
 for linux-um@lists.infradead.org; Tue, 02 Apr 2019 08:43:59 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id k188so293603yba.2
 for <linux-um@lists.infradead.org>; Tue, 02 Apr 2019 01:43:56 -0700 (PDT)
Date: Tue,  2 Apr 2019 10:43:32 +0200
Message-Id: <20190402084332.88965-1-dwalter@google.com>
Mime-Version: 1.0
Subject: [PATCH]  um: Do not unlock mutex that is not hold.
From: Daniel Walter <dwalter@google.com>
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
To: richard@nod.at, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Daniel Walter <dwalter@google.com>

 Return error instead of trying to unlock a mutex that is not hold.

Signed-off-by: Daniel Walter <dwalter@google.com>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index aca09be2373e..33c1cd6a12ac 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -276,14 +276,14 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 		str++;
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
-			goto out1;
+			return err;
 		}
 
 		err = -EINVAL;
 		major = simple_strtoul(str, &end, 0);
 		if((*end != '\0') || (end == str)){
 			*error_out = "Didn't parse major number";
-			goto out1;
+			return err;
 		}
 
 		mutex_lock(&ubd_lock);
-- 
2.21.0.392.gf8f6787159e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

