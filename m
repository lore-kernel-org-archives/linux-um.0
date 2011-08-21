Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <amluto@gmail.com>) id 1Qv69G-0006IR-7B
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 11:25:04 +0000
Received: from mail-pz0-f42.google.com ([209.85.210.42])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Qv69F-0003QD-63
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 11:25:02 +0000
Received: by pzk37 with SMTP id 37so7230449pzk.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Aug 2011 04:24:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110821084230.GI2203@ZenIV.linux.org.uk>
References: <20110818191946.GW2203@ZenIV.linux.org.uk>
	<20110819043120.GY2203@ZenIV.linux.org.uk>
	<4E4E2427.9080602@nod.at> <20110820011845.GC2203@ZenIV.linux.org.uk>
	<4E4FD12F.70508@nod.at> <20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
From: Andrew Lutomirski <luto@mit.edu>
Date: Sun, 21 Aug 2011 07:24:35 -0400
Message-ID: <CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 21, 2011 at 4:42 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Aug 21, 2011 at 07:34:43AM +0100, Al Viro wrote:
>> Suppose we have a traced process. =A0foo6() is called and the thing it
>> stopped before the sys_foo6() is reached kernel-side. =A0The sixth argum=
ent
>> is on stack, ebp is set to user esp. =A0SYSENTER happens, we read the
>> 6th argument from userland stack and put it along with the rest into
>> pt_regs. =A0tracer examines the arguments, modifies them (including the =
last
>> one) and lets the tracee run free - e.g. detaches from the tracee.
>>
>> What should happen if we happen to get a signal that would restart that
>> sucker? =A0Granted, it's not going to happen with mmap() - it doesn't, A=
FAICS,
>> do anything of that kind. =A0However, I wouldn't bet a dime on other 6-a=
rgument
>> syscalls not stepping on that. =A0sendto() and recvfrom(), in particular=
...
>>
>> OK, we return to userland. =A0The sixth argument is placed into %ebp. =
=A0Linus'
>> "pig and proud of that" trick works and we end up slapping userland
>> %esp into %ebp and hitting SYSENTER again. =A0Only one problem, though -
>> the sixth argument on user stack is completely unaffected by what tracer
>> had done. =A0Unlike the rest of arguments, that *are* changed.
>>
>> We could deal with that in case of SYSENTER if we e.g. replaced that
>> =A0 =A0 =A0 =A0 jmp .Lenter_kernel
>> with
>> =A0 =A0 =A0 =A0 jmp .Lrestart
>> and added
>> .Lrestart:
>> =A0 =A0 =A0 movl %ebp, (%esp)
>> =A0 =A0 =A0 jmp .Lenter_kernel
>> but in case of SYSCALL it seems to be even messier... =A0Comments?
>
> Oh, hell... =A0Compat SYSCALL one is really buggered on syscall restarts,
> ptrace or no ptrace. =A0Look: calling conventions for SYSCALL are
> =A0 =A0 =A0 =A0arg1..5: ebx, ebp, edx, edi, esi. =A0arg6: stack
> and after syscall restart we end up with
> =A0 =A0 =A0 =A0arg1..5: ebx, ecx, edx, edi, esi. =A0arg6: ebp
> so restart will instantly clobber arg2, in effect replacing it with arg6.
>
> And yes, adding ptrace to the mix makes things even uglier. =A0For one th=
ing,
> changes to ECX via ptrace are completely lost on the fast exit. =A0Not pr=
etty,
> and might make life painful for uml, but not for the majority of programs.
> What's worse, combination of ptrace with restart will lose changes to arg6
> (again, value on stack left as it was, changes to arg6 by tracer lost) *a=
nd*
> it will lose changes to arg2 (along with arg2 itself - see above).
>
> Linus' Dirty Trick(tm) is not trivial to apply - with SYSCALL we *do* ret=
ain
> the address of next insn and that's where we end up going. =A0IOW, SYSCAL=
L not
> inside vdso32 currently works (for small values of "works", due to restart
> issues). =A0Playing with return elsewhere might break some userland code.=
..
>
> Guys, that's *way* out of the area I'm comfortable with.
>

I don't see the point of all this hackery at all.  sysenter/sysexit
indeed screws up some registers, but we can return on the iret path in
the case of restart.

So why do we lie to ptrace (and iret!) at all?  Why not just fill in
pt_regs with the registers as they were (at least the
non-clobbered-by-sysenter ones), set the actual C parameters correctly
to contain the six arguments (in rdi, rsi, etc.), do the syscall, and
return back to userspace without any funny business?  Is there some
ABI reason that, once we've started lying to tracers, we have to keep
doing so?

--Andy

---------------------------------------------------------------------------=
---
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, =

user administration capabilities and model configuration. Take =

the hassle out of deploying and managing Subversion and the =

tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

