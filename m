Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByA3A-0005Va-Rr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 07:07:24 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1ByA38-0002m7-I8
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 07:07:24 -0700
Message-Id: <200408201509.i7KF9DIF002475@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit 
In-Reply-To: Your message of "Tue, 17 Aug 2004 17:40:51 +0200."
	<200408142332.22142.blaisorblade_spam@yahoo.it> 
References: <40E0036D.2070108@sysgo.de>
	<200407012133.16289.blaisorblade_spam@yahoo.it>
	<200407032025.52944.blaisorblade_spam@yahoo.it>
	<200408142332.22142.blaisorblade_spam@yahoo.it> 
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
Date: Fri, 20 Aug 2004 11:09:13 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> About this hunk of the patch, sorry. I tested the patch well, then I
> added  this part without testing, and understood this a lot of time
> after. Sorry.  Since CONFIG_KERNEL_STACK_ORDER is usually 2,
> THREAD_SIZE becomes 16k (I've  just realized this). So this hunk is
> wrong. The rest works very happily. 

BTW, I just got rid of thread.kernel_stack since it wasn't really needed
for anything.  So that code is gone, plus some more in other places.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
