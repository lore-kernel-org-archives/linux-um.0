Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARFQT-0006fy-TH
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 10:39:09 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARFQT-0006lo-6D
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 10:39:09 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <20031202164257.GA24954@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312021928070.28431-100000@filer.marasystems.com>
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
Date: Tue, 2 Dec 2003 19:39:03 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 2 Dec 2003, Jeff Dike wrote:

> Right, this is because of the kernel existing in multiple host address 
> spaces on the host in tt mode, and the kernel VM area needing to be kept
> in sync between them.

I suppose this is done on every context switch?

How is SMP handled?

> The idea is to avoid unecessary mmapping and munmapping on context switches
> if the kernel VM area hasn't changed since the process last ran.

This I understood, but it seems the assumptions on how to detect if the VM
area has changed or not when vmalloc/vfree is used is false, at least in 
case of vfree().

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
