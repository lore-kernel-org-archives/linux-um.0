Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asoxl-0006SU-FP
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 12:03:29 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Asou6-0004SI-9T
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:59:42 -0800
Message-Id: <200402162027.i1GKRTsq024349@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Segfault of UML-TT on FC1 
In-Reply-To: Your message of "Mon, 16 Feb 2004 02:50:11 EST."
             <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com> 
References: <20040215232525.7c2f38a8.zaitcev@redhat.com>  <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 16 Feb 2004 15:27:29 -0500
To: Ingo Molnar <mingo@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

mingo@redhat.com said:
> (but it would be nice to find the brk assumption in UML and change it
> to work with the FC1 brk changes.) 

I believe it has, and I believe it's fixed in the 2.4 release I made yesterday.

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
