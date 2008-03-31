Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgLN8-0007XI-1g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:52:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgLN5-0004Jx-T2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:52:29 -0700
Date: Mon, 31 Mar 2008 10:52:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080331145210.GJ6540@c2.user-mode-linux.org>
References: <20080330224031.GG28445@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080330224031.GG28445@cs181133002.pp.htv.fi>
Subject: Re: [uml-devel] [2.6 patch] remove include/asm-um/keyboard.h
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
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 31, 2008 at 01:40:31AM +0300, Adrian Bunk wrote:
> This patch removes the unused and broken (the normal asm/keyboard.h 
> files no longer exists) include/asm-um/keyboard.h
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Thanks, I'll forward this on.

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
