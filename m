Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRMzi-0004w6-2X	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 21:20:50 -0700
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRMzg-0005iO-LK	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 21:20:50 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20050429041613.GB25474@kroah.com>
References: <20050427171446.GA3195@kroah.com>
	<20050427171552.GB3195@kroah.com>
	<1114619612.18355.113.camel@localhost.localdomain>
	<20050427174652.GL23013@shell0.pdx.osdl.net>
	<1114622596.18809.120.camel@localhost.localdomain>
	<20050427184733.GW493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427184733.GW493@shell0.pdx.osdl.net>
Subject: [uml-devel] Re: [01/07] uml: add nfsd syscall when nfsd is modular
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
Date: Thu, 28 Apr 2005 21:16:14 -0700
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>, blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>, Theodore Ts'o <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org

On Wed, Apr 27, 2005 at 11:47:33AM -0700, Chris Wright wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > On Mer, 2005-04-27 at 18:46, Chris Wright wrote:
> > > > Don't see why this one is a critical bug.
> > > 
> > > I guess without it, modular nfsd has no syscall interface (for UML, or
> > > course).
> > 
> > And the trivial zero risk fix is to compile it in. Its hardly pressing
> 
> OK, let's drop it.

Dropped.

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
