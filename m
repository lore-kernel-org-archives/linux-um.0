Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXVzE-0005Gf-NO
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 17:32:56 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXVzE-0006MN-Bk
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 17:32:56 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AXVzB-0008Gy-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Dec 2003 02:32:53 +0100
From: Jason Lunz <lunz@falooley.org>
Message-ID: <slrnbu79m4.a5h.lunz@orr.homenet>
References: <20031219212840.GA8203@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: uml-patch-2.4.23-1
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 20 Dec 2003 01:32:52 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

jdike@addtoit.com said:
> This patch updates UML to 2.4.23.  The only change required by 2.4.23
> was the ELF_PLAT_INIT that other people saw and fixed.

um, there's also some problem if you compile the uml kernel with SMP
because of the NUM_CPUS stuff in 2.4.23.

Jason



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
