Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qurvr-0000nS-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Aug 2011 20:14:15 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qurvq-0005es-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Aug 2011 20:14:15 +0000
Date: Sat, 20 Aug 2011 21:14:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110820201406.GF2203@ZenIV.linux.org.uk>
References: <E1Qu7nv-0007OP-3E@ZenIV.linux.org.uk> <4E4D642F.3010909@nod.at>
	<20110818191946.GW2203@ZenIV.linux.org.uk>
	<20110819043120.GY2203@ZenIV.linux.org.uk>
	<4E4E2427.9080602@nod.at>
	<20110820011845.GC2203@ZenIV.linux.org.uk> <4E4FD12F.70508@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E4FD12F.70508@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Aug 20, 2011 at 05:22:23PM +0200, Richard Weinberger wrote:

> Hmmm, very strange.
> Sadly I cannot reproduce the issue. :(
> Everything works fine within UML.
> (Of course I've applied your vDSO/i386 patches)
> 
> My test setup:
> Host kernel: 2.6.37 and 3.0.1
> Distro: openSUSE 11.4/x86_64
> 
> UML kernel: 3.1-rc2
> Distro: openSUSE 11.1/i386
> 
> Does the problem also occur with another host kernel or a different
> guest image?

Could you check what you get in __kernel_vsyscall()?  On iAMD64 box
where that sucker contains sysenter-based variant the bug is not
present.  IOW, it's sensitive to syscall vs. systenter vs. int 0x80
differences.

I can throw the trimmed-down fs image your way, BTW (66MB of bzipped ext2 ;-/)
if you want to see if that gets reproduced on your box.  I'll drop it on
anonftp if you are interested.  FWIW, the same kernel binary/same image
result in
	* K7 box - no breakage, SYSENTER-based vdso
	* K8 box - breakage as described, SYSCALL-based vdso32
	* P4 box - no breakage, SYSENTER-based vdso32
Hell knows...  In theory that would seem to point towards ia32_cstar_target(),
so I'm going to RTFS carefully through that animal.

The thing is, whatever happens happens when victim gets resumed inside
vdso page.  I'll try to dump PTRACE_SETREGS and see the values host
kernel asked to set and work from there, but the interesting part is
bloody hard to singlestep through - the victim is back to user mode and
it is already traced by the guest kernel, so it's not as if we could
attach host gdb to it and walk through that crap.  And guest gdb is not
going to be able to set breakpoints in there - vdso page is r/o...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

