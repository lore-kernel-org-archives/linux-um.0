Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJO-VM
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:07 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 09/27] um: Do not use printk in userspace trampoline
Date: Wed,  3 Mar 2021 16:55:05 +0100
Message-Id: <20210303155523.124277-10-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

The trampoline is running in a cloned process. It is not safe to use
printk for error printing there.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1c31f833a7ed..15818009731d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -220,8 +220,8 @@ static int userspace_tramp(void *stack)
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, errno = %d\n",
-		       STUB_CODE, errno);
+		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
+			STUB_CODE, errno);
 		exit(1);
 	}
 
@@ -230,8 +230,8 @@ static int userspace_tramp(void *stack)
 		    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 		    MAP_FIXED | MAP_SHARED, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-		       STUB_DATA, errno);
+		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
+			STUB_DATA, errno);
 		exit(1);
 	}
 
@@ -241,8 +241,8 @@ static int userspace_tramp(void *stack)
 	sa.sa_sigaction = (void *) segv_handler;
 	sa.sa_restorer = NULL;
 	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-		printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
-		       __func__, errno);
+		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
+			__func__, errno);
 		exit(1);
 	}
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

