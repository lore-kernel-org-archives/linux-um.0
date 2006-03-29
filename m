Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOQ9t-0003hv-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 18:11:41 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOQ9r-0003nX-UX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 18:11:41 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060329021253.GA25000@ccure.user-mode-linux.org>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
Subject: [uml-devel] Re: [PATCH 0/7] UML TLS support [for 2.6.17]
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
Date: Tue, 28 Mar 2006 21:12:53 -0500
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 29, 2006 at 01:54:42AM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> This is UML support for TLS, which allows one to fully use NPTL glibc,
> finally, on a 2.6 host (either x86 or x86_64). This has been happily tested 
> by many users and by us for some times and we've now fixed all known bugs, 
> and tested with different glibc's. So this code can IMHO be merged finally.

Acked-by: Jeff Dike <jdike@addtoit.com>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
