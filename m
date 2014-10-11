Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Xcv41-0004dp-6P
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Oct 2014 11:42:21 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xcv3z-0007vO-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Oct 2014 11:42:21 +0000
Message-ID: <54391792.40508@nod.at>
Date: Sat, 11 Oct 2014 13:42:10 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1413026981-9667-1-git-send-email-nicolas.iooss_linux@m4x.org>
In-Reply-To: <1413026981-9667-1-git-send-email-nicolas.iooss_linux@m4x.org>
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
Subject: Re: [uml-devel] [PATCH] um: always use the same type for
	__syscall_stub_start
To: Nicolas Iooss <nicolas.iooss@polytechnique.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Am 11.10.2014 um 13:29 schrieb Nicolas Iooss:
> syscall_stub_start is declared with different types in C files:
> 
>   arch/um/kernel/physmem.c: extern int __syscall_stub_start;
>   arch/um/kernel/skas/mmu.c: extern int __syscall_stub_start;
>   arch/um/os-Linux/skas/mem.c: extern unsigned long __syscall_stub_start;
>   arch/um/os-Linux/skas/process.c: extern int __syscall_stub_start;
> 
> Fix this inconsistency by always using unsigned long.  This does not
> change anything in the compiled code because only the address of
> __syscall_stub_start is used, but it makes the static checker I use
> stop complaining about incompatible declarations.

While we're here, can you put these declarations into a single header file?

Thanks,
//richard

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

