Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtdU1-0008OF-6L
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 18:00:09 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AtdP1-0001ni-P7
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 17:55:00 -0800
Message-Id: <200402190223.i1J2NBMM009529@ccure.user-mode-linux.org>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4 
In-Reply-To: Your message of "Wed, 18 Feb 2004 02:52:56 +0100."
             <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp> 
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402152045.17138.blaisorblade_spam@yahoo.it>  <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp> 
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
Date: Wed, 18 Feb 2004 21:23:11 -0500
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>, dan@shearer.org, christopher_sf@yahoo.com

for_spam@gmx.de said:
> if someone wants to test - the rh7.2 compiled (and for me also
> failing) binary is at: http://www.my-vserver.de/uml-2.6.3-rc2.gz 

As other people have noticed, this is host-dependent somehow.  This image
boots fine on my RH8 laptop.

> in ./kernel/sched.c in function wait_for_completion(struct completion
> *x) 

I got similar information from Phil Nadeau, so it's good to confirm that.

Has anyone seen this with a 2.4 UML?  That would be handy because this broke
in 2.6 when I moved a major set of patches to my 2.6 tree.  2.4 is much more
granular, so knowing which 2.4 patch broke it would narrow it down a lot more.
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
