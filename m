Return-Path: <linux-mips-bounce@linux-mips.org>
Message-ID: <4DE81786.60702@redhat.com>
Date: Thu, 02 Jun 2011 19:06:46 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com> <201106030032.17398.richard@nod.at>
In-Reply-To: <201106030032.17398.richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk, oleg@redhat.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/02/2011 06:32 PM, Richard Weinberger wrote:
> Am Donnerstag 02 Juni 2011, 23:04:58 schrieb Eric Paris:
>> b/arch/um/sys-i386/shared/sysdep/ptrace.h index d50e62e..ef5c310 100=
644
>> --- a/arch/um/sys-i386/shared/sysdep/ptrace.h
>> +++ b/arch/um/sys-i386/shared/sysdep/ptrace.h
>> @@ -162,6 +162,7 @@ struct syscall_args {
>>  #define UPT_ORIG_SYSCALL(r) UPT_EAX(r)
>>  #define UPT_SYSCALL_NR(r) UPT_ORIG_EAX(r)
>>  #define UPT_SYSCALL_RET(r) UPT_EAX(r)
>> +#define regs_return_value UPT_SYSCALL_RET
>=20
> This does not work at all.
> UPT_SYSCALL_RET expects something of type struct uml_pt_regs.
>=20
> #define regs_return_value REGS_EAX
> Would be correct. (For x86_64 it needs to be REGS_RAX)
>=20
> But there seems to be another problem.
> Why is pt_regs of type void *?

I was stupid and used #define's instead of static inlines.  Sorry.  I
wonder how many other arches I got that wrong, i'm sure others....

The code in arch/um/kernel/ptrace.c::syscall_trace() appeared to have a
uml_pt_regs instead of just pt_regs.  Which was why audit_syscall_exit(=
)
takes a void * instead of a pt_regs.  We pass that right back to
regs_return_value().  I believe the correct code should be:

static inline long regs_return_value(struct uml_pt_regs *r)
{
	return UPT_SYSCALL_RET(r);
}


>=20
> gcc complains:
> In file included from include/linux/fsnotify.h:15:0,
>                  from include/linux/security.h:26,
>                  from init/main.c:32:
> include/linux/audit.h: In function =E2=80=98audit_syscall_exit=E2=80=99=
:
> include/linux/audit.h:440:17: warning: dereferencing =E2=80=98void *=E2=
=80=99 pointer
> include/linux/audit.h:440:3: error: invalid use of void expression
> include/linux/audit.h:441:21: warning: dereferencing =E2=80=98void *=E2=
=80=99 pointer
> include/linux/audit.h:441:21: error: void value not ignored as it oug=
ht to be
>=20
> Thanks,
> //richard



