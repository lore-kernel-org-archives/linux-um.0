Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDBjd-0007VE-N4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 17:57:21 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CDBjS-0001Mv-1x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 17:57:21 -0700
Message-Id: <200410010203.i9123XqR004647@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] No rule to make target
	`arch/um/os-Linux/sys-i386/registers.c' 
In-Reply-To: Your message of "Thu, 30 Sep 2004 15:49:34 BST."
	<415C1CFE.3010405@microbus.com> 
References: <415C1CFE.3010405@microbus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 30 Sep 2004 22:03:33 -0400
To: Robbie Dinn <robbie@microbus.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

robbie@microbus.com said:
> make[2]: *** No rule to make target  `arch/um/os-Linux/sys-i386/
> registers.c', needed by  `arch/um/os-Linux/sys-i386/registers.o'.
> Stop. 

Oops, missed a 'quilt add'.  It's fixed now.

> I did
> cp arch/um/os-Linux/sys-i386/registers.c  arch/um/os-Linux/sys-x86_64/
> registers.c
> then recompiled, and it build OK. The UML kernel even booted too! 

Presumably you copied in the other direction.

Anyway, that's what would be called an unsupported configuration :-)

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
