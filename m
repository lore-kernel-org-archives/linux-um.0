Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2ol6-0007L5-8q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 03:24:00 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C2ol5-0003vK-Od for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 03:24:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 820D222E70
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Sep 2004 12:23:53 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11832-38
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 2 Sep 2004 12:23:52 +0200 (CEST)
Received: from [10.0.6.6] (pD9F623FB.dip.t-dialin.net [217.246.35.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 4D2AD22BDA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Sep 2004 12:23:52 +0200 (CEST)
Message-ID: <4136F4C8.4040905@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] crash with uml-2.6.8.1-um1
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
Date: Thu, 02 Sep 2004 12:24:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

this happend on an apache restart :

------------------------------------------------------------------------------
kernel panic: Kernel stack overflow
 ---Type <return> to continue, or q <return> to quit---Detaching after 
fork from child process 7918.


Program exited with code 01.
(gdb) bt
No stack.
(gdb)  
-------------------------------------------------------------------------------

I did NOT pressed q or return, when I reatachted to the screen running 
gdb it was actually at the gdb prompt.

I know that this does not help to find the problem, what can I do ?
How to produce a stacktrace ?

Do I need to set a gdb option to not detaching from forks ?

/sebastian


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
