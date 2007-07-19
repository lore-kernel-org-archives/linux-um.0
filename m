Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBKZc-0001PN-Ir for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:13:00 -0700
Received: from apollo.fprintf.net ([208.75.87.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBKZa-0007cW-WE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:12:55 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <469A54A5.2010102@nagafix.co.uk>
References: <46975CD0.5020709@nagafix.co.uk> <46976A09.9070906@nagafix.co.uk>
	<20070713155723.GA7468@c2.user-mode-linux.org>
	<4697B944.6030203@nagafix.co.uk>
	<20070713184441.GB9472@c2.user-mode-linux.org>
	<4698960D.8070100@nagafix.co.uk>
	<20070714120029.GA4421@c2.user-mode-linux.org>
	<469A54A5.2010102@nagafix.co.uk>
Date: Wed, 18 Jul 2007 21:13:08 -0400
Message-Id: <1184807588.7782.1.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


On Sun, 2007-07-15 at 18:08 +0100, Antoine Martin wrote:
> Jeff Dike wrote:
> > On Sat, Jul 14, 2007 at 10:23:25AM +0100, Antoine Martin wrote:
> >   
> >> I don't mind bugging people to get to the bottom of this, do you know 
> >> where to knock?
> >> I can't find anything in MAINTAINERS.
> >>     
> >
> > Did you install the headers directly from a kernel tree, or is this
> > the result of a distro upgrade?
> >   
> These are the Gentoo packages which are very close to mainline and I 
> can't find the upstream location for the headers so I guess I will be 
> filing a bug with Gentoo... We'll see where that leads.
> 

Actually, the Gentoo headers are not particularly close to the kernel
headers.  They are heavily "sanitized", meaning that all kinds of things
that userspace is "not supposed to use" are removed.  This makes it very
hard for things like UML, that are heavily tied to the kernel, to build.

Daniel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
