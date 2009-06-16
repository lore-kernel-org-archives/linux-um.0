Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1MGN6a-0006Nk-DI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:04:52 +0000
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGN6T-00052C-36
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:04:46 +0000
Date: Mon, 15 Jun 2009 21:03:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090616010350.GA14840@c2.user-mode-linux.org>
References: <6599ad830906111202u78bcf043nd0e6a54e7251d8d7@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6599ad830906111202u78bcf043nd0e6a54e7251d8d7@mail.gmail.com>
Subject: Re: [uml-devel] Building/runing UML in SMP mode
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
To: Paul Menage <menage@google.com>
Cc: Benjamin Blum <bblum@google.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 11, 2009 at 12:02:56PM -0700, Paul Menage wrote:
> For a while now (since tt mode was dropped and skas mode became the
> only option?)  it looks as though UML has been UP-only on x86-64. And
> even though the configs appear to allow building SMP on x86-32, there
> are things like the panic() call in kernel/smp.c:idle_thread() which
> imply that it won't work too well in 32-bit mode either.
> 
> For testing cgroups/cpusets changes we'd find it useful to be able to
> run UML in SMP mode. Is anyone working on this, or can point us at a
> list of the major things that need to be done to make SMP UML
> practical?

SMP has been problematic because of ptrace.  Ironically, despite the
horridness of tt mode, that was where SMP was easiest to do.

The problem with SMP on skas0 is the need to detach a userspace
process from one virtual CPU process and attach it to another whenever
the associated UML process is migrated from one CPU to another.

I actually had this somewhat working, but the code was a horror show,
with much nastiness about ignoring the signals that are needed in
order to prevent a detached process from running.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

