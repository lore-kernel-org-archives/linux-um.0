Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4kYA-0005CC-UP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:18:38 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C4kY8-00078n-D7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:18:38 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Current state of UML - some help needed from mainline.
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<413B76DB.5010600@pobox.com>
	<200409061956.34557.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409061956.34557.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072013.49494.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Sep 2004 20:13:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

For LKML: I'm not subscribed, so don't forget to CC me.
On Monday 06 September 2004 19:56, BlaisorBlade wrote:
> On Sunday 05 September 2004 22:28, Jeff Garzik wrote:
> > Overall I am really impressed.  Like other arches in the Linux kernel,
> > it is IMO very important to be able to work "out of the box", without
> > patches.
Yes - especially when microAPI changes happen every day, as of 2.6. I've just 
downloaded a snapshot including the merge, so I'll be able to merge some 
little fixes which have happened since.

Do you think that keeping a UML tree for new, experimental features is a good 
idea, or that this role should go to -mm?

I ask this also because I don't know how much would help general review for 
new features.

For instance, the "hostfs" feature is in the middle of a rewrite and the new 
code is still very broken (the current release says more or less "VFS: busy 
inodes after unmount - self destroying in 5 seconds. Have a nice day", but 
maybe this is fixed; plus has a number of other bugs).

Also, SMP hasn't compiled for a while, so there is a number of locking problem 
- at least one straight deadlock in the ubd driver when passing ubd=sync. 
It's not a hard problem - just not yet fixed it.
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
