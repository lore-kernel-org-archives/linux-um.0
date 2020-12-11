Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUt-0008IV-40
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:27 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 6/7] um: swithch futex ops to cmpxchg
Date: Fri, 11 Dec 2020 17:45:58 +0000
Message-Id: <20201211174559.26010-7-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
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

As a result of switching from emulated to true atomic cmpxchg
we can use cmpxchg in the corresponding um futex op.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/skas/uaccess.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index de71048b5371..858b2e16e364 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -343,7 +343,6 @@ EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
  * -EAGAIN - Atomic operation was unable to complete due to contention
  * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
  */
-
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
 {
@@ -366,8 +365,7 @@ int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	val = *uaddr;
 
-	if (val == oldval)
-		*uaddr = newval;
+	ret = cmpxchg(uaddr, oldval, newval);
 
 	*uval = val;
 	pagefault_enable();
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

