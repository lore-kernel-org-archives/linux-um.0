Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGcnz-0006oP-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 03 Nov 2003 03:23:31 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AGcny-0005SX-Gv
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 03 Nov 2003 03:23:30 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Partitioning scheme for ubd's
In-Reply-To: <200311011159.11435.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0311031214190.23240-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 3 Nov 2003 12:23:24 +0100 (CET)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 1 Nov 2003, BlaisorBlade wrote:

> 2) if I do an install, I can partition the ubd's; but then, I won't be able to 
> loop mount the file on the host

There is no problem to mount partitions of a larger device file on the
host. All you need to do is to note the start sector of the partition (and
size if you should want to newfs the partition). The easies way to read
the partition table from the host is to use sfdisk
   sfdisk -d /path/to/backingfile.img
then multiply the sector by 512 to get the starting offset of the 
partition for the loopback mount.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
