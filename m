Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQCNu-0002XG-IC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 14:16:42 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQCNt-0000vi-NV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 14:16:42 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] con=port hangs uml guest when it trys to create
	mingettys for the ttyp's
In-Reply-To: <20041105201531.76855.qmail@web26105.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0411052313570.2017@filer.marasystems.com>
References: <20041105201531.76855.qmail@web26105.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Fri, 5 Nov 2004 23:16:29 +0100 (CET)
To: Roland Kaeser <roli8200@yahoo.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Nov 2004, Roland Kaeser wrote:

> I thunk that the con ports are "headless". So the guest os doesn't now that the
> other end of the tty has an monitor or something on it. The only strange behaviour
> is that after the first telneting session, the assignment of the tty is successful
> and the boot contiunues normally. Shouln't the "virtual" con ttyps act exactly as
> the "real" ones?

They differ in not always having a screen buffer available for output.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
