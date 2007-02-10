Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HG0iZ-0006UY-Px for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 14:29:16 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HG0iX-0003HH-5t
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 14:29:15 -0800
Date: Sat, 10 Feb 2007 17:21:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070210222157.GA3750@ccure.user-mode-linux.org>
References: <200702100944.l1A9iSEp008813@shell0.pdx.osdl.net>
	<200702101331.20261.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702101331.20261.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 094/241] uml: fix error output during early
	boot
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Feb 10, 2007 at 01:31:20PM +0100, Blaisorblade wrote:
> libc's printf has an enormous stack usage, so that my_printf is used for 
> direct output instead of printf; if this is ok because it's bootup
> code, 

It is bootup code only.

> then *fatal* should be marked as "bootup code only"; 

OK.

> otherwise
> we may reuse vsprintf() and write() or fputs(); this should match
> what happens in my_printf, to avoid any unlikely problem with libc's
> buffering. 

Offhand, I would say that if we are on a kernel stack, printk is safe
to use, and should be used, so there's no need for things like
my_printf.  Maybe there are some exceptions in early boot when the
kernel is running, but before the console is working, but I can't
think of any problems we've had like that.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
