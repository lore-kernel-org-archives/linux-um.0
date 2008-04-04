Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhoAB-00009Q-EV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 08:49:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JhoA8-0001rr-Qf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 08:49:11 -0700
Date: Fri, 4 Apr 2008 11:49:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080404154901.GB11545@c2.user-mode-linux.org>
References: <20080401.230641.146239754.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080401.230641.146239754.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [Patch] arch/um/os-Linux/main.c: Fix memory leaks.
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 01, 2008 at 11:06:41PM +0800, WANG Cong wrote:
> 
> This patch fixes possible memory leaks in the main() function of
> arch/um/os-Linux/main.c.

I'm somewhat dubious about this - the memory is freed immediately
before exiting, making this patch have no practical effect.

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
