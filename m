Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGCz-00068e-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:37 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGCy-0007Nc-Uu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:37 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:35 +0100
Message-Id: <20061029192035.12292.67673.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 05/11] uml ubd driver: change ubd_lock to be a
	mutex
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

This lock protects ubd setup and teardown, so is only used in process context;
beyond that, during such setup memory allocations must be performed and some
generic functions which can sleep must be called (such as add_disk()). So
the only correct solution is to make it a mutex instead of a spin_lock.
No other change is done - this lock must be acquired in different places but
it's done afterwards.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 23663b7..e4fd29a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -107,7 +107,8 @@ static inline void ubd_set_bit(__u64 bit
 #define DRIVER_NAME "uml-blkdev"
 
 static DEFINE_SPINLOCK(ubd_io_lock);
-static DEFINE_SPINLOCK(ubd_lock);
+
+static DEFINE_MUTEX(ubd_lock);
 
 static void (*do_ubd)(void);
 
@@ -314,7 +315,7 @@ static int ubd_setup_common(char *str, i
 		}
 
 		err = 1;
- 		spin_lock(&ubd_lock);
+ 		mutex_lock(&ubd_lock);
  		if(fake_major != MAJOR_NR){
  			printk(KERN_ERR "Can't assign a fake major twice\n");
  			goto out1;
@@ -326,7 +327,7 @@ static int ubd_setup_common(char *str, i
 		       major);
  		err = 0;
  	out1:
- 		spin_unlock(&ubd_lock);
+ 		mutex_unlock(&ubd_lock);
 		return(err);
 	}
 
@@ -343,7 +344,7 @@ static int ubd_setup_common(char *str, i
 	}
 
 	err = 1;
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	ubd_dev = &ubd_devs[n];
 	if(ubd_dev->file != NULL){
@@ -405,7 +406,7 @@ break_loop:
 	ubd_dev->cow.file = backing_file;
 	ubd_dev->boot_openflags = flags;
 out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return(err);
 }
 
@@ -716,11 +717,11 @@ static int ubd_config(char *str)
 	}
 	if(n == -1) return(0);
 
- 	spin_lock(&ubd_lock);
+ 	mutex_lock(&ubd_lock);
 	err = ubd_add(n);
 	if(err)
 		ubd_devs[n].file = NULL;
- 	spin_unlock(&ubd_lock);
+ 	mutex_unlock(&ubd_lock);
 
 	return(err);
 }
@@ -737,7 +738,7 @@ static int ubd_get_config(char *name, ch
 	}
 
 	ubd_dev = &ubd_devs[n];
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	if(ubd_dev->file == NULL){
 		CONFIG_CHUNK(str, size, len, "", 1);
@@ -753,7 +754,7 @@ static int ubd_get_config(char *name, ch
 	else CONFIG_CHUNK(str, size, len, "", 1);
 
  out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return(len);
 }
 
@@ -772,7 +773,7 @@ static int ubd_remove(int n)
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	if(ubd_gendisk[n] == NULL)
 		goto out;
@@ -801,7 +802,7 @@ static int ubd_remove(int n)
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
 out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return err;
 }
 
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
