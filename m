Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQZDS-0002vc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 30 Nov 2003 13:34:54 -0800
Received: from law10-f99.law10.hotmail.com ([64.4.15.99] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AQZDS-0002b3-EZ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 30 Nov 2003 13:34:54 -0800
From: "derry shribman" <derrysh@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F99ny3O76JOTB00020380@hotmail.com>
Subject: [uml-devel] Valgrinding Linux kernel with UML
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
Date: Sun, 30 Nov 2003 23:34:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I have been using valgrind for quite a while, and found it to be very useful 
for my user-mode Linux programming.
I therefore tried getting valgrind to work on the Linux Kernel, with UML.

I did a few quick hacks:
- getting valgrind it to know UML's kmalloc/kfree and friends
- canceling the sanity check valgrind performs upon loading an image, in 
which it checks the image base address (since UML loads the kernel at a 
different virtual start address than regular applications start address).

Still - valgrind+UML crashed immediately.

Did anyone try out valgrind+UML?

Thanks,
Derry

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
