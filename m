Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5Tl-Lv
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:38 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 5/6] um: fix CONFIG_GCOV for built-in code
Date: Fri, 12 Mar 2021 10:55:25 +0100
Message-Id: <20210312104627.9355049045fe.Ie4896d26d2a4e1116c760cdb91087a1817807ca6@changeid>
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

With contemporary toolchains, CONFIG_GCOV doesn't work because
gcov now relies on both init and exit handlers, but those are
discarded from the binary. Fix the linker scripts to keep them
instead, so that CONFIG_GCOV can work again.

Note that this does not make it work in modules yet, since we
don't call their exit handlers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/common.lds.S | 2 ++
 arch/um/kernel/vmlinux.lds.S     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41b..1223dcaaf7e3 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -84,11 +84,13 @@
   .init_array : {
 	__init_array_start = .;
 	*(.init_array)
+	*(.init_array.*)
 	__init_array_end = .;
   }
   .fini_array : {
 	__fini_array_start = .;
 	*(.fini_array)
+	*(.fini_array.*)
 	__fini_array_end = .;
   }
 
diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 16e49bfa2b42..2245ae4907d2 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,6 +1,8 @@
 
 KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
 
+#define RUNTIME_DISCARD_EXIT
+
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

