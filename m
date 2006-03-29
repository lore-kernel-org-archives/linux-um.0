Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOgP1-0008Vt-Mh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 11:32:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOgOz-0004s3-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 11:32:23 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Integer overflows in new AIO ubd driver
Message-ID: <20060329193324.GC4940@ccure.user-mode-linux.org>
References: <1143398965.11224.146.camel@localhost.localdomain>
	<20060327153832.GB3666@ccure.user-mode-linux.org>
	<1143474452.11224.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143474452.11224.150.camel@localhost.localdomain>
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
Date: Wed, 29 Mar 2006 14:33:24 -0500
To: Gerd Stolpmann <info@gerd-stolpmann.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 27, 2006 at 05:47:31PM +0200, Gerd Stolpmann wrote:
> I used iozone in various ways. The simplest workload leading to problems
> was:
> 
> - Write a 5GB file
> - Write it again
> - Read it back
> - Read it back
> 
> This benchmark ran fine the first time I started it. When I started it
> again, UML locked up in the middle. This is reproducible.

I'm interpretting that description as being this command:
	iozone -s 5G -i 0 -i 0 -i 1 -i 1

Yes?

And it runs fine here.

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
