Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C43d7-0005jA-0f for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 13:28:53 -0700
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C43d6-00007N-IM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 13:28:52 -0700
Message-ID: <413B76DB.5010600@pobox.com>
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it>
In-Reply-To: <200408251746.53523.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Current state of UML
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
Date: Sun, 05 Sep 2004 16:28:11 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Just a FWIW...

Using the latest UML code in 2.6.x BitKeeper (2.6.9-rc1-bk), things are 
looking pretty darn good.  I was able to boot a Fedora Core userland 
with "init=/bin/sh", set up networking easily [uml_net helper worked], 
and ssh into my virtual host.

To problems, one major and two minor:

(major)
1) Using standard Fedora Core SysvInit, rc.sysinit will proceed to 
completion, then the userland boot halts.  ps shows the virtual host's 
/sbin/init process in constant run state, chewing CPU time like mad. 
Didn't investigate further, simply booted with init=/bin/sh and moved on.

(minor)
2) The Makefiles appear to add "-um1" to the kernel version for some 
reason, and IMHO violates the Principle of Least Surprise.  This breaks 
several of my scripts :(

3) The arch/um build is verbose, showing each gcc command line as it is 
executed.  This is incorrect when KBUILD_VERBOSE or similar setting are 
not enabled.  As a result, the arch/um is verbose, but the rest is not, 
by default.

Overall I am really impressed.  Like other arches in the Linux kernel, 
it is IMO very important to be able to work "out of the box", without 
patches.

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
