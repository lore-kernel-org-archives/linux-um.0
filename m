Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040725001114.GA13469@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Incremental patches available
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
Date: Sat, 24 Jul 2004 20:11:14 -0400
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

As part of my redoing how I work on UML, I've started using quilt to
maintain the changes going into a UML release as a set of discrete
patches.  Among other things, this lets me publish the patches that
have gone into my working tree before they are released as part of a
full UML patch.  See http://user-mode-linux.sourceforge.net/patches.html

There is one patch there, fixing something somewhat tangential (an
iomem bug exposed by the test suite, of which more later), letting me
figure out the new process.  This will be updated fairly frequently,
by cron or something.

This will greatly shrink the window in which someone can else find and
fix a bug, and send me a patch, while I, unbeknownst to anyone else,
have fixed the same bug.  Of course, this won't stop people who don't
look at that page, but at least the information is available.

It should also help UML stability by allowing people to test patches
between UML releases, so that they should be right by the time they
are released officially.

Finally, I'm going to have the release changelogs include the patches
that went into the release.  That will enable people who find some new
breakage to back out patches one by one until the breakage goes away.
A lot more people will be able to do useful debugging, since no
technical skills beyond running patch and rebuilding UML will be
required.

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
