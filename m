Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uwyC-0002Ee-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 09:28:28 -0700
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uwy6-0008L6-RC
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 09:28:23 -0700
Received: from [194.97.50.144] (helo=mx1.freenet.de)
	by mout2.freenet.de with asmtp (Exim 4.21)
	id 19uwy4-00014r-QY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 18:28:20 +0200
Received: from b2b5c.pppool.de ([213.7.43.92] helo=home.petschge.de)
	by mx1.freenet.de with esmtp (Exim 4.22 #1)
	id 19uwy3-0002WS-RI
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 18:28:20 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 2D1B13BCE6
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu,  4 Sep 2003 17:06:07 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 994C03BCE4
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu,  4 Sep 2003 17:06:03 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200309041706.03045.petschge@gmx.de>
Subject: [uml-devel] 2.6.0 uptime bug
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
Date: Thu, 4 Sep 2003 17:06:03 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I found a bug in the 2.6.0-test? kernels. /proc/uptime shows a uptime 
since the start of the epoch, approx. 33 years.
Is anybody able to reproduce this bug?

mfg,
Patrick "Petschge" Kilian
--  
I still think the fastest way to get wholesale IPv6 adoption
is to write a pr0n server that serves thumbnails over IPv[46]
and full-size images over IPv6 only.              -- Ingvar



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
