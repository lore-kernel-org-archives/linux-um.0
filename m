Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kznNH-0000fo-In
 for linux-um@lists.infradead.org; Wed, 13 Jan 2021 21:08:16 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] um: mm: check more comprehensively for stub changes
Date: Wed, 13 Jan 2021 22:08:02 +0100
Message-Id: <20210113220803.0d97c6c96aae.I91e62e7568b2834a3922202a05700c972deaca3f@changeid>
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
Cc: stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

If userspace tries to change the stub, we need to kill it,
because otherwise it can escape the virtual machine. In a
few cases the stub checks weren't good, e.g. if userspace
just tries to

	mmap(0x100000 - 0x1000, 0x3000, ...)

it could succeed to get a new private/anonymous mapping
replacing the stubs. Fix this by checking everywhere, and
checking for _overlap_, not just direct changes.

Cc: stable@vger.kernel.org
Fixes: 3963333fe676 ("uml: cover stubs with a VMA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/tlb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 61776790cd67..89468da6bf88 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -125,6 +125,9 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	struct host_vm_op *last;
 	int fd = -1, ret = 0;
 
+	if (virt + len > STUB_START && virt < STUB_END)
+		return -EINVAL;
+
 	if (hvc->userspace)
 		fd = phys_mapping(phys, &offset);
 	else
@@ -162,7 +165,7 @@ static int add_munmap(unsigned long addr, unsigned long len,
 	struct host_vm_op *last;
 	int ret = 0;
 
-	if ((addr >= STUB_START) && (addr < STUB_END))
+	if (addr + len > STUB_START && addr < STUB_END)
 		return -EINVAL;
 
 	if (hvc->index != 0) {
@@ -192,6 +195,9 @@ static int add_mprotect(unsigned long addr, unsigned long len,
 	struct host_vm_op *last;
 	int ret = 0;
 
+	if (addr + len > STUB_START && addr < STUB_END)
+		return -EINVAL;
+
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
 		if ((last->type == MPROTECT) &&
@@ -472,6 +478,10 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	struct mm_id *mm_id;
 
 	address &= PAGE_MASK;
+
+	if (address >= STUB_START && address < STUB_END)
+		goto kill;
+
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
 		goto kill;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

