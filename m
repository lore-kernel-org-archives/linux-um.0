Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRu44-0002Ij-67 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 09:44:04 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRu43-0006vF-Oy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 09:44:04 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060407154514.GB4911@ccure.user-mode-linux.org>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
	<20060407143110.19201.91963.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407143110.19201.91963.stgit@zion.home.lan>
Subject: [uml-devel] Re: [PATCH 09/17] uml: fix critical typo for TT mode
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
Date: Fri, 7 Apr 2006 11:45:14 -0400
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Apr 07, 2006 at 04:31:10PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Noticed this for a compilation-time warning, so I'm fixing it even for TT mode -
> this is not put_user, but copy_to_user, so we need a pointer to sp, not sp
> itself (we're trying to write the word pointed to by the "sp" var.).
> 
> Jeff, have I misunderstood anything?

No, you're right.  Al spotted this as well, and I have this fix in my tree.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
