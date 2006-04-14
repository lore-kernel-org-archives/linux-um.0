Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FURDi-0002UP-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 09:32:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FURDg-0000km-RA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 09:32:30 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060414153337.GA4152@ccure.user-mode-linux.org>
References: <7B4268E5ACB878429B58D4BE5B780E83507BC3@NWS-EXCH2.nws.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83507BC3@NWS-EXCH2.nws.oregonstate.edu>
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
Date: Fri, 14 Apr 2006 11:33:37 -0400
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Apr 14, 2006 at 08:39:01AM -0700, Brock, Anthony - NET wrote:
> I'm assuming that this pulls "UTC" from the host and allows the guest to
> have an offset "UTC" ... is this essentially correct?

Basically, yes.

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
