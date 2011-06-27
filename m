Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QbEiC-0005dN-SD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 16:31:00 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QbEiB-0008C9-Ft
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 16:31:00 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 27 Jun 2011 18:30:43 +0200
References: <20110627161656.688820b9.sfr@canb.auug.org.au>
	<20110627082733.75e58ae4.randy.dunlap@oracle.com>
In-Reply-To: <20110627082733.75e58ae4.randy.dunlap@oracle.com>
MIME-Version: 1.0
Message-Id: <201106271830.43698.richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for June 27 (uml)
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, viro@zeniv.linux.org.uk

Am Montag 27 Juni 2011, 17:27:33 schrieb Randy Dunlap:
> On Mon, 27 Jun 2011 16:16:56 +1000 Stephen Rothwell wrote:
> > Hi all,
> 
> > Changes since 20110624:
> uml defconfig builds on x86 (32-bit and 64-bit) fail with:
> 
> fs/hostfs/hostfs_kern.c:756: error: 'mask' undeclared (first use in this
> function)

Hmm, "->permission() sanitizing: don't pass flags to ->permission()" is the evil doer.
Al?

Thanks,
//richard

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

