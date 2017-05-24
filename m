Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Allow building and running on older hosts
References: <20170524010858.16134-1-f.fainelli@gmail.com>
 <d2f4abc4-3d79-45e8-661a-25a244c836e4@nod.at>
 <2A62A3A3-13BD-48D2-B210-98B45B7F7666@m3y3r.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4edbef95-ee69-9c87-a3db-33b1669308e3@gmail.com>
Date: Wed, 24 May 2017 09:27:06 -0700
MIME-Version: 1.0
In-Reply-To: <2A62A3A3-13BD-48D2-B210-98B45B7F7666@m3y3r.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>, Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, elicooper@gmx.com, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/24/2017 02:03 AM, Thomas Meyer wrote:
> 
>> Am 24.05.2017 um 09:01 schrieb Richard Weinberger <richard@nod.at>:
>>
>> CC'ing Thomas. We is also facing issues with these commits.
>>
>>> Am 24.05.2017 um 03:08 schrieb Florian Fainelli:
>>> Commit a78ff1112263 ("um: add extended processor state save/restore
>>> support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
>>> YMM registers") forced the use of the x86 FP _xstate and
>>> PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
>>> build UML nor run it anymore with these two commits applied because we
>>> don't have definitions for struct _xstate nor these two ptrace requests.
>>>
>>> We can determine at build time which fp context structure to check
>>> against, just like we can keep using the old i387 fp save/restore if
>>> PTRACE_GETRESET/SETREGSET are not defined.
>>>
>>> Fixes: a78ff1112263 ("um: add extended processor state save/restore support")
>>> Fixes: b6024b21fec8 ("um: extend fpstate to _xstate to support YMM registers")
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>> arch/x86/um/os-Linux/registers.c | 13 +++++++++----
>>> arch/x86/um/user-offsets.c       |  4 ++++
>>> 2 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
>>> index 00f54a91bb4b..502bd642e5c2 100644
>>> --- a/arch/x86/um/os-Linux/registers.c
>>> +++ b/arch/x86/um/os-Linux/registers.c
>>> @@ -26,13 +26,14 @@ int save_i387_registers(int pid, unsigned long *fp_regs)
>>>
>>> int save_fp_registers(int pid, unsigned long *fp_regs)
>>> {
>>> -    struct iovec iov;
>>> -
>>>    if (have_xstate_support) {
>>> +#ifdef PTRACE_GETREGSET
>>> +        struct iovec iov;
> 
> Is this okay, in C90? Won't this give an error once the thing is defined?

I did not get such a warning to be generated, but arguably I am using a
fairly hold host/compiler (GCC 4.4) let me try on something newer as well.

> 
>>>        iov.iov_base = fp_regs;
>>>        iov.iov_len = sizeof(struct _xstate);
>>>        if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>>>            return -errno;
>>> +#endif
>>>        return 0;
>>>    } else {
>>>        return save_i387_registers(pid, fp_regs);
>>> @@ -48,13 +49,15 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
>>>
>>> int restore_fp_registers(int pid, unsigned long *fp_regs)
>>> {
>>> -    struct iovec iov;
>>> -
>>>    if (have_xstate_support) {
>>> +#ifdef PTRACE_SETREGSET
>>> +        struct iovec iov;
>>> +
>>>        iov.iov_base = fp_regs;
>>>        iov.iov_len = sizeof(struct _xstate);
>>>        if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>>>            return -errno;
>>> +#endif
>>>        return 0;
>>>    } else {
>>>        return restore_i387_registers(pid, fp_regs);
>>> @@ -127,8 +130,10 @@ void arch_init_registers(int pid)
>>>
>>>    iov.iov_base = &fp_regs;
>>>    iov.iov_len = sizeof(struct _xstate);
>>> +#ifdef PTRACE_GETREGSET
>>>    if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
>>>        have_xstate_support = 1;
> 
> So why keep have_xstate_support when all branches that test for it are now pre compiler conditionals?

To minimize the amount of lines needed to account for lack of
PTRACE_SETREGSET/GETREGSET, and to keep the if(0) else() semi-explicit here.

Would you prefer that instead:

diff --git a/arch/x86/um/os-Linux/registers.c
b/arch/x86/um/os-Linux/registers.c
index 00f54a91bb4b..b342bbfbb8d2 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -26,6 +26,7 @@ int save_i387_registers(int pid, unsigned long *fp_regs)

 int save_fp_registers(int pid, unsigned long *fp_regs)
 {
+#ifdef PTRACE_GETREGSET
        struct iovec iov;

        if (have_xstate_support) {
@@ -34,9 +35,9 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
                if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
                        return -errno;
                return 0;
-       } else {
+       } else
+#endif
                return save_i387_registers(pid, fp_regs);
-       }
 }

 int restore_i387_registers(int pid, unsigned long *fp_regs)
@@ -48,6 +49,7 @@ int restore_i387_registers(int pid, unsigned long
*fp_regs)

 int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
+#ifdef PTRACE_SETREGSET
        struct iovec iov;

        if (have_xstate_support) {
@@ -56,9 +58,9 @@ int restore_fp_registers(int pid, unsigned long *fp_regs)
                if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
                        return -errno;
                return 0;
-       } else {
+       } else
+#endif
                return restore_i387_registers(pid, fp_regs);
-       }
 }

 #ifdef __i386__

> 
>>> +#endif
>>> }
>>> #endif
>>>
>>> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
>>> index cb3c22370cf5..8af0fb5d2780 100644
>>> --- a/arch/x86/um/user-offsets.c
>>> +++ b/arch/x86/um/user-offsets.c
>>> @@ -50,7 +50,11 @@ void foo(void)
>>>    DEFINE(HOST_GS, GS);
>>>    DEFINE(HOST_ORIG_AX, ORIG_EAX);
>>> #else
>>> +#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
>>>    DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
>>> +#else
>>> +    DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
>>> +#endif
>>>    DEFINE_LONGS(HOST_BX, RBX);
>>>    DEFINE_LONGS(HOST_CX, RCX);
>>>    DEFINE_LONGS(HOST_DI, RDI);
>>>


-- 
Florian

