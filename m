Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5BvP-0006lx-0H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:32:27 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5BvM-0006c0-LQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:32:26 -0700
Message-Id: <200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.6.7-2 
In-Reply-To: Your message of "Sun, 05 Sep 2004 17:35:36 +0200."
	<200408251746.53523.blaisorblade_spam@yahoo.it> 
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it> 
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
Date: Wed, 08 Sep 2004 20:35:34 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> * First, please do a "make clean" before releasing the patch. There
> are some  binaries included in it! And also semaphore.c, which is a
> symlink normally. 

I do.  It's just that make clean didn't catch everything.

> * About filehandle_switch: you deleted a line (probably by mistake).
> Reread  more carefully the separate patches you get with quilt: when
> you see the  other attached patch (uml-restore-lost-code.patch),
> you'll agree with me. 

Yuck, I have no idea how that happened.

> However, IMHO, since you cannot close and reopen a pipe, it's
> braindead that  the switch_pipe[] array is an array of filehandles.

Yeah, this is fixed in my 2.6 tree now.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
