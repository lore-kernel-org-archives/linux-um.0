Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosNK-0006Mx-7b
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 18:15:11 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v5 3/4] um: add a UML specific futex implementation
Date: Mon, 14 Dec 2020 18:14:58 +0000
Message-Id: <20201214181459.11096-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
References: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
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

The generic asm futex implementation emulates atomic access to
memory by doing a get_user followed by put_user. These translate
to two mapping operations on UML with paging enabled in the
meantime. This, in turn may end up changing interrupts,
invoking the signal loop, etc.

This replaces the generic implementation by a mapping followed
by an operation on the mapped segment.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/Kbuild    |   1 -
 arch/um/include/asm/futex.h   |  14 ++++
 arch/um/kernel/skas/uaccess.c | 130 ++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/futex.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1c63b260ecc4..873e6815bc50 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -8,7 +8,6 @@ generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += ftrace.h
-generic-y += futex.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
new file mode 100644
index 000000000000..0a01f1f60de0
--- /dev/null
+++ b/arch/um/include/asm/futex.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_FUTEX_H
+#define _ASM_GENERIC_FUTEX_H
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+
+
+extern int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
+extern int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval);
+
+#endif
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 2dec915abe6f..85022e91bf53 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -11,6 +11,7 @@
 #include <asm/current.h>
 #include <asm/page.h>
 #include <kern_util.h>
+#include <asm/futex.h>
 #include <os.h>
 
 pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
@@ -248,3 +249,132 @@ long __strnlen_user(const void __user *str, long len)
 	return 0;
 }
 EXPORT_SYMBOL(__strnlen_user);
+
+/**
+ * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
+ *			  argument and comparison of the previous
+ *			  futex value with another constant.
+ *
+ * @encoded_op:	encoded operation to execute
+ * @uaddr:	pointer to user space address
+ *
+ * Return:
+ * 0 - On success
+ * -EFAULT - User access resulted in a page fault
+ * -EAGAIN - Atomic operation was unable to complete due to contention
+ * -ENOSYS - Operation not supported
+ */
+
+int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval, ret;
+	struct page *page;
+	unsigned long addr = (unsigned long) uaddr;
+	pte_t *pte;
+
+	ret = -EFAULT;
+	if (!access_ok(uaddr, sizeof(*uaddr)))
+		return -EFAULT;
+	preempt_disable();
+	pte = maybe_map(addr, 1);
+	if (pte == NULL)
+		goto out_inuser;
+
+	page = pte_page(*pte);
+#ifdef CONFIG_64BIT
+	pagefault_disable();
+	addr = (unsigned long) page_address(page) +
+			(((unsigned long) addr) & ~PAGE_MASK);
+#else
+	addr = (unsigned long) kmap_atomic(page) +
+		((unsigned long) addr & ~PAGE_MASK);
+#endif
+	uaddr = (u32 *) addr;
+	oldval = *uaddr;
+
+	ret = 0;
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		*uaddr = oparg;
+		break;
+	case FUTEX_OP_ADD:
+		*uaddr += oparg;
+		break;
+	case FUTEX_OP_OR:
+		*uaddr |= oparg;
+		break;
+	case FUTEX_OP_ANDN:
+		*uaddr &= ~oparg;
+		break;
+	case FUTEX_OP_XOR:
+		*uaddr ^= oparg;
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+#ifdef CONFIG_64BIT
+	pagefault_enable();
+#else
+	kunmap_atomic((void *)addr);
+#endif
+
+out_inuser:
+	preempt_enable();
+
+	if (ret == 0)
+		*oval = oldval;
+
+	return ret;
+}
+EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
+
+/**
+ * futex_atomic_cmpxchg_inatomic() - Compare and exchange the content of the
+ *				uaddr with newval if the current value is
+ *				oldval.
+ * @uval:	pointer to store content of @uaddr
+ * @uaddr:	pointer to user space address
+ * @oldval:	old value
+ * @newval:	new value to store to @uaddr
+ *
+ * Return:
+ * 0 - On success
+ * -EFAULT - User access resulted in a page fault
+ * -EAGAIN - Atomic operation was unable to complete due to contention
+ * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
+ */
+
+int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	u32 val;
+	struct page *page;
+	pte_t *pte;
+	int ret = -EFAULT;
+
+	if (!access_ok(uaddr, sizeof(*uaddr)))
+		return -EFAULT;
+
+	preempt_disable();
+	pte = maybe_map((unsigned long) uaddr, 1);
+	if (pte == NULL)
+		goto out_inatomic;
+
+	page = pte_page(*pte);
+	pagefault_disable();
+	uaddr = page_address(page) + (((unsigned long) uaddr) & ~PAGE_MASK);
+
+	val = *uaddr;
+
+	ret = cmpxchg(uaddr, oldval, newval);
+
+	*uval = val;
+	pagefault_enable();
+	ret = 0;
+
+out_inatomic:
+	preempt_enable();
+	return ret;
+}
+EXPORT_SYMBOL(futex_atomic_cmpxchg_inatomic);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

