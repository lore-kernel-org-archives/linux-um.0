Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wr3P-0003Gf-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 15:33:43 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wr3O-0002SN-KF
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 15:33:42 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h89MPmj16486
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 9 Sep 2003 18:25:48 -0400
Message-Id: <200309092233.h89MXO2J005300@ccure.karaya.com>
Subject: Re: [uml-devel] "Kernel panic: Segfault with no mm" 
In-Reply-To: Your message of "Tue, 09 Sep 2003 21:34:37 +0200."
             <20030909193437.GE10485@marowsky-bree.de> 
References: <20030909180126.GC10485@marowsky-bree.de> <200309091914.h89JE6ja000983@car.linuxhacker.ru>  <20030909193437.GE10485@marowsky-bree.de> 
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
Date: Tue, 09 Sep 2003 18:33:24 -0400
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Oleg Drokin <green@linuxhacker.ru>, user-mode-linux-devel@lists.sourceforge.net

lmb@suse.de said:
> But on the host, I'd get a panic which said which kernel module caused
> it etc. Is that not to be expected in UML? 

UML is lacking some of the debugging stuff present in the other ports.  No
big problem to add, but I haven't seen any pressing need for it.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
