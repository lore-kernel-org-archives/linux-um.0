Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4E52B7F8.3050002@zytor.com>
References: <20110822011645.GM2203@ZenIV.linux.org.uk> <CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
 <4E51B56F.3080301@zytor.com> <CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
 <20110822020737.GP2203@ZenIV.linux.org.uk> <CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
 <4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
 <CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
 <20110822144051.GD2946@aftab> <20110822151305.GV2203@ZenIV.linux.org.uk>
 <CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com> <4E52B7F8.3050002@zytor.com>
From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 22 Aug 2011 17:52:07 -0400
Message-ID: <CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] SYSCALL, ptrace and syscall restart breakages (Re:
 [RFC] weird crap with vdso on uml/i386)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Borislav Petkov <bp@amd64.org>, Ingo Molnar <mingo@kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 22, 2011 at 4:11 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 08/22/2011 01:05 PM, Linus Torvalds wrote:
>> On Mon, Aug 22, 2011 at 8:13 AM, Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>>>
>>> In __kernel_vsyscall() the problem is possible to deal with; there =
we control
>>> the code around that sucker. =A0It's SYSCALL in 32bit binary outsid=
e of
>>> vdso32 that causes real PITA...
>>
>> I just checked. 'syscall' (at least on x86-64) is definitely called
>> outside of __kernel_vsyscall in all the normal cases. It's part of t=
he
>> fundamental ABI, after all. We don't use "int 0x80" there.
>>
>> But on x86-32, I think we might be better off. There, we only have
>> 'sysenter', and can perhaps use my suggested "just use int 0x80
>> instead of the jump back to the sysenter instruction" trick. Plus
>> people *will* be using __kernel_vsyscall, since on x86-32 you aren't
>> guaranteed to have a CPU that supports sysenter to begin with.
>>
>> Or am I missing something else?
>>
>
> SYSCALL in 64-bit mode is not a problem.
>
> SYSCALL in compatibility mode (32-on-64) *is* a problem, because ECX =
is
> clobbered. =A0Unfortunately AMD processors only support SYSENTER in l=
egacy
> mode (32-on-32) -- unlike Intel and VIA.
>
> Your trick solves SYSENTER, which takes care of legacy mode and Intel
> and VIA processors in compatibility mode.
>
> Borislav is checking into if we can just use INT 80h on AMD processor=
s
> in compatibility mode. =A0So far the indication seems to be that it i=
s
> probably okay.

Even if it's ok, we still have to do *something* in the cstar entry
point -- I don't think there's any way to turn SYSCALL in
compatibility mode but leave it enabled in long mode.  So if we're
planning on killing off SYSCALL from outside the vdso, we could
probably get away with leaving it enabled in the vdso.

Unless, of course, there are 32-bit JITs that do things that they
shouldn't.  We could still make it work by rewriting the arguments
(including arg6 on the stack) from the syscall restart path, but that
may be more trouble than it's worth.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

