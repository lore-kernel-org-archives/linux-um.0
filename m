Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdyQr-0000ip-1H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 13:08:09 -0800
Received: from mx15.sac.fedex.com ([199.81.197.54])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AdyQq-0007ED-HU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 13:08:08 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx15.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i06L7wdM096524
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 6 Jan 2004 15:07:58 -0600 (CST) (envelope-from jchua@fedex.com)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
In-Reply-To: <a0602040ebc20d1fee774@[192.168.1.10]>
Message-ID: <Pine.LNX.4.58.0401070444370.1840@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>     
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
	<a0602040ebc20d1fee774@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 7 Jan 2004 04:47:45 +0800 (SGT)
To: Johannes Formann <johannes@formann.de>
Cc: Jeff Chua <jchua@fedex.com>, stian@nixia.no, BlaisorBlade <blaisorblade_spam@yahoo.it>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


untar linux-2.4.24.tar.bz2
cd uml
bzip2 -d -c /tar/uml/uml-patch-2.4.23-1.bz2 | patch -p1
patch -p1 </tar/uml/uml-patch-2.4.23-3 (my patch)
make mrproper ARCH=um
make menuconfig ARCH=um
make depend ARCH=um
make clean ARCH=um
make linux ARCH=um
make modules ARCH=um




Thanks,
Jeff
[ jchua@fedex.com ]

On Tue, 6 Jan 2004, Johannes Formann wrote:

> At 3:34 Uhr +0800 07.01.2004, Jeff Chua wrote:
>
> >Can you please try to see the patch below solve your problem?
> >--- uml/drivers/char/mem.c.org	Wed Jan  7 03:30:40 2004
> >+++ uml/drivers/char/mem.c	Wed Jan  7 03:31:47 2004
> >@@ -269,3 +269,3 @@
> >  	}
> >-	*ppos = __pa((void *) p);
> >+	*ppos = p;
> >  	return virtr + read;
>
> This single Line doesn't solve my problem, or should I use it
> aditionaly to an other patch?
>
> Or shall I compile the Kernel with debigsymbols, so I can get an
> backtrace for you?
>
> regards
>
> Johannes
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
