Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwVcH-0004YC-Df for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 17:17:05 -0800
Received: from ktown.kde.org ([131.246.103.200])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CwVcG-00084R-O7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 17:17:05 -0800
Message-ID: <20050203011703.30244.qmail@ktown.kde.org>
From: Jeremy Fitzhardinge <jeremy@goop.org>
Reply-To: 98444@bugs.kde.org
Content-Type: text/plain; charset="utf-8"   
In-Reply-To: <20050202220205.98444.das_deniz@yahoo.com>  
Subject: [uml-devel] [Bug 98444] valgrind fails to run against user-mode-linux
	(UML) process - clone
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
Date: 3 Feb 2005 01:17:03 -0000
To: user-mode-linux-devel@lists.sourceforge.net

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
         
http://bugs.kde.org/show_bug.cgi?id=98444         




------- Additional Comments From jeremy goop org  2005-02-03 02:17 -------
Hm, nothing obvious sticks out.  That clone() is basically just a fork() with no special options, which Valgrind has supported for a long time, so I'm not sure what's going on there.  The warnings about tlsinfo and *_tidptr are spurious.

It seems the child process just jumps to 0x7 as soon as it starts running...

Is there any difference with --tool=none?

BTW, you're still going to get bitten by stack switching with memcheck and addrcheck.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
