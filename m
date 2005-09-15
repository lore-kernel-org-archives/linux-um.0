Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG2th-00079E-G2	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 16:12:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG2tg-0005PF-0F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 16:12:05 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest
	segfaults
Message-ID: <20050915222851.GD9678@ccure.user-mode-linux.org>
References: <1126803951.5268.39.camel@localhost.localdomain>
	<20050915190633.GB8106@ccure.user-mode-linux.org>
	<1126820388.1391.4.camel@localhost> <1126823701.1391.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126823701.1391.7.camel@localhost>
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
Date: Thu, 15 Sep 2005 18:28:51 -0400
To: antoine <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Sep 15, 2005 at 11:35:01PM +0100, antoine wrote:
> after issuing a uml_mconsole N reboot, I got (from stdout):
> " * Starting local...  [ ok ]
> deactivate_all_fds failed, errno = 9
> 
> I/O possible"

Was this booting up or shutting down?  The "starting local" business
suggests booting, but deactivate_all_fds is only called at shutdown.

I'm chasing a similar bug, which seems to be exercised by hotplugging
devices.

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
