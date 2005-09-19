Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHQu1-00026a-Eb	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 12:02:09 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EHQu0-0002k8-2F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 12:02:09 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050919190146.GW7762@shell0.pdx.osdl.net>
References: <20050919180231.358170000@zion.home.lan>
	<20050919180321.615510000@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919180321.615510000@zion.home.lan>
Subject: [uml-devel] Re: [patch 1/1] uml - Fix x86_64 page leak
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
Date: Mon, 19 Sep 2005 12:01:46 -0700
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* Paolo 'Blaisorblade' Giarrusso (blaisorblade@yahoo.it) wrote:
> We were leaking pmd pages when 3_LEVEL_PGTABLES was enabled. This fixes that,
> has been well tested and is included in mainline tree. Please include in -stable
> as well.

Added to -stable queue.

thanks,
-chris


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
