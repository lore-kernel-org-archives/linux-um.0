Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C42uO-0003xc-4X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:40 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C42uJ-0001HY-Ve for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200408142332.22142.blaisorblade_spam@yahoo.it>
	<200408201509.i7KF9DIF002475@ccure.user-mode-linux.org>
In-Reply-To: <200408201509.i7KF9DIF002475@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409051841.26826.blaisorblade_spam@yahoo.it>
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
Date: Sun, 5 Sep 2004 18:41:26 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 20 August 2004 17:09, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > About this hunk of the patch, sorry. I tested the patch well, then I
> > added  this part without testing, and understood this a lot of time
> > after. Sorry.  Since CONFIG_KERNEL_STACK_ORDER is usually 2,
> > THREAD_SIZE becomes 16k (I've  just realized this). So this hunk is
> > wrong. The rest works very happily.
>
> BTW, I just got rid of thread.kernel_stack since it wasn't really needed
> for anything.  So that code is gone, plus some more in other places.
Yes, and I've seen you saying that the "kernel stack overflow" message is 
useless because it will never run, since the stack overflowed and then 
removing it altogether. Well, would you give a look at the various "kernel 
stack overflow" messages appearing from various users? Simply search on the 
ML archives (especially uml-user) to find them.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
