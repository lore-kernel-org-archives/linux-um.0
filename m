Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AR1e6-0007f7-9m
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 19:56:18 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AQxlV-0007i4-Es
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 15:47:41 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0312011133210.12325-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0312020036530.16157-100000@filer.marasystems.com>
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
Date: Tue, 2 Dec 2003 00:47:17 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Mon, 1 Dec 2003, Henrik Nordstrom wrote:

> I have got so far that it looks like the pte is not modified making me 
> suspect that there is a old page mapping around initially maybe not 
> maching the pte after the call to vmalloc().

This has now been confirmed.

I instrumented the kernel with a few printk both in the iptables code 
telling when the new table is vmalloc():ed, copied into etc and the 
mmap/munmap calls to the host and when the iptables command fails there is 
no mmap of the newly vmalloc:ed area when copying the table from 
userspace, and the area only gets correcly mapped to the current pte value 
on the next tlb flush.

Now remains to figure out why the mapping of the old page is still 
around and why the tlb mappings has not been synched.

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
