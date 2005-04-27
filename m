Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQrZi-0006v1-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 11:47:54 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQrZh-0003R2-Cf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 11:47:54 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050427184733.GW493@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com> <20050427171552.GB3195@kroah.com>
	<1114619612.18355.113.camel@localhost.localdomain>
	<20050427174652.GL23013@shell0.pdx.osdl.net>
	<1114622596.18809.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114622596.18809.120.camel@localhost.localdomain>
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
Date: Wed, 27 Apr 2005 11:47:33 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <gregkh@suse.de>, blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>, Theodore Ts'o <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Mer, 2005-04-27 at 18:46, Chris Wright wrote:
> > > Don't see why this one is a critical bug.
> > 
> > I guess without it, modular nfsd has no syscall interface (for UML, or
> > course).
> 
> And the trivial zero risk fix is to compile it in. Its hardly pressing

OK, let's drop it.

thanks,
-chris


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
