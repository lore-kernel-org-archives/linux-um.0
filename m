Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FY2jU-0002wE-UA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 08:12:12 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FY2jU-0005Wn-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 08:12:12 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FY2jS-0007Nl-0k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Apr 2006 08:12:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604231949.14949.blaisorblade@yahoo.it>
Subject: [uml-devel] uml doesn't like stack protection of GCC hardened
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
Date: Sun, 23 Apr 2006 19:49:13 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

Only once, I got the following error with an UML compiled with GCC hardened:

Configuring network interfaces...
Debug: sleeping function called from invalid context 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.16/mm/slab.c:2729
remove_umid_dir - actually_do_remove failed with err = -2

vmlinux-2.6.16.9-bs2-read_output: stack smashing attack in function 
start_idle_thread()

And UML exited.

That's surely a false positive, likely caused by setjmp() / longjmp() games, 
and I never saw it (but possibly other times it happened and I ignored it) - 
I have not had a _bad_ experience with the hardened GCC (I've written some 
patches to allow UML to compile with it, they'll be in -bs2 - it simply 
amounts to disabling -fpie and -fstack-protector for sensitive files).

However, I still wanted to inform you of this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
