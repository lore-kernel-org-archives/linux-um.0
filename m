Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFZv0-0000Oi-Iv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:56:50 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFZuv-0000PK-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:56:48 -0800
Date: Thu, 17 Jan 2008 13:56:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117185625.GA5724@c2.user-mode-linux.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117135641.GD2693@hacking>
	<200801171911.16230.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801171911.16230.m.kozlowski@tuxland.pl>
Subject: Re: [uml-devel] [-mm Patch] uml: fix a building error
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
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>

On Thu, Jan 17, 2008 at 07:11:13PM +0100, Mariusz Kozlowski wrote:
> I see this on sparc64 as well:
> 
>   CC      drivers/char/mem.o
> drivers/char/mem.c: In function 'read_mem':
> drivers/char/mem.c:136: error: implicit declaration of function 'unxlate_dev_mem_ptr'
> make[2]: *** [drivers/char/mem.o] Error 1
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
> 
> Does sparc64 need similar fix?

Probably - it seems that xlate_dev_mem_ptr can now introduce
side-effects which need to be undone with unxlate_dev_mem_ptr.

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
