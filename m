Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4NnP-0008P9-Kz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:00:51 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C4NnM-0005hp-V7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:00:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Current state of UML
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it>
	<413B76DB.5010600@pobox.com>
In-Reply-To: <413B76DB.5010600@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409061956.34557.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Sep 2004 19:56:34 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jeff Dike <jdike@addtoit.com>

On Sunday 05 September 2004 22:28, Jeff Garzik wrote:
> Just a FWIW...

Thanks a lot anyway! We need eagerly mainline developer which help us, in any 
way (even comments).

> Using the latest UML code in 2.6.x BitKeeper (2.6.9-rc1-bk), things are
> looking pretty darn good.  I was able to boot a Fedora Core userland
> with "init=/bin/sh", set up networking easily [uml_net helper worked],
> and ssh into my virtual host.

> To problems, one major and two minor:

> (major)
> 1) Using standard Fedora Core SysvInit, rc.sysinit will proceed to
> completion, then the userland boot halts.  ps shows the virtual host's
> /sbin/init process in constant run state, chewing CPU time like mad.
> Didn't investigate further, simply booted with init=/bin/sh and moved on.

> (minor)
> 2) The Makefiles appear to add "-um1" to the kernel version for some
> reason, and IMHO violates the Principle of Least Surprise.  This breaks
> several of my scripts :(

Yes, this should not have gone in mainline (it made sense when releasing 
separate UML patches). I'm queueing the fix to Andrew Morton.

I guess that future separate UML patches (just for updates) will have to 
insert their extraversion to Makefile rather than arch/um/Makefile.

> 3) The arch/um build is verbose, showing each gcc command line as it is
> executed.  This is incorrect when KBUILD_VERBOSE or similar setting are
> not enabled.  As a result, the arch/um is verbose, but the rest is not,
> by default.
There is a ton of problems with kbuild in UML - actually it must build a lot 
of files against userspace headers, and there isn't a kbuild support for 
that. This means for instance that files are not rebuilt when CONFIG_* 
changes, when a header changes and so on.

I've just implemented a patch which simply makes the output nice, but I'm not 
sure whether it should be included.

Some time ago I implemented a rough version of a good patch (which fixed all 
the above problems, but in an unclean way), but nobody liked it, and moreover 
Jeff Dike said that:
1) he did not want to modify kbuild for UML only

2) he was going to build an abstraction layer, which would build with 
userspace includes and would be restricted to arch/um/os-*/, and then the 
Makefile hacks would have been done only for that folder.

> Overall I am really impressed.  Like other arches in the Linux kernel,
> it is IMO very important to be able to work "out of the box", without
> patches.

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
