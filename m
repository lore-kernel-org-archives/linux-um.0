Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Tiq-0005vK-Ug for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:32:40 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5Tio-0003xQ-5A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:32:39 -0700
From: Chris Wright <chrisw@osdl.org>
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Message-ID: <20040909113228.M1973@build.pdx.osdl.net>
References: <20040908172503.384144933@zion.localdomain>
	<20040908111204.I1973@build.pdx.osdl.net>
	<200409092002.19134.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409092002.19134.blaisorblade_spam@yahoo.it>;
	from blaisorblade_spam@yahoo.it on Thu, Sep 09, 2004 at
	08:02:19PM +0200
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
Date: Thu, 9 Sep 2004 11:32:28 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

* BlaisorBlade (blaisorblade_spam@yahoo.it) wrote:
> On Wednesday 08 September 2004 20:12, Chris Wright wrote:
> > * blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> > > Trivial: don't lock the queue spinlock when called from the request
> > > function. Since the faulty function must use spinlock in another case,
> > > double-case it. And since we will never use both functions together, let
> > > no object code be shared between them.
> >
> > Why not add a helper which locks around the core function.  Then either
> > call helper or core function directly depending on locking needs?
> I'm happy with whatever is nicer.

The way I outlined is nicer as it avoids all that conditional locking.
I can do a full patch if you like.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
