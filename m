Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt8fX-004dCu-IM
 for linux-um@lists.infradead.org; Mon, 23 May 2022 14:04:25 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] um: Fix out-of-bounds read in LDT setup
Date: Mon, 23 May 2022 16:04:03 +0200
Message-ID: <20220523140403.2361040-1-vincent.whitchurch@axis.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: kernel@axis.com, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>

syscall_stub_data() expects the data_count parameter to be the number of
longs, not bytes.

 ==================================================================
 BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x70/0xe0
 Read of size 128 at addr 000000006411f6f0 by task swapper/1

 CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0+ #18
 Call Trace:
  show_stack.cold+0x166/0x2a7
  __dump_stack+0x3a/0x43
  dump_stack_lvl+0x1f/0x27
  print_report.cold+0xdb/0xf81
  kasan_report+0x119/0x1f0
  kasan_check_range+0x3a3/0x440
  memcpy+0x52/0x140
  syscall_stub_data+0x70/0xe0
  write_ldt_entry+0xac/0x190
  init_new_ldt+0x515/0x960
  init_new_context+0x2c4/0x4d0
  mm_init.constprop.0+0x5ed/0x760
  mm_alloc+0x118/0x170
  0x60033f48
  do_one_initcall+0x1d7/0x860
  0x60003e7b
  kernel_init+0x6e/0x3d4
  new_thread_handler+0x1e7/0x2c0

 The buggy address belongs to stack of task swapper/1
  and is located at offset 64 in frame:
  init_new_ldt+0x0/0x960

 This frame has 2 objects:
  [32, 40) 'addr'
  [64, 80) 'desc'
 ==================================================================

Fixes: 858259cf7d1c443c83 ("uml: maintain own LDT entries")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/x86/um/ldt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 3ee234b6234d..255a44dd415a 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -23,9 +23,11 @@ static long write_ldt_entry(struct mm_id *mm_idp, int func,
 {
 	long res;
 	void *stub_addr;
+
+	BUILD_BUG_ON(sizeof(*desc) % sizeof(long));
+
 	res = syscall_stub_data(mm_idp, (unsigned long *)desc,
-				(sizeof(*desc) + sizeof(long) - 1) &
-				    ~(sizeof(long) - 1),
+				sizeof(*desc) / sizeof(long),
 				addr, &stub_addr);
 	if (!res) {
 		unsigned long args[] = { func,
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

