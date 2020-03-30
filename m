Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIvjV-0005B2-Sw
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 14:49:47 +0000
Received: by mail-pj1-x1044.google.com with SMTP id fh8so2570152pjb.5
 for <linux-um@lists.infradead.org>; Mon, 30 Mar 2020 07:49:45 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 25/25] um: fix clone flags to be familiar with valgrind
Date: Mon, 30 Mar 2020 23:45:57 +0900
Message-Id: <59ed4e23efa7abc9c7d52e6b5fb31fb8ce795c5c.1585579244.git.thehajime@gmail.com>
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

Valgrind reports the following error with UML when ubd driver is
compiled in.

==29588== Unsupported clone() flags: 0x500
==29588==
==29588== The only supported clone() uses are:
==29588==  - via a threads library (LinuxThreads or NPTL)
==29588==  - via the implementation of fork or vfork

Adding CLONE_FS flags silences this issue.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/ubd_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..fabb50e91c37 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -47,7 +47,8 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}
 
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
+	pid = clone(io_thread, (void *) sp,
+		    CLONE_FILES | CLONE_VM | CLONE_FS, NULL);
 	if(pid < 0){
 		err = -errno;
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

