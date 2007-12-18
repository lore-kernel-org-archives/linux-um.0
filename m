Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J4i8J-0003Ou-7e for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Dec 2007 11:29:39 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J4i8H-0001TA-Jw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Dec 2007 11:29:39 -0800
Date: Tue, 18 Dec 2007 14:29:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071218192911.GA7940@c2.user-mode-linux.org>
References: <200712181245.23753.rob@landley.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200712181245.23753.rob@landley.net>
Subject: Re: [uml-devel] Loopback mounting jffs2 under UML?
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
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 18, 2007 at 12:45:23PM -0600, Rob Landley wrote:
> There's a way to make a loopback device look like a flash device, letting 
> you loopback mount jffs2, but it involves recompiling the kerenel to add 
> support for it, and of course I went "User Mode Linux"...  Except
> that UML disables  the flash menu entirely.

> Suggestions?

I see this in menuconfig:

Symbol: MTD [=n]                                                      
   Prompt: Memory Technology Device (MTD) support                     
     Defined at drivers/mtd/Kconfig:3                                  
     Depends on: BROKEN && HAS_IOMEM

You could try removing the dependencies on BROKEN and HAS_IOMEM and
see what happens...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
