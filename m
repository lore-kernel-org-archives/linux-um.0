Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9vPT-0000QJ-0J
 for linux-um@lists.infradead.org; Thu, 05 Mar 2020 18:39:52 +0000
Received: by mail-pf1-x44a.google.com with SMTP id f193so4202183pfa.22
 for <linux-um@lists.infradead.org>; Thu, 05 Mar 2020 10:39:46 -0800 (PST)
Date: Thu,  5 Mar 2020 10:39:39 -0800
Message-Id: <20200305183939.256241-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] um: Fix overlapping ELF segments when statically linked
From: David Gow <davidgow@google.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, brendanhiggins@google.com, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>, trishalfonso@google.com

When statically linked, the .text section in UML kernels is not page
aligned, causing it to share a page with the executable headers. As
.text and the executable headers have different permissions, this causes
the kernel to wish to map the same page twice (once as headers with r--
permissions, once as .text with r-x permissions), causing a segfault,
and a nasty message printed to the host kernel's dmesg:

"Uhuuh, elf segment at 0000000060000000 requested but the memory is
mapped already"

By aligning the .text to a page boundary (as in the dynamically linked
version in dyn.lds.S), there is no such overlap, and the kernel runs
correctly.

Signed-off-by: David Gow <davidgow@google.com>
---
I'm not 100% sure what triggered this -- possibly a change to the host
kernel on my machine -- as I'm able to reproduce the issue as far back
as in 4.4, but it seems to be reproducible easily on my machine with
defconfig + CONFIG_STATIC_LINK=y.


 arch/um/kernel/uml.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 9f21443be2c9..3b6dab3d4501 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -19,10 +19,10 @@ SECTIONS
   __binary_start = START;
 
   . = START + SIZEOF_HEADERS;
+  . = ALIGN(PAGE_SIZE);
 
   _text = .;
   INIT_TEXT_SECTION(0)
-  . = ALIGN(PAGE_SIZE);
 
   .text      :
   {
-- 
2.25.0.265.gbab2e86ba0-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

