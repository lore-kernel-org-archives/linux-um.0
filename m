Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uPuO-0000qt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 22:10:20 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uPtk-0006dg-9g
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 22:09:40 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19uPti-0002yW-00
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 01:09:38 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19uPth-0000HB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 01:09:37 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] [PATCH] Make UML slightly quieter
Message-ID: <20030903050937.GG25655@alcor.net>
References: <20030901204045.GA17884@alcor.net> <200309021849.h82InoHx001633@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309021849.h82InoHx001633@ccure.karaya.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 3 Sep 2003 01:09:37 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 02, 2003 at 02:49:50PM -0400, Jeff Dike wrote:

> mdz@debian.org said:
> > When booting UML with the 'quiet' option, most kernel messages are
> > suppressed, but the skas3 and /proc/mm check messages are still
> > displayed. Using printk rather than printf lets them be suppressed in
> > the normal way, and didn't break anything for me. 
> 
> The problem with this is that if UML dies early and doesn't make it into the
> kernel proper, printk messages will never be seen, and those messages 
> potentially have debugging usefulness.
> 
> We can possibly make everyone happy by replacing those printfs with a 
> uml_printf that respects the -quiet switch.

Easy enough.  Is there an existing module which has stuff like this, where
such a function would fit?

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
