Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8ZLE-00072e-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 22:36:48 -0800
Received: from mx15.sac.fedex.com ([199.81.195.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B8ZLE-0007iC-In
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 22:36:48 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx15.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i2V6acGd097719
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Mar 2004 00:36:38 -0600 (CST) (envelope-from jchua@fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet04.prod.fedex.com (8.12.11/8.12.11) with ESMTP id
	i2V6aa72011957 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Mar 2004 00:36:38 -0600 (CST)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] Re: [PATCH] patch for linux-2.6.5-rc2
In-Reply-To: <20040330231834.3595.qmail@praize.com>
Message-ID: <Pine.LNX.4.58.0403311434560.895@boston.corp.fedex.com>
References: <20040330231834.3595.qmail@praize.com>
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
Date: Wed, 31 Mar 2004 14:36:55 +0800 (SGT)
To: gboutwel <gboutwel@praize.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

did you do a "make mrproper ARCH=um"? ...

ok, after you patch, do this ...

make mrproper ARCH=um
make menuconfig ARCH=um
make scripts
make scripts ARCH=um
make linux ARCH=um
strip linux
make modules ARCH=um



Thanks,
Jeff
[ jchua@fedex.com ]

On Wed, 30 Mar 2004, gboutwel wrote:

> > Works for me using stock 2.6.5-rc2 kernel with reiser4.
>
>
>
> Vanilla 2.6.5-rc2:
>
>
>
> bzcat uml-patch-2.6.4-1.bz2 | patch -p1
>
> cat host+Uml-skas3-2.6.3-v1.patch | patch -p1
>
> cat uml-patch-2.6.5-rc2 | patch -p0 (your patch you posted)
>
>
>
> I'm able to comple an SKAS enabled host without problems.  But
> the UML build fails.  Errors saying CONFIG_* not defined over
> and over and over again.
>
>
>
> :(
>
>
>
>
>
>
>
>
>
>
>
> -----------------------------------------------
>
> Get your FREE Christian Email Account at Praize
>
> http://www.praize.com/email/
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
