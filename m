Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uCt5-000596-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 08:16:07 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uCt4-0000BW-Gw
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 08:16:06 -0700
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.21)
	id 19uCsw-0005Gf-JK
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 17:15:58 +0200
Received: from b2aa5.pppool.de ([213.7.42.165] helo=home.petschge.de)
	by mx3.freenet.de with esmtp (Exim 4.21 #5)
	id 19uCsv-0001cB-Cb
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 17:15:58 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id D9E913BC57
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue,  2 Sep 2003 12:20:14 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id AF8723BC56
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue,  2 Sep 2003 12:20:13 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200309021220.13334.petschge@gmx.de>
Subject: [uml-devel] run away 2.6.0
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
Date: Tue, 2 Sep 2003 12:20:13 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I found a problem with the 2.6.0-test2 and 2.6.0-test3 kernels. Both 
kernels are clean sources from ftp.kernel.org patched with the 
coresponding patches from user-mode-linux.sourceforge.net. With both 
kernels I did make xconfig ARCH=um and make linux ARCH=um. Startup work 
without a problem and the running uml guest works like a charm. But 
when I issue a "uml# shutdown -n -h now" the cpu load jumps to 100% 
after some seconds and stays up till I kill the uml guest.

Is this a known bug? Is this possibly a error in the .config file? How 
should I proceed to track this bug down?
By the way I' using minit written by Felix von Leitner and not the 
normal System V init.

mfg,
Patrick "Petschge" Kilian

PS: If you need further information like the .config file, just ask for 
it.

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
