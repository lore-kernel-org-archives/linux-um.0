Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbTpi-0002qa-BC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 17:08:02 -0800
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CbTph-0005LU-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 17:08:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id E0E3E262C3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  7 Dec 2004 02:07:55 +0100 (CET)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00231-31
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 7 Dec 2004 02:07:55 +0100 (CET)
Received: from [10.0.2.5] (pD9E84E82.dip0.t-ipconnect.de [217.232.78.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 0E3D6258FF
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  7 Dec 2004 02:07:54 +0100 (CET)
Message-ID: <41B502CF.2010901@exse.net>
From: =?ISO-8859-15?Q?Sebastian_B=F6hm?= <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] crash of 2.4.27-bs1
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
Date: Tue, 07 Dec 2004 02:09:35 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

want to help you to fix this, but ont know to debug this ?
it happend only minutes after booting that machine. (apache is running 
on this machine delivering graphics produced via librsvg on-the-fly, the 
crash happed during a http request)
------------------------------------------------------------
 Kernel panic: Kernel stack overflow
 Detaching after fork from child process 7385.

---Type <return> to continue, or q <return> to quit---

Program exited with code 01.
(gdb) bt
No stack.
(gdb)
------------------------------------------------------------

/sebastian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
