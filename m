Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOiCD-0004uz-SI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:36:22 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JOiCC-0000iq-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:36:21 -0800
Date: Mon, 11 Feb 2008 18:36:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080211233608.GA11499@c2.user-mode-linux.org>
References: <1202674302.28562.5.camel@localhost>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1202674302.28562.5.camel@localhost>
Subject: Re: [uml-devel] [PATCH] uml: Fix printk in initrd.c
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
To: Johann Felix Soden <johfel@gmx.de>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Jeff Dike <jdike@linux.intel.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 10, 2008 at 09:11:42PM +0100, Johann Felix Soden wrote:
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> If the initrd file has zero-length, the error message should contain the filepath.

Sigh - Wang Cong discovered this and sent it to Andrew about a week
ago, but Andrew seemed to have ignored it and I didn't notice.

I'll hang on to this and send it on.

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
