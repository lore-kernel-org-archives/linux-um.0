Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qv1cW-00034r-5r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 06:34:56 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qv1cU-00007N-QV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 06:34:56 +0000
Date: Sun, 21 Aug 2011 07:34:43 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110821063443.GH2203@ZenIV.linux.org.uk>
References: <4E4D642F.3010909@nod.at>
	<20110818191946.GW2203@ZenIV.linux.org.uk>
	<20110819043120.GY2203@ZenIV.linux.org.uk>
	<4E4E2427.9080602@nod.at>
	<20110820011845.GC2203@ZenIV.linux.org.uk> <4E4FD12F.70508@nod.at>
	<20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
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
Subject: Re: [uml-devel] [RFC] weird crap with vdso on uml/i386
To: Andrew Lutomirski <luto@mit.edu>
Cc: Richard Weinberger <richard@nod.at>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Aug 20, 2011 at 05:40:03PM -0400, Andrew Lutomirski wrote:

> will cause iret (if iret happens) to restore the original rbp in rcx
> (why? -- it seems okay if syscall is hit in __kernel_vsyscall but not
> if something else does the syscall).  I don't see what saves rbp to
> the stack frame.

Far more interesting question is how the hell does that thing manage to
work in face of syscall restarts?  As the matter of fact, how does it
(and sysenter-based variant) play with ptrace() *and* restarts?

Suppose we have a traced process.  foo6() is called and the thing it
stopped before the sys_foo6() is reached kernel-side.  The sixth argument
is on stack, ebp is set to user esp.  SYSENTER happens, we read the
6th argument from userland stack and put it along with the rest into
pt_regs.  tracer examines the arguments, modifies them (including the last
one) and lets the tracee run free - e.g. detaches from the tracee.  

What should happen if we happen to get a signal that would restart that
sucker?  Granted, it's not going to happen with mmap() - it doesn't, AFAICS,
do anything of that kind.  However, I wouldn't bet a dime on other 6-argument
syscalls not stepping on that.  sendto() and recvfrom(), in particular...

OK, we return to userland.  The sixth argument is placed into %ebp.  Linus'
"pig and proud of that" trick works and we end up slapping userland
%esp into %ebp and hitting SYSENTER again.  Only one problem, though -
the sixth argument on user stack is completely unaffected by what tracer
had done.  Unlike the rest of arguments, that *are* changed.

We could deal with that in case of SYSENTER if we e.g. replaced that
        jmp .Lenter_kernel
with
        jmp .Lrestart
and added
.Lrestart:
	movl %ebp, (%esp)
	jmp .Lenter_kernel
but in case of SYSCALL it seems to be even messier...  Comments?

... and there I thought that last year session of asm glue sniffing couldn't
be topped by anything more unpleasant ;-/

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

