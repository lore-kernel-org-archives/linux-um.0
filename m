Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhSe6-00049N-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 04:00:14 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AhSe6-0001z7-82
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 04:00:14 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040116114204.GA29290@bytesex.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk>
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
Date: Fri, 16 Jan 2004 12:42:04 +0100
To: M A Young <m.a.young@durham.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 16, 2004 at 10:03:11AM +0000, M A Young wrote:
> On Thu, 15 Jan 2004, Jeff Dike wrote:
> 
> > They still don't work.  I still haven't got around to fixing it.
> 
> But see the patches at
> http://web.tiscali.it/no-redirect-tiscali/blaisorblade/

At last picking just the module fixes patch doesn't work for me, it
doesn't apply.  There are probably some nasty patch dependencies.

> > >  * Any known issues with 2.6.1 kernels?
> >
> > Fewer, now that I got the 2.6.1 patch out.  UML lacks [gs]et_thread_area
> > still, so 2.6 UMLs won't boot new libcs.

Great, building now ...

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
