Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Arkeh-0001Vx-J5
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 13:15:23 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArkZd-0003vf-69
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 13:10:09 -0800
Message-Id: <200402132140.i1DLeUsq003451@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 27 Jan 2004 16:56:00 +0300."
             <16406.28144.943056.461426@laputa.namesys.com> 
References: <16406.28144.943056.461426@laputa.namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH]: 2.6.2-rc2: kill arch/um/sys-i386/extable.c
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 16:40:30 -0500
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: user-mode-linux-devel@lists.sourceforge.net

Nikita@Namesys.COM said:
> 2.6.2-rc2 moved search_extable() into generic code (lib/extable.c), so
> there is no need to duplicate i386's version in the UML. 

It's gone now, thanks.

			Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
