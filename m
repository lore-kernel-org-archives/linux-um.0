Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsAdP-0002Ab-Fw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 20:41:07 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsAdO-0008UE-75
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 20:41:07 -0700
Received: from [192.168.1.103] (lori.theshore.net [69.245.15.49])
	by www.theshore.net (8.13.6/8.9.1) with ESMTP id k5J3f4gE030568
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 23:41:04 -0400
Message-ID: <44961CC8.1060302@theshore.net>
Date: Sun, 18 Jun 2006 22:40:56 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: [uml-devel] 2.6.17-um - new uptime record (40 years!)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

root@none:~ # uname -a
Linux none 2.6.17-linode20 #1 Sun Jun 18 00:04:18 EDT 2006 i686 GNU/Linux
root@none:~ # uptime
  23:37:50 up 14663 days, 20:54,  1 user,  load average: 0.00, 0.00, 0.00
root@none:~ # cat /proc/uptime
1266958484.15 69449.04

-Chris


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
