Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1753588Ab0ADUUj@vger.kernel.org>
Date: Mon, 4 Jan 2010 15:08:29 -0500 (EST)
From: Tim Abbott <tabbott@ksplice.com>
Subject: [REGRESSION] um: CONFIG_STATIC_LINK=y broken
Message-ID: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org, richard -rw- weinberger <richard.weinberger@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

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
Reported-by: richard -rw- weinberger <richard.weinberger@gmail.com>
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
