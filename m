Return-Path: <viro@ftp.linux.org.uk>
Date: Tue, 25 Sep 2012 20:43:56 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120925194356.GP13973@ZenIV.linux.org.uk>
References: <1348600314-32423-1-git-send-email-geert@linux-m68k.org>
 <CA+55aFzi+eTH3ZP=J=EJdaPME_q+bV1LD1DKB-6hg1OpM_zELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzi+eTH3ZP=J=EJdaPME_q+bV1LD1DKB-6hg1OpM_zELQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH/resend/bypass] um: Preinclude include/linux/kern_levels.h
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Joe Perches <joe@perches.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 25, 2012 at 12:20:55PM -0700, Linus Torvalds wrote:
> IOW, this part of the patch:
> 
> -       c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include user.h
> $(CFLAGS_$(basetarget).o)
> +       c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include
> $(srctree)/include/linux/kern_levels.h -include user.h
> $(CFLAGS_$(basetarget).o)
> 
> just makes me go want to puke. The user.h file already has other
> #include's in it, so I really don't see why you create this insane
> special case.
> 
> And why does UM have those "UM_KERN_XYZ" defines in the first place?
> Why isn't it just using KERN_XYZ directly? Is it because kern_levels.h
> didn't use to exist, so it was some kind of "let's create our own that
> we can hide in our special headers".

Because user.h is included *without* kernel headers in include path.
It's for the stuff that is compiled with host libc headers.  Keep in
mind that UML talks to libc like normal architecture would talk to
hardware.  IOW, analogs of asm glue are in (host) userland C.  And
they need libc headers instead of the kernel ones.  That's what that
USER_OBJ thing is about.  Kernel-side constants, etc. are delivered
to that sucker using the same mechanism we normally use to give them
to assembler - asm-offsets.c.  And here, of course, slapping ifndef
__ASSEMBLER__ around the tricky bits will not work - the header itself
is just fine, but getting kernel headers in the search path really
isn't.

	I agree that proposed solution is ugly.  What we can do is copy
the damn header into include/generated and #include <generated/kern_levels.h>
from user.h.  And kill UM_KERN_... stuff.  Objections?

