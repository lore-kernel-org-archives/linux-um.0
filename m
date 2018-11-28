Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gS5fP-0003lN-7P
 for linux-um@lists.infradead.org; Wed, 28 Nov 2018 19:38:36 +0000
Received: by mail-qt1-x849.google.com with SMTP id j5so24617324qtk.11
 for <linux-um@lists.infradead.org>; Wed, 28 Nov 2018 11:38:23 -0800 (PST)
Date: Wed, 28 Nov 2018 11:36:33 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
Subject: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
From: Brendan Higgins <brendanhiggins@google.com>
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
To: gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, jdike@addtoit.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, robh@kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, khilman@baylibre.com, Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com

Make UML unflatten any present device trees when running KUnit tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/kernel/um_arch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca2..bd58ae3bf4148 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
+#include <linux/of_fdt.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
 	read_initrd();
 
 	paging_init();
+#if IS_ENABLED(CONFIG_OF_UNITTEST)
+	unflatten_device_tree();
+#endif
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

