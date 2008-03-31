Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgLC8-0006Hi-HV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:41:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgLC7-0007Ag-1e
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:41:08 -0700
Date: Mon, 31 Mar 2008 10:40:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080331144058.GE6540@c2.user-mode-linux.org>
References: <47E16C87.8080705@plauener.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47E16C87.8080705@plauener.de>
Subject: Re: [uml-devel] small patch for small install problem of	uml_utilities
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
To: Christian Krause <chkr@plauener.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 19, 2008 at 08:41:59PM +0100, Christian Krause wrote:
> During packaging of uml_utilities I've found a small problem during 
> "make install":

> -       install -o 0755 $(BIN) $(DESTDIR)$(BIN_DIR)
> +       install -m 0755 $(BIN) $(DESTDIR)$(BIN_DIR)

Looks right, thanks.

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
