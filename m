Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxmPi-0002M8-HD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 05:53:06 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxmPh-0007OB-0u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 05:53:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id C693821760
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Aug 2004 14:52:55 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02860-40
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Aug 2004 14:52:54 +0200 (CEST)
Received: from [10.0.6.6] (pD9F63232.dip.t-dialin.net [217.246.50.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 6B357151
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Aug 2004 14:52:54 +0200 (CEST)
Message-ID: <4124A2C3.7040004@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] debugging a 2.6.7-2 booting problem
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
Date: Thu, 19 Aug 2004 14:53:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,


I have booting problems with 2.6.7-um2+sysemu.

host ist 2.6.7
host and client : debian sarge.


I did run uml under gdb (with 'break panic'), but cannot get a backtrace.
Can anyone help me ?


-------------------------------------------------------------
Starting kernel log daemon: klogd.
Starting MTA: exim4.
Starting MySQL database server: mysqld.
Starting Samba daemons: nmbd smbdKernel panic: Kernel stack overflow
 Detaching after fork from child process 18722.


Program exited with code 01.
(gdb) bt
No stack.
(gdb)
-------------------------------------------------------------



/sebastian


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
