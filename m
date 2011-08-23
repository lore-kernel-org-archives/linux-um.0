Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvfYn-0008MY-CD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 01:13:45 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvfYm-0005zi-Ok
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 01:13:45 +0000
Date: Tue, 23 Aug 2011 02:13:12 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823011312.GZ2203@ZenIV.linux.org.uk>
References: <20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110823010146.GY2203@ZenIV.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 23, 2011 at 02:01:46AM +0100, Al Viro wrote:

> now, what is going to happen to %ebp if we go through IRET path, for any
> reason?  From my reading it appears that right after that IRET we'll have
> ebp containing arg6.  I.e. what we'd pushed on stack.  Now, popl %ebp
> will bring the same value back.  Not a problem.  But what about
> movl %ebp, %ecx?  Again, I'm talking about the case when we have no
> restart at all - just an strace(1) tracing a process.
> 
> AFAICS, in that case we ought to have %ecx == %ebp after return from
> __kernel_vsyscall().  Which would blow the things up _very_ fast.
> 
> So what the hell am I missing here?

*UGH*.  OK,
	1) I'm an idiot; int_ret_from_sys_call does *not* usually step on
rbp (it's callee-saved).  So normally ebp is left as is on the way out,
which is why we don't see stuff getting buggered left, right and center.
	2) Sometimes it apparently does somehow happen.  I don't see where
it happens yet, but uml breakage that started all of that looks *exactly*
like that.  %ebp getting arg6 in it when we return into __kernel_vsyscall()
from the kernel fits the observed pattern precisely.
	3) modulo that the situation is nowhere near as bad as I thought.
Brown paperbag time for me - for missing that if my analysis had been correct
we'd've seen breakage _much_ earlier.  Mea culpa.
	4) we still have a problem, apparently, but it's more narrow now -
the question is when would %rbp be shat into?

Al, off to apply a serious self-LART...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

