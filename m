Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1XWRmL-0002vs-9S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Sep 2014 15:13:21 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWRmG-0002aZ-Rh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Sep 2014 15:13:21 +0000
Message-ID: <54218E02.10506@nod.at>
Date: Tue, 23 Sep 2014 17:13:06 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <E1XW6rt-0005E0-Pl@sog-mx-2.v43.ch3.sourceforge.com>
	<54206CFB.4070308@kot-begemot.co.uk> <54218A8B.5030808@landley.net>
In-Reply-To: <54218A8B.5030808@landley.net>
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
Subject: Re: [uml-devel] Fwd: Mail delivery failed: returning message to
	sender
To: Rob Landley <rob@landley.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net

Rob,

Am 23.09.2014 16:58, schrieb Rob Landley:
> As long as somebody's paying attention to UML again: what would be
> involved in adding support for arm/mips/sh4/sparc...
> 
> I've mostly wandered off to use qemu these days, and I package system
> images with native compilers you can boot up and compile software in:
> 
> http://landley.net/aboriginal/bin/
> 
> (Grab a system-image-$ARCH.tar.bz2 and ./run-emulator.sh in that, or
> ./dev-environment.sh if you want it to truncate and ext2 format a
> scratch space block device and and mount it on /home in the emulated
> system so you have persistent storage.)
> 
> I'm under the impression that user mode linux would need some glue code
> to run on powerpc, but dunno what it would actually be...

Supporting non-x86 archs needs more than just some glue code.
First the target arch would need support for changing syscall numbers with ptrace(),
or even better PTRACE_SYSEMU support. UML also depends on mcontext of SIGSEGV to
get the faulting address.
On ARM for example VIVT caches could be a problem too.
Al has all the glory details...

Thanks,
//richard

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

