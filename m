Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaIvk-00022y-Hi for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 14:26:28 -0700
Received: from mail.trixing.net ([87.230.125.58])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GaIvi-0004Lp-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 14:26:28 -0700
Message-ID: <45369BBE.9040100@l4x.org>
Date: Wed, 18 Oct 2006 23:25:18 +0200
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
References: <4536495E.7010006@l4x.org>
	<20061018190957.GG6566@ccure.user-mode-linux.org>
	<45367D7E.9040609@l4x.org>
	<20061018210506.GA7541@ccure.user-mode-linux.org>
In-Reply-To: <20061018210506.GA7541@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Programs in guest segfault, amd64 host and guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Wed, Oct 18, 2006 at 09:16:14PM +0200, Jan Dittmer wrote:
>> This is 100% reproducible here. Perfect test case. How to debug?
> 
> You want to dig into the code and see what's wrong?  Put a breakpoint
> on the force_sig_info(SIGSEGV, ...) in segv().  Then find the faulting
> instruction -
> 	RIP is regs.skas.regs[16]
> 	pid = cpu_tasks[0].pid
> 	Look in the host's /proc/$pid/maps for the page containing RIP
> 	add uml_physmem to the offset in column 3 - that's the
> physical page containing RIP
> 	add the RIP page offset to that to get the actual physical
> address for RIP
> 	disassemble the range of memory around it - I usually do 10 -
> 20 bytes before it to ~10 bytes after
> 	see that the asm looks sane, if not, bump the start of the
> disassembly by a byte in either direction until it does
> 	see what the instruction at RIP is - if it involves a gs:
> reference, then it's very likely a NPTL problem

Well tomorrow perhaps. I've very little time currently :-(

> If you don't want to do that, tell me what to yum, and how to run
> whatever it is, and I'll look at it.

As I wrote in the original message: Debian/etch amd64 host+guest,
running btlaunchmany (from the bittorrent package). I can put you
the compressed root + kernel somewhere if that helps. It's roughly
100mb.

Jan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
