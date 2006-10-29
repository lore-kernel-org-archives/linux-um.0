Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGCs-00068T-CU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:30 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGCo-0007LS-Nc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:30 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:17:23 +0100
Message-Id: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 00/11] UBD driver little cleanups for 2.6.19
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Many cleanups for the UBD driver; these are mostly microfixes, I was waiting to
finish and reorder also locking fixes (the code works, it is only to resplit,
reproof-read and changelogs must be written) but I decided to send these ones
for now. The rest will maybe be merged for 2.6.20.

The only locking change is a conversion of a spinlock to a mutex, but it is
correct anyway, and it has been tested (which is enough since it relates
just to the setup/teardown path) with all debugging options active; I did
boot-test and hotplug/hotunplug test.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
