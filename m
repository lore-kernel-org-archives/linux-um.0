Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG3eY-0007qH-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 13:51:26 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AG3eY-00058i-2t
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 13:51:26 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id hA1LpLF26413
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 1 Nov 2003 21:51:21 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id hA1LpHk6018608
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 1 Nov 2003 21:51:17 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id hA1LpGx01228
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 1 Nov 2003 21:51:17 GMT
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.GSO.4.58.0311012137370.355@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Sleeping process getting segfault signal
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 1 Nov 2003 21:51:16 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net

I have a reproduceable crash, at least with certain host kernels (eg.
from RedHat's current beta), and a 2.6 uml kernel, and get errors like
sleeping process 1786 got unexpected signal : 11
immediately after I type halt in a uml window. Does anyone know what might
be going on here, or how I might debug it further?

	Michael Young


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
