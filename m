Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp99W-0000bB-06 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 10:20:42 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bp99V-0003Oz-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 10:20:41 -0700
Message-Id: <200407261818.i6QIIbfL001867@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [patch 1/1] Fix malloc-use-vmalloc 
In-Reply-To: Your message of "Thu, 22 Jul 2004 17:55:45 +0200."
	<200407221752.42186.blaisorblade_spam@yahoo.it> 
References: <20040704105632.DC0B378A@zion.localdomain>
	<200407131757.i6DHvZGu003047@ccure.user-mode-linux.org>
	<200407221752.42186.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 26 Jul 2004 14:18:37 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> 1) I think that the intervals don't include high_physmem and end_vm,
> so we  should have addr < ... instead of addr <=.

Yup.

> 2) Also, even worse, it seems ok until you read your comment. During
> the boot,  if random values are in the vars (and it's so until
> kmalloc_ok is turned on)  we can have malloc()ed memory thought of as
> kmalloc()ed or vmalloc()ed one,  and then leaked.

The comment was badly worded.

> 3) Solution to 2): if I am right about thing #1, then it should be
> enough to  set end_vm and high_physmem to 0 at startup (they are
> global vars, so it's  already true), once there are the < instead of
> <=. And don't say in the  comment that memory regions are not
> initialized. 

They are all globals, so they are initialized to 0.  It looks to me like
anything which hits that code before kmalloc is set up will correctly go
through the __real_free case.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
