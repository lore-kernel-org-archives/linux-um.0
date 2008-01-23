Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JHowA-0006Km-Gw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 15:23:18 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JHow9-0004Kp-01
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 15:23:18 -0800
Date: Wed, 23 Jan 2008 18:23:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080123232313.GA11799@c2.user-mode-linux.org>
References: <4797C6A5.1030408@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4797C6A5.1030408@nagafix.co.uk>
Subject: Re: [uml-devel] console and do_syscall_stub
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jan 23, 2008 at 10:58:45PM +0000, Antoine Martin wrote:
> [42949466.740000] do_syscall_stub : ret = -12, offset = 548682067984,
> data = 00000000606b1010

This usually means that a UML process hit the host's vm_area_struct limit.

Look at the host's /proc/sys/vm/max_map_count - the default is 64K,
which, given UML's propensity to map memory one page at a time, covers
256M of resident memory for a UML process.

I'd say double or quadruple it, depending on how much memory you think
a process can use.  To be absolutely safe, make it big enough to cover
all of a UML's physical memory, since a process RSS can't exceed that.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
