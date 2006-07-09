Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FzZm9-000515-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 06:56:45 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FzZm6-0006lC-FY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 06:56:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 9 Jul 2006 15:47:04 +0200
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
In-Reply-To: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607091547.04527.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML 2.6.17 problems (section mismatch,
	get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Miao Qingjun <qmiao@centecnetworks.com>, user-mode-linux-user@lists.sourceforge.net

On Friday 30 June 2006 09:50, Miao Qingjun wrote:
> Hi,
>
> Two problems
>
> First one,
> when building kernel and LKMs,
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt
> after '' (at offset 0x8347e44) WARNING: vmlinux - Section mismatch:
> reference to .init: from .plt after '' (at offset 0x8347e64) WARNING:
> vmlinux - Section mismatch: reference to .init.setup: from .plt after ''
> (at offset 0x8347ea4) WARNING: vmlinux - Section mismatch: reference to
> .init.text:nosmp from .plt after '' (at offset 0x8347f20) WARNING: vmlinux
> - Section mismatch: reference to .init.setup:__setup_nosmp from .plt after
> '' (at offset 0x8347f28) WARNING: vmlinux - Section mismatch: reference to
> .init.text:maxcpus from .plt after '' (at offset 0x8347f2c) ...
> ...
>
> So when gdb loads LKM symbols, it seems .init.text and .exit.text sections
> overlapped with .text section.
It isn't a problem we haven't fully analized but which always seemed 
harmless - but building with dynamic linking disabled makes it go away.

However, note that it is a kernel build helper (not binutils) which doesn't 
know that .plt sections, which are needed for dynamic linking are allowed to 
reference .init* sections (while it knows this for other sections). Its 
purpose is simply to avoid .text referencing .init, since such a reference 
will fail when .init code and data get freed (soon after the boot).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
