Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110821164124.GL2203@ZenIV.linux.org.uk>
References: <20110820011845.GC2203@ZenIV.linux.org.uk> <4E4FD12F.70508@nod.at>
 <20110820201406.GF2203@ZenIV.linux.org.uk> <4E501F51.9060905@nod.at>
 <CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
 <CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
 <20110821063443.GH2203@ZenIV.linux.org.uk> <20110821084230.GI2203@ZenIV.linux.org.uk>
 <CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
 <20110821144352.GJ2203@ZenIV.linux.org.uk> <20110821164124.GL2203@ZenIV.linux.org.uk>
From: Andrew Lutomirski <luto@mit.edu>
Date: Sun, 21 Aug 2011 20:44:12 -0400
Message-ID: <CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: SYSCALL, ptrace and syscall restart breakages (Re: [RFC] weird
 crap with vdso on uml/i386)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, mingo@redhat.com, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Aug 21, 2011 at 12:41 PM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> On Sun, Aug 21, 2011 at 03:43:52PM +0100, Al Viro wrote:
>
>> We do not lie to ptrace and iret. =A0At all. =A0We do just what you =
have
>> described. =A0And fuck up when restart returns us to the SYSCALL / S=
YSENTER
>> instruction again, which expects the different calling conventions,
>> so the values arranged in registers in the way int 0x80 would expect
>> do us no good.
>
> FWIW, what really happens (for 32bit task on amd64) is this:

I think I believe your analysis...

> =A0 =A0 =A0 =A0* Both codepaths start with arranging the same thing o=
n the kernel
> stack frame; one 64bit int 0x80 would create. =A0For the good and sim=
ple
> reason: they all have to be able to leave via IRET. =A0Stack layout i=
s the
> same, but we need to fill it accordingly to calling conventions we ar=
e
> stuck with. =A0I.e. ->cx should be initialized with arg2 and ->bp wit=
h
> arg6, wherever those currently are on given codepath. =A0_That_ is wh=
at
> "lying to ptrace" is about - we store there registers according to ho=
w
> they were when we entered __kernel_vsyscall(), not as they are at the
> moment of actual SYSCALL insn. =A0Which is precisely the right thing =
to do,
> since if we *are* ptraced, the tracer expects to find the syscall arg=
ument
> in the same places, whichever variant of syscall tracee happens to be=
 using.

This is, IMO, gross -- if the values in pt_regs matched what they were
when sysenter / syscall was issued, then we'd be fine -- we could
restart the syscall and everything would work.  Apparently ptrace
users have a problem with that, so we're stuck with the "lie" (i.e.
reporting values as of __kernel_vsyscall, not as of the actual kernel
entry).

> =A0 =A0 =A0 =A0* If there *was* a syscall restart to be done, we are =
guaranteed to
> have left via IRET path. =A0In all cases the syscall arguments end up=
 in
> registers, in the same way int 0x80 expected them. =A0What happens af=
terwards
> depends on how we entered, though.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ int 0x80: all registers are restored=
 (with ptrace
> manipulations, if any, having left their effect) as they'd been the l=
ast
> time around. =A0In we go and that's it.

Which suggests an easy-ish fix: if sysenter is used or if syscall is
entered from the EIP is is supposed to be entered from, then just
change ip in the argument save to point to the int 0x80 instruction.
This might also require tweaking the userspace stack.  That way,
restart would hit int 0x80 instead of syscall/sysenter and the
registers are exactly as expected.

Getting this right in the case where ptrace attaches during the
syscall might be tricky, though.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

