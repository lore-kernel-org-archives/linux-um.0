Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bd0q6-0005Zw-6K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 23:02:30 -0700
Received: from click.bur.st ([203.34.17.217])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bd0q5-000169-L6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 23:02:29 -0700
Received: from thump.bur.st (thud.bur.st [10.1.1.1])
	by click.bur.st (Postfix) with ESMTP id D27FA89856
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jun 2004 14:02:23 +0800 (WST)
From: Trent Lloyd <lathiat@bur.st>
Subject: Re: [uml-devel] Re: hostfs / current->fsuid
Message-ID: <20040623060222.GE18570@thump.bur.st>
References: <20040621034434.GC2735@thump.bur.st>
	<20040622135044.GG25291@patrick.wattle.id.au>
	<200406222035.06782.blaisorblade_spam@yahoo.it>
	<20040623004832.GD18570@thump.bur.st> <cbavp0$nss$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbavp0$nss$1@sea.gmane.org>
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
Date: Wed, 23 Jun 2004 14:02:23 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Speed is not so much an issue.

Does anyone have any pointers on getting current->fsuid or equivalent to
get the uid of the calling user?

> >Yes, however NFS has a remarkable ability to fuck up locking more often
> >than not (at least on linux)
> 
> beside that, i think that the network-protocol could have been designed 
> much simpler and more firewall-friendly.
> 
> BTW: i am one of those, that think that NFS is faster than hostfs.
> I cannot explain why, but i would guess, that - at least for parallel 
> file-access - the networking-code required less context-switches, since 
> the network-packets are perhaps queued before giving them to the 
> host-system.
> 
> That's just a guess, so you may prove me wrong ;-)
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
