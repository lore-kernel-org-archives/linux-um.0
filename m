Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BK1Qh-0003D1-PR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 13:49:47 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BK1Qh-00008Z-NH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 13:49:47 -0700
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.8/8.12.8) with ESMTP id i41KnkfI030375
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 1 May 2004 14:49:46 -0600
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.8/8.12.8/Submit) with ESMTP id i41KnkUd030372
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 1 May 2004 14:49:46 -0600
From: Frank Sorenson <frank@tuxrocks.com>
Message-ID: <Pine.LNX.4.44.0405011439220.30233-100000@tuxrocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] UML kernel panic
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
Date: Sat, 1 May 2004 14:49:46 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net

I'm getting a UML kernel panic whenever I run the j2eesdk (Java with EJB -
http://java.sun.com/j2ee/1.4/download.html#sdk) installer.  The panic is 
"Segfault with no mm".

I tried running the latest supported version (2.4.24-2), and I got several
backtraces of the crash:
http://sco.tuxrocks.com/uml/trace5.txt
http://sco.tuxrocks.com/uml/trace6.txt
http://sco.tuxrocks.com/uml/trace7.txt

The config file is at http://sco.tuxrocks.com/uml/config

Any ideas or suggestions?  Any help would be greatly appreciated.

Thanks,

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
