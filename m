Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARB7w-0007tP-L5
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 06:03:44 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AQwzN-0006sL-J9
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 14:57:57 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] process start time in future
In-Reply-To: <200311282042.09602.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0312012223560.15413-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 1 Dec 2003 23:57:51 +0100 (CET)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 28 Nov 2003, BlaisorBlade wrote:

> VMware is not free software and since it goes emulating hardware, it should 
> have more overhead; said that, I have no benchmark to show this. But if UML 
> were slower, it would only need tuning. Note that normally, UML memory is put 
> on a disk file, so it IS slower. But if you put /tmp on tmpfs(i.e. in RAM), 
> this goes away.

This is not one of the major bottlenecks of UML.

How it manages the virtual memory may be based on what I am seeing when 
trying to debug my memory management related issue with iptables-restore 
failing..

The disk I/O drivers in UML is a sad chapter and is a major bottleneck
(both ubd and hostfs), but at the same time is not beyond repair. The
reason to this is manly the lack of reasonable async io methods on the 
host..

The number of context switches required on the host for servicing a system
call within the UML is also a major bottleneck, but is something which
Jeff is agressively trying to address with SKAS.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
