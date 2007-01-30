Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HC0rP-0004fT-4m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 13:49:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HC0rM-0000Iv-FX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 13:49:50 -0800
Date: Tue, 30 Jan 2007 16:42:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070130214252.GA7947@ccure.user-mode-linux.org>
References: <45BF901F.40206@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45BF901F.40206@nagafix.co.uk>
Subject: Re: [uml-devel] do_syscall_stub: syscall 9 failed
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 30, 2007 at 06:36:15PM +0000, Antoine Martin wrote:
> Just caught this in `dmesg`
> 
> [42977596.520000] Adding 131064k swap on /dev/ubdb.  Priority:-1 
> extents:1 across:131064k
> [42980169.290000] do_syscall_stub : ret = -12, offset = 548682067984, 
> data = 0000000060b16010
> [42980169.290000] do_syscall_stub: syscall 9 failed, return value = 
> 0xfffffffffffffff4, expected return value = 0x477a000
> [42980169.290000]     syscall parameters: 0x477a000 0x1000 0x7 0x11 0x3 
> 0xad0c000
> [42980169.290000] fix_range_common: failed, killing current process
> 
> Whilst trying to compile gcc (big beast) on a 64-bit UML instance.
> Earlier it had failed and triggered OOM, which is why I added the swap, 
> now it may still not have enough (compilation crashed in a similar 
> manner) but this time there is no OOM message.
> 
> Any ideas what this is?

Sounds like it might be the host /proc/sys/vm/max_map_countbeing
exceeded, which will happen with a UML process with 256M RSS.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
