Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IZtyI-000875-UV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 12:51:59 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IZtyB-0004PU-CP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 12:51:53 -0700
Date: Mon, 24 Sep 2007 15:50:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070924195047.GA25202@c2.user-mode-linux.org>
References: <5A9C383ECECEEE4F82BD5E7DCCD318E9C570CC@MABOSEVS1.ets.enterasys.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5A9C383ECECEEE4F82BD5E7DCCD318E9C570CC@MABOSEVS1.ets.enterasys.com>
Subject: Re: [uml-devel] sigwinch in 2.6.14.7 UML
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
To: "Bradshaw, James" <jbradsha@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 21, 2007 at 05:18:11PM -0400, Bradshaw, James wrote:
> Sigwinch appears to trigger a panic in 2.6.14.7. Here's the GDB
> backtrace

I realize that you probably specifically need a 2.6.14 kernel, but
that's so old (kernel.org says Oct 2005) that it'll be hard to find
someone interested in figuring out what's wrong with it.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
