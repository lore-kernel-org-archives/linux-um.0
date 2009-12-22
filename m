Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752505AbZLVCN7@vger.kernel.org>
Date: Mon, 21 Dec 2009 21:13:18 -0500 (EST)
From: Tim Abbott <tabbott@ksplice.com>
Subject: Re: [REGRESSION] um: CONFIG_STATIC_LINK=y broken
In-Reply-To: <2b41c200912211710m11f1ebbbjc3d30c67e9e49944@mail.gmail.com>
Message-ID: <alpine.DEB.1.10.0912212020450.19919@dr-wily.mit.edu>
References: <2b41c200912211621p72eceed5tb9f9711b2f96b72e@mail.gmail.com>  <alpine.DEB.1.10.0912211926100.19919@dr-wily.mit.edu>  <2b41c200912211639p30927d84k9253ac7c90ac0e68@mail.gmail.com>  <alpine.DEB.1.10.0912211944050.19919@dr-wily.mit.edu>
 <2b41c200912211710m11f1ebbbjc3d30c67e9e49944@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 22 Dec 2009, richard -rw- weinberger wrote:

> Adding the ALIGN(PAGE_SIZE) causes the segfault.
> But I cannot tell you why. :-(

OK, then the following patch should fix the regression by reverting that 
unintentional change.

Someone should probably determine why the ALIGN causes a segfault, since 
that is probably a bug, but I don't have time to do that investigation.

Richard, can you test that this patch fixes the issue for you?

(adding the UML maintainer and list to the thread).

	-Tim Abbott

um: remove PAGE_SIZE alignment in linker script causing kernel segfault.

The linker script cleanup that I did in commit 
5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 introduced an ALIGN(PAGE_SIZE) 
when using INIT_TEXT_SECTION; this apparently causes the kernel to 
segfault with CONFIG_STATIC_LINK=y. 

I'm not certain why this would cause the kernel to segfault, but it seems 
likely it is because previously it was the case that

__init_begin = _stext = _text = _sinittext 

and with the extra ALIGN(PAGE_SIZE), _sinittext becomes different.

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
