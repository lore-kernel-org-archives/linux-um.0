Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5VF4-00012h-B4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 13:10:02 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C5VF3-0002YF-CX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 13:10:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UML hanging at "Activating swap"
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092133.35518.blaisorblade_spam@yahoo.it>
	<20040909194623.GQ5330@alcor.net>
In-Reply-To: <20040909194623.GQ5330@alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092206.35798.blaisorblade_spam@yahoo.it>
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
Date: Thu, 9 Sep 2004 22:06:35 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>

On Thursday 09 September 2004 21:46, Matt Zimmerman wrote:
> On Thu, Sep 09, 2004 at 09:33:35PM +0200, BlaisorBlade wrote:
> > On Thursday 09 September 2004 20:49, Matt Zimmerman wrote:
> > > Yes, I ran into this problem when testing the 2.4.24-3um packages for
> > > Debian. With previous UMLs, hwclock would simply produce an error, and
> > > the process would continue, but with 2.4.24-3um, it seems to hang.  Any
> > > idea why this might be?
> >

> UML in Debian has been in bad shape for some time, after the hostfs
> breakage, and then all the reports of hangs in tt mode
> (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=260111), and I would very
> much like to get a stable version in soon.

Please, update to 2.4.26-3. That has the fix! And it's not tt mode related. If 
you don't want the full upgrade, the tarball contains already the fix, which 
is move-generic_console_write-back.patch.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
