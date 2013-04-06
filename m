Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1UOP30-0005pl-Gd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 09:04:30 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UOP2v-00033o-QQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 09:04:30 +0000
Message-ID: <515FE511.8060601@nod.at>
Date: Sat, 06 Apr 2013 11:04:17 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
	<20130405092141.61f2f61c@spider.haslach.nod.at>
	<OFF553D1A8.B32C41CE-ON85257B44.004D6DD3-85257B44.004D81FA@pt.com>
	<20130405160739.68d74008@spider.haslach.nod.at>
	<OF04169121.A123E516-ON85257B44.004E1BE5-85257B44.004E21A8@pt.com>
	<20130405161541.6e4a2472@spider.haslach.nod.at>
	<39656.10.100.142.174.1365215174.squirrel@webmail3.pt.com>
In-Reply-To: <39656.10.100.142.174.1365215174.squirrel@webmail3.pt.com>
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
Subject: Re: [uml-devel] BUG: failure at
	block/blk-core.c:2985/blk_flush_plug_list()
To: Peter Butler <pbutler@pt.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am 06.04.2013 04:26, schrieb Peter Butler:
> Looks like the mainline fails early in the build process (?)
>
> after 'make mrproper' and 'make defconfig' I get this:
>
> bash $ make ARCH=um linux

Please try with "make ARCH=um linux SUBARCH=x86" or "make ARCH=um linux SUBARCH=x86_64".

Thanks,
//richard

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

