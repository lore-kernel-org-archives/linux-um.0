Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3LhR-0000CV-2l for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 14:34:25 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3LhP-0004n8-ES for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 14:34:24 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C3LhN-0003sb-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 03 Sep 2004 23:34:21 +0200
Received: from p508a55dc.dip.t-dialin.net ([80.138.85.220])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 03 Sep 2004 23:34:21 +0200
Received: from skoehler by p508a55dc.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 03 Sep 2004 23:34:21 +0200
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <chao0q$ajs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML hanging while deactivating swap
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
Date: Fri, 03 Sep 2004 23:34:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

ubd1 of my UML is a swapfs, and when halting or rebooting it, it hangs 
while the swap is deactivated (i guess swapoff -a is executed).

I'm using 2.6.6-um1

Thx
   Sven



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
