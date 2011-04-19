Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <nolan@sigbus.net>) id 1QBycP-0001i6-F1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2011 00:16:37 +0000
Received: from phong.sigbus.net ([64.62.173.8])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QBycO-0008DS-Lu
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2011 00:16:37 +0000
From: Nolan Leake <nolan@cumulusnetworks.com>
In-Reply-To: <201104131258.46657.richard@nod.at>
References: <1302652293.17952.33.camel@voxel>
	<201104131258.46657.richard@nod.at>
Date: Mon, 18 Apr 2011 17:16:29 -0700
Message-ID: <1303172189.17952.81.camel@voxel>
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
Subject: Re: [uml-devel] [PATCH] um: Add a "ucast" ethernet transport
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 2011-04-13 at 12:58 +0200, Richard Weinberger wrote:
> Am Mittwoch 13 April 2011, 01:51:33 schrieb Nolan Leake:
> > The "ucast" transport is similar to the mcast transport (and, in fact,
> > shares most of its code), only it uses UDP unicast to move packets.
> > 
> > Obviously this is only useful for point-to-point connections between
> > virtual ethernet devices.
> 
> Sorry, your mailer screwed the patch.
> Please use git send-email.

Weird, I used the same settings I've used in the past for linux kernel
patches.  I'll try git send-email.

> With your patch drivers/mcast* would contain unicast stuff.
> This is a bit confusing.
> Either rename the mcast files or put everything which have mcast 
> and ucast in common into a separate file.

OK, I'll do the rename.

> Are you using this patch in a production environment?

I use it for testing.

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

