Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 23 Aug 2011 02:01:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823010146.GY2203@ZenIV.linux.org.uk>
References: <20110822144051.GD2946@aftab>
 <20110822151305.GV2203@ZenIV.linux.org.uk>
 <CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
 <4E52B7F8.3050002@zytor.com>
 <CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
 <4E52D280.3010107@zytor.com>
 <CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
 <20110823000314.GW2203@ZenIV.linux.org.uk>
 <4E52EF2A.8060608@zytor.com>
 <CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] SYSCALL, ptrace and syscall restart breakages (Re:
 [RFC] weird crap with vdso on uml/i386)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Lutomirski <luto@mit.edu>, Borislav Petkov <bp@amd64.org>, Ingo Molnar <mingo@kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 22, 2011 at 05:22:07PM -0700, Linus Torvalds wrote:

> You guys seem to positively _want_ to make this a bigger issue than it
> is. As far as I can tell, nobody has ever even noticed this problem
> before, and we already have a trivial fix ("don't do it then") for the
> case Al actually did notice.

I'm not sure.   What I've noticed was complete weirdness in uml, apparently
dependent on SYSCALL vs. SYSENTER or int 0x80.  With following round of
RTFS and finding what looks like an ugly issue with restarts.

What I don't understand at all is how the hell do we manage to avoid much
more obvious breakage all the time we ptrace a 32bit task.  Look:
__kernel_vsyscall() is
        push    %ebp
        movl    %ecx, %ebp
        syscall
        movl    $__USER32_DS, %ecx
        movl    %ecx, %ss
        movl    %ebp, %ecx
        popl    %ebp

now, what is going to happen to %ebp if we go through IRET path, for any
reason?  From my reading it appears that right after that IRET we'll have
ebp containing arg6.  I.e. what we'd pushed on stack.  Now, popl %ebp
will bring the same value back.  Not a problem.  But what about
movl %ebp, %ecx?  Again, I'm talking about the case when we have no
restart at all - just an strace(1) tracing a process.

AFAICS, in that case we ought to have %ecx == %ebp after return from
__kernel_vsyscall().  Which would blow the things up _very_ fast.

So what the hell am I missing here?
