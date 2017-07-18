Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Correctly check for PTRACE_GETRESET/SETREGSET
References: <20170706073527.12006-1-richard@nod.at>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <32e2ec7f-3a3b-c53c-6bba-66ead72b0e78@gmail.com>
Date: Tue, 18 Jul 2017 15:46:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170706073527.12006-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 07/06/2017 12:35 AM, Richard Weinberger wrote:
> When checking for PTRACE_GETRESET/SETREGSET, make sure that
> the correct header file is included. We need linux/ptrace.h
> which contains all ptrace UAPI related defines.
> Otherwise #if defined(PTRACE_GETRESET) is always false.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Ah ah, I see what happened now, because of this invalid include, I was
indeed getting PTRACE_GETREGSET not to be defined, which happened to
solve the build failure I was seeing against 2.6.32. Your fix is
correct, but we actually need a better way to determine whether struct
_xstate is defined or not.

Now that we have this change in place, I can hit the following build
failure (again):

arch/x86/um/user-offsets.c: In function 'foo':
arch/x86/um/user-offsets.c:54: error: invalid application of 'sizeof' to
incomplete type 'struct _xstate'

This is because we have included signal.h which includes
bits/sigcontext.h which does not have a _xstate structure definition.

A possible fix would be:

diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index ae4cd58c0c7a..02250b2633b8 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -50,7 +50,7 @@ void foo(void)
        DEFINE(HOST_GS, GS);
        DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
-#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
+#ifdef FP_XSTATE_MAGIC1
        DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned
long));
 #else
        DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned
long));

I incorrectly linked PTRACE_GETREGSET and PTRACE_SETREGSET with the
introduce of the _xstate...


> ---
>  arch/x86/um/user-offsets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index 8af0fb5d2780..ae4cd58c0c7a 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -5,7 +5,7 @@
>  #include <sys/mman.h>
>  #include <sys/user.h>
>  #define __FRAME_OFFSETS
> -#include <asm/ptrace.h>
> +#include <linux/ptrace.h>
>  #include <asm/types.h>
>  
>  #ifdef __i386__
> 


-- 
Florian

