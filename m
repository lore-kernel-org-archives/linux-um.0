Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1UO0yE-0001a6-It
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Apr 2013 07:21:58 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UO0y7-0005xZ-OV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Apr 2013 07:21:58 +0000
Date: Fri, 5 Apr 2013 09:21:41 +0200
From: Richard Weinberger <richard@nod.at>
Message-ID: <20130405092141.61f2f61c@spider.haslach.nod.at>
In-Reply-To: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
References: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
Mime-Version: 1.0
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

Am Wed, 3 Apr 2013 00:11:18 -0400 (EDT)
schrieb "Peter Butler" <pbutler@pt.com>:

> Running UML from vanilla kernel 3.8.5 compiled with default kernel
> configuration and booted with Fedora 18 root fs (as downloaded from
> http://fs.devloop.org.uk/).  Boots fine about 3/4 of the time, the
> rest of the time it crashes - see output below for an example.
> 
> 
> 
> command line:
> 
> ./linux ubd0=Fedora18-AMD64-root_fs rw mem=4096M con0=fd:0,fd:1
> 
> 
> 
> source code BUG() line:
> 
> BUG_ON(plug->magic != PLUG_MAGIC);

Does it always crash exactly here?
Can you please retry with Linus' tree.


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

