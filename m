Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKkZO-0006n6-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 14 Nov 2003 12:29:30 -0800
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AKkZN-0002RS-HH
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 14 Nov 2003 12:29:29 -0800
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.24)
	id 1AKkZL-00027S-VE
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 14 Nov 2003 21:29:27 +0100
Received: from b2d86.b.pppool.de ([213.7.45.134] helo=home.petschge.de)
	by mx3.freenet.de with esmtp (Exim 4.24 #2)
	id 1AKkZK-0003tL-OW
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 14 Nov 2003 21:29:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 6BF4A3BCB8
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 14 Nov 2003 21:27:41 +0100 (CET)
Received: from mars (localhost [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 39C243BCB7
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 14 Nov 2003 21:27:40 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200311142127.39879.petschge@gmx.de>
Subject: [uml-devel] Shutdown bug
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
Date: Fri, 14 Nov 2003 21:27:39 +0100
Content-Transfer-Encoding: 8bit
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

sometime ago I posted a bug report regarding the 2.6.0-test3. When 
issuing a "shutdown" the uml guest would start to consume all CPU time 
available. I didn't trace this bug down but suspected that it was 
related to the bug that made "ifconfig eth0 down" freeze. Now I tested 
this again with 2.6.0-test9 and I noted that the bug still occurred. 
But then I tested with a second filesystem that contains not the usual 
gnu tools but busybox tools. And there this bug does _not_ happen. The 
shutdown succeeds and the uml terminates as it is expected to. Any help 
in tracing this down would be welcome. It would be most helpfull if you 
can reproduce this bug with a 2.6.0-test? kernel running on "real" 
hardware.

mfg,
Patrick "Petschge" Kilian




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
