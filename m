Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [REGRESSION][RESEND v2] um: CONFIG_STATIC_LINK=y broken
Date: Sun, 17 Oct 2010 20:00:21 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201010172000.21752.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Tim Abbott <tabbott@ksplice.com>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Andrew,

Please apply this patch.

--
Hi Linus,

The following patch fixes a regression that I caused in 2.6.32 when 
cleaning up the um architecture's linker scripts.

I've not heard anything from the um maintainers (they have had since 
Richard Weinberger reported that this patch fixed the problem on December 
22), so I'm sending this to you now (and CCing stable@ since it affects 
2.6.32).

        -Tim Abbott

--

um: remove PAGE_SIZE alignment in linker script causing kernel segfault.

The linker script cleanup that I did in commit 
5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 accidentally introduced an 
ALIGN(PAGE_SIZE) when converting to use INIT_TEXT_SECTION; Richard 
Weinberger reported that this causes the kernel to segfault with 
CONFIG_STATIC_LINK=y.

I'm not certain why this extra alignment is a problem, but it seems likely 
it is because previously

__init_begin = _stext = _text = _sinittext 

and with the extra ALIGN(PAGE_SIZE), _sinittext becomes different from the 
rest.  So there is likely a bug here where something is assuming that 
_sinittext is the same as one of those other symbols.  But reverting the 
accidental change fixes the regression, so it seems worth committing that 
now.

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Reported-by: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/uml.lds.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index e7a6cca..664f942 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -22,7 +22,7 @@ SECTIONS
   _text = .;
   _stext = .;
   __init_begin = .;
-  INIT_TEXT_SECTION(PAGE_SIZE)
+  INIT_TEXT_SECTION(0)
   . = ALIGN(PAGE_SIZE);
 
   .text      :
-- 
1.6.5.7

-- 
Thanks,
//richard

