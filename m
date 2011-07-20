Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201107202009.12279.richard@nod.at>
References: <1310994456-14142-1-git-send-email-richard@nod.at>
 <1310994456-14142-3-git-send-email-richard@nod.at> <4E27163A.6090102@mit.edu> <201107202009.12279.richard@nod.at>
From: Andrew Lutomirski <luto@mit.edu>
Date: Wed, 20 Jul 2011 14:19:13 -0400
Message-ID: <CAObL_7Gss0GcB8OtoCf-rUdsi8n4345gBESBub+5hu4g9fcssw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] um: Implement a x86_64 vDSO
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jul 20, 2011 at 2:09 PM, Richard Weinberger <richard@nod.at> wr=
ote:
> Am Mittwoch 20 Juli 2011, 19:54:02 schrieb Andy Lutomirski:
>> On 07/18/2011 09:07 AM, Richard Weinberger wrote:
>> > Until now UML had no x86_64 vDSO.
>> > So glibc always used the vsyscall page for gettimeday()
>> > and friends.
>> > Calls to gettimeday() returned falsely the host time and
>> > confused some programs.
>> >
>> > This patch adds a vDSO which turns all __vdso_* calls into
>> > a system call so that UML can trap them.
>> >
>> > As glibc still uses the vsyscall page for static binaries this
>> > patch improves the situation only for dynamic binaries.
>> >
>> > Signed-off-by: Richard Weinberger<richard@nod.at>
>> >
>> > + =A0 asm("syscall" : "=3Da" (ret) :
>> > + =A0 =A0 =A0 =A0 =A0 "0" (__NR_clock_gettime), "D" (clock), "S" (=
ts) : "memory");
>> > +
>>
>> The x86-64 ABI and glibc think that rcx, and r11 are clobbered. =A0g=
libc
>> also thinks that cc is clobbered. =A0I personally think that rdx and
>> r8-r15 ought to be clobbered under the principle that syscall should
>> look like a function call.
>
> Hmm, I thought my implementation is fine because it follows
> arch/x86/vdso/vclock_gettime.c (Linus' tree).
>
> notrace static long vdso_fallback_gettime(long clock, struct timespec=
 *ts)
> {
> =A0long ret;
> =A0asm("syscall" : "=3Da" (ret) :
> =A0 =A0 =A0"0" (__NR_clock_gettime),"D" (clock), "S" (ts) : "memory")=
;
> =A0return ret;
> }
>
> Am I missing something or needs vdso_fallback_gettime() also some upd=
ates?

vdso_fallback_gettime is going away :)

I haven't read all of the sysret code paths, but it looks like at
least r11 is used in a comment.  That being said, your code is an
uninlinable function, and functions already clobber all those
registers, so the code shouldn't cause problems in real life.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

