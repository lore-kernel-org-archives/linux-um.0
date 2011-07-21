Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPD-0000mN-G1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:55 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP9-0001Aj-CA
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:55 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:31 +0200
Message-Id: <1311239914-8301-7-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 07/10] um: Set __HAVE_ARCH_GATE_AREA for x86_64
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Implement arch_vma_name() and make get_gate_vma(),
in_gate_area() and in_gate_area_no_mm() a nop.

We need arch_vma_name() to support vDSO.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/sys-x86_64/asm/elf.h |    1 +
 arch/um/sys-x86_64/mem.c     |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/um/sys-x86_64/asm/elf.h b/arch/um/sys-x86_64/asm/elf.h
index d6d5af3..74eb0ac 100644
--- a/arch/um/sys-x86_64/asm/elf.h
+++ b/arch/um/sys-x86_64/asm/elf.h
@@ -119,4 +119,5 @@ extern long elf_aux_hwcap;
 
 #define SET_PERSONALITY(ex) do ; while(0)
 
+#define __HAVE_ARCH_GATE_AREA 1
 #endif
diff --git a/arch/um/sys-x86_64/mem.c b/arch/um/sys-x86_64/mem.c
index 3f8df8a..055cea0 100644
--- a/arch/um/sys-x86_64/mem.c
+++ b/arch/um/sys-x86_64/mem.c
@@ -14,3 +14,25 @@ unsigned long vm_data_default_flags = __VM_DATA_DEFAULT_FLAGS;
 unsigned long vm_data_default_flags32 = __VM_DATA_DEFAULT_FLAGS;
 unsigned long vm_force_exec32 = PROT_EXEC;
 
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == um_vdso_addr)
+		return "[vdso]";
+
+	return NULL;
+}
+
+struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
+
+int in_gate_area(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+int in_gate_area_no_mm(unsigned long addr)
+{
+	return 0;
+}
-- 
1.7.6


------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

