Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGgnB-0001qN-3v	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 10:48:01 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGgn9-0003Vn-S3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 10:48:01 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: Fixed - copy_from_user(dest, -1,...) hangs in TT mode (was: Re:
	[uml-devel] weak check of access_ok may lead hang!)
Message-ID: <20050917170052.GB5225@ccure.user-mode-linux.org>
References: <20050916104057.77345.qmail@mail35-142.sinamail.sina.com.cn>
	<200509171734.36738.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509171734.36738.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 17 Sep 2005 13:00:52 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: luothing@sina.com, user-mode-linux-devel@lists.sourceforge.net

BTW, that ldt patch can go straight to mainline if it's not on its way
already.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
