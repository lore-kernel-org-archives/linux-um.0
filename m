Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1tcn-000615-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 13:19:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1tcm-0001xK-6F
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 13:19:04 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8NKA2j29537
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 16:10:03 -0400
Message-Id: <200309232019.h8NKJ0aK003265@ccure.karaya.com>
Subject: Re: [uml-devel] Re: compile problem with uml-patch-2.4.22-4 
In-Reply-To: Your message of "Sat, 20 Sep 2003 19:35:18 +0200."
             <20030920173518.521B03BCE7@home.petschge.de> 
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de>  <20030920173518.521B03BCE7@home.petschge.de> 
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
Date: Tue, 23 Sep 2003 16:19:00 -0400
To: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

petschge@web.de said:
> Perhaps it should not have a own CONFIG_ option but should be
> triggerd by CONFIG_SOFT_WATCHDOG. 

No, because it's a hardware watchdog.

> Jeff, is there a specific reason to
> give  UML_WATCHDOG a own option?

Yes, it's a separate driver.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
