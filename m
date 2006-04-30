Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaF8c-00010n-Ke for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 09:51:14 -0700
Received: from host2-39.pool8261.interbusiness.it ([82.61.39.2]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaF8a-0004Ox-B8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 09:51:14 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430153326.27676.64906.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 0/2] Fixes for umid code for 2.6.17
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
Date: Sun, 30 Apr 2006 17:33:26 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Sorry, I had forgot these two ones from previous series. I've found a bug in
startup code (related to new code in 2.6.17) and here's the fix - it is not a
"just fix this", there's a tiny bit of reorganization but not much (splitting
functions and changing their return conventions).

From stg series:

+ uml-not_dead_yet-remove-existing-dir   | uml: fix not_dead_yet when
	directory is in bad state
+ uml-rename-improve-actually_do_remove  | uml: rename and improve
	actually_do_remove()

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
