Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HD4si-0001Oy-76 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 12:19:36 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HD4sg-0005m6-M7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 12:19:36 -0800
Date: Fri, 2 Feb 2007 15:12:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070202201230.GA8533@ccure.user-mode-linux.org>
References: <20070131224504.GA7698@ccure.user-mode-linux.org>
	<200702021848.40114.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702021848.40114.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] x86_64 32-bit ptrace mangles sixth system
	call argument
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

On Fri, Feb 02, 2007 at 06:48:39PM +0100, Blaisorblade wrote:
> Is this a recent regression or did this always happen?

I haven't looked at the history of the code, but it has the look of
something that's been there a long time.

> Is this the bug diagnosed by Bodo Stroesser time ago, or only it looks 
> similar? I recall vaguely that in that bug RCX was corrupted.

No, RCX corruption is different - that happens when a sysexit is done
from a system call where userspace wasn't prepared to save and restore
RCX.  sigreturn is the best example.

> Above all, how can UML run in SKAS0 mode with this bug (if it can)?

The impact is limited by several things -
	it must be a 32-bit UML on a 64-bit host
	the system call must have 6 arguments - mmap and pselect are
the only 6-argument system calls that I can find quickly
	the system call must be made through sysenter - int 0x80 is
fine

But, a 32-bit UML making mmap calls through sysenter indeed does not run
very well.

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
