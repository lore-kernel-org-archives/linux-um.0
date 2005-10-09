Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOidx-0007dI-Mw	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 14:23:41 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOidz-0007mQ-NA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 14:23:45 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j99MsE4d024522
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 9 Oct 2005 18:54:15 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091623.34322.rob@landley.net>
Subject: [uml-devel] Blank process command lines in 2.6.13.2?
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
Date: Sun, 9 Oct 2005 16:23:34 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Running a big script under UML, I noticed this at the end of ps:

19869 pts/1    D+     0:03 tmpdir/linux rootfstype=hostfs rw quiet mem=48M 
DIR=/
19873 pts/1    S+     0:00 tmpdir/linux rootfstype=hostfs rw quiet mem=48M 
DIR=/
19874 pts/1    T+     0:00
19968 pts/1    T+     0:00
19979 pts/1    T+     0:00
19981 pts/1    T+     0:04
19983 pts/2    R+     0:00 ps ax

*boggle*

This expected?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
