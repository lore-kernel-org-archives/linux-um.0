Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNL-LP
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:05 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeR-QS
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 06/15] um: kill unused cpu()
Date: Mon, 20 Sep 2021 21:32:52 +0000
Message-Id: <20210920213301.1424730-6-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/kern_util.h | 1 -
 arch/um/kernel/process.c           | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index a2cfd42608a0c..fbfff76065c5b 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -53,7 +53,6 @@ extern void do_uml_exitcalls(void);
 extern int __cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
-extern int cpu(void);
 extern char *uml_strdup(const char *string);
 
 extern unsigned long to_irq_stack(unsigned long *mask_out);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index a5a430c637ba1..d5079a35e48ae 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -264,11 +264,6 @@ int clear_user_proc(void __user *buf, int size)
 	return clear_user(buf, size);
 }
 
-int cpu(void)
-{
-	return current_thread_info()->cpu;
-}
-
 static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

