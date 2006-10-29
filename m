Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGD5-00068w-TS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:44 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGD4-0007OR-CY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:43 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:41 +0100
Message-Id: <20061029192041.12292.95078.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 07/11] uml ubd driver: reformat ubd_config
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Pure whitespace and style fixes split out from subsequent patch. Some changes
(err -> ret) don't make sense now, only later, but I split them out anyway since
they cluttered the patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1202592..48b2a4f 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -709,27 +709,36 @@ out:
 
 static int ubd_config(char *str)
 {
-	int n, err;
+	int n, ret;
 
 	str = kstrdup(str, GFP_KERNEL);
-	if(str == NULL){
+	if (str == NULL) {
 		printk(KERN_ERR "ubd_config failed to strdup string\n");
-		return(1);
+		ret = 1;
+		goto out;
 	}
-	err = ubd_setup_common(str, &n);
-	if(err){
-		kfree(str);
-		return(-1);
+	ret = ubd_setup_common(str, &n);
+	if (ret) {
+		ret = -1;
+		goto err_free;
+	}
+	if (n == -1) {
+		ret = 0;
+		goto out;
 	}
-	if(n == -1) return(0);
 
  	mutex_lock(&ubd_lock);
-	err = ubd_add(n);
-	if(err)
+	ret = ubd_add(n);
+	if (ret)
 		ubd_devs[n].file = NULL;
  	mutex_unlock(&ubd_lock);
 
-	return(err);
+out:
+ 	return ret;
+
+err_free:
+	kfree(str);
+	goto out;
 }
 
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
