Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayifi-0002Pm-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 18:33:14 -0800
Received: from mx15.sac.fedex.com ([199.81.195.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Ayi9B-0006Ko-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:59:37 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx15.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i242JFGd039322
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Mar 2004 20:19:15 -0600 (CST) (envelope-from jchua@fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.11/8.12.11) with ESMTP id
	i242JDXb006229 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 3 Mar 2004 20:19:14 -0600 (CST)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
In-Reply-To: <200403040216.i242G1Wo009026@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0403041007440.24549@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com> 
	<200403040216.i242G1Wo009026@ccure.user-mode-linux.org>
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
Date: Thu, 4 Mar 2004 10:19:23 +0800 (SGT)
To: Jeff Dike <jdike@addtoit.com>
Cc: Jeff Chua <jchua@fedex.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


I'm on 2.6.3 and uml-patch-2.6.3-rc2 + 00-2.6.2-v1-host-SKAS2 no longer
has this problem.

Only problem now is uml-patch-2.6.3-rc2 + 00-2.6.2-v1-host-SKAS2 cannot
work with 2.6.4-rc1. Can't compile.


Thanks,
Jeff
[ jchua@fedex.com ]

On Wed, 3 Mar 2004, Jeff Dike wrote:

> jchua@fedex.com said:
> > uml-patch-2.4.22-5 works fine, but newer patches fail during boot
> > Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode
> > fault at addr 0x48965000, ip 0x400e51a4
>
> Can you check if this still happens with the next patch?  I fixed a crash
> caused by klogd, and the klogd in the last line there makes me suspicious
> that this is the same thing.
>
> 				Jeff
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
