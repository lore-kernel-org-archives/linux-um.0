Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwABO-0003uU-89
 for linux-um@lists.infradead.org; Mon, 27 Jan 2020 19:36:27 +0000
Received: by mail-pl1-x64a.google.com with SMTP id bd7so4308768plb.0
 for <linux-um@lists.infradead.org>; Mon, 27 Jan 2020 11:36:24 -0800 (PST)
Date: Mon, 27 Jan 2020 11:35:49 -0800
In-Reply-To: <20200127193549.187419-1-brendanhiggins@google.com>
Message-Id: <20200127193549.187419-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
Subject: [RFC v1 2/2] arch: um: turn BTF_TYPEINFO support off
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org, changbin.du@intel.com, yamada.masahiro@socionext.com, rdunlap@infradead.org, keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc: Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, heidifahim@google.com

Currently CONFIG_DEBUG_INFO_BTF=y doesn't work on UML:

scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
objcopy: --change-section-vma .BTF=0x0000000000000000 never used
objcopy: --change-section-lma .BTF=0x0000000000000000 never used
objcopy: error: the input file '.btf.vmlinux.bin' is empty
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
make: *** [Makefile:1078: vmlinux] Error 1

So turn off ARCH_HAS_BTF_TYPEINFO support off for the UM architecture.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0917f8443c285..53e13d8b210e0 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_HAS_KCOV
+	select ARCH_NO_BTF_TYPEINFO
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

