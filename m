Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcvwM-0002iY-Jq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 17:48:38 -0700
Received: from click.bur.st ([203.34.17.217])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcvwM-0008OL-2H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 17:48:38 -0700
Received: from thump.bur.st (thud.bur.st [10.1.1.1])
	by click.bur.st (Postfix) with ESMTP id 408D88A187
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jun 2004 08:48:34 +0800 (WST)
From: Trent Lloyd <lathiat@bur.st>
Subject: Re: [uml-devel] hostfs / current->fsuid
Message-ID: <20040623004832.GD18570@thump.bur.st>
References: <20040621034434.GC2735@thump.bur.st>
	<20040622135044.GG25291@patrick.wattle.id.au>
	<200406222035.06782.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406222035.06782.blaisorblade_spam@yahoo.it>
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
Date: Wed, 23 Jun 2004 08:48:32 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Yes, however NFS has a remarkable ability to fuck up locking more often
than not (at least on linux)

> Alle 15:50, marted? 22 giugno 2004, Cameron Patrick ha scritto:
> > Hi Trent,
> >
> > Since no-one else has answered yet, I'll have a shot...
> >
> > On Mon, Jun 21, 2004 at 11:44:35AM +0800, Trent Lloyd wrote:
> > | I was looking into trying to modify hostfs so if UML ran as root it
> > | would keep the same permissions
> >
> > I've no idea about modifying hostfs, but have you looked into using
> > NFS instead?  Sure, it's a security nightmare, but it can't be worse
> > than running UML as root!  Performance might suck though.
> 
> No, on the uml-user list there are some reports NFS is faster than hostfs (not 
> actual benchmarks, just feelings): I think that this can be true due to the 
> super-optimization of NFS gone in for years; also it's difficult to optimize 
> something when you cannot use inline functions for some things (i.e. the 
> distinction between userspace and kernelspace files).
> 
> Bye
> -- 
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729

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
