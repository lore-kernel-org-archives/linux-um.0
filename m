Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAV5m-00026Z-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 06:56:34 -0700
Received: from dhcp126.ists.dartmouth.edu ([129.170.249.226] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAV4G-0006Z9-Vt
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 06:55:01 -0700
Message-Id: <200310160148.h9G1mY63001573@uml.karaya.com>
Subject: Re: [uml-devel] Hardening hostfs 
In-Reply-To: Your message of "Fri, 17 Oct 2003 10:26:54 +0200."
             <Pine.GSO.4.21.0310171026070.22754-100000@waterleaf.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 15 Oct 2003 21:48:34 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter <peter@rimuhosting.com>, Doug Dumitru <doug@easyco.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

geert@linux-m68k.org said:
> But you can still access /dev/mem from UML userspace and do whatever
> you want. 

Not if you remove CAP_SYS_RAWIO from the bounding capability set.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
