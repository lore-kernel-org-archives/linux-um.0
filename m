Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1348600314-32423-1-git-send-email-geert@linux-m68k.org>
References: <1348600314-32423-1-git-send-email-geert@linux-m68k.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Sep 2012 12:20:55 -0700
Message-ID: <CA+55aFzi+eTH3ZP=J=EJdaPME_q+bV1LD1DKB-6hg1OpM_zELQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [PATCH/resend/bypass] um: Preinclude include/linux/kern_levels.h
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Joe Perches <joe@perches.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 25, 2012 at 12:11 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> To fix this:
>   - Move the mapping from UM_KERN_<LEVEL> to KERN_<LEVEL> from
>     arch/um/include/shared/common-offsets.h to
>     arch/um/include/shared/user.h, which is preincluded for all userspace
>     parts,
>   - Preinclude include/linux/kern_levels.h for all userspace parts, to
>     obtain the in-kernel KERN_<LEVEL> constant definitions. This doesn't
>     violate the kernel/userspace separation, as include/linux/kern_levels.h
>     is self-contained and doesn't expose any other kernel internals.
>   - Remove the now unused STR() and DEFINE_STR() macros.

Ugh.

Why do you preinclude kern_levels.h instead of just having a
"#include" in user.h?

IOW, this part of the patch:

-       c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include user.h
$(CFLAGS_$(basetarget).o)
+       c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include
$(srctree)/include/linux/kern_levels.h -include user.h
$(CFLAGS_$(basetarget).o)

just makes me go want to puke. The user.h file already has other
#include's in it, so I really don't see why you create this insane
special case.

And why does UM have those "UM_KERN_XYZ" defines in the first place?
Why isn't it just using KERN_XYZ directly? Is it because kern_levels.h
didn't use to exist, so it was some kind of "let's create our own that
we can hide in our special headers".

IOW, I really thinks this patch makes things uglier. At the very least
it could be done more prettily, but preferably we'd get rid of the odd
and useless UM_ prefix from these things entirely.

             Linus

