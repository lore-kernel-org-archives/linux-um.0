Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgLLM-0007Jr-PV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:50:40 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgLLL-0004Sq-7y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:50:40 -0700
Date: Mon, 31 Mar 2008 10:50:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080331145036.GH6540@c2.user-mode-linux.org>
References: <47ED74B8.8060602@nagafix.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47ED74B8.8060602@nagafix.co.uk>
Subject: Re: [uml-devel] syscall failed
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
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Mar 28, 2008 at 10:44:08PM +0000, Antoine Martin wrote:
> FYI: (skas4 host)

Woo - a skas4 bug report!

However

> [43492659.840000] syscall_stub_done : ret = -12, offset = 548682067984,
> data = 000000007f115010
> [43492659.840000] syscall_stub_done : syscall 9 failed, return value =
> 0xfffffff4, expected return value = 0x47a0000

is just mmap returning -ENOMEM, which we've seen elsewhere with large
UML processes hitting the host's /proc/sys/vm/max_map_count limit.
Have you checked that?

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
