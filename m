Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6mu9-0007gM-5F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 02:13:45 -0700
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6mu8-00034j-Mw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 02:13:45 -0700
From: Jan Kara <jack@suse.cz>
Subject: Re: [uml-devel] UML compile fix
Message-ID: <20040913091342.GB24853@atrey.karlin.mff.cuni.cz>
References: <20040904075520.GA5799@atrey.karlin.mff.cuni.cz>
	<200409100355.i8A3tEg1005654@ccure.user-mode-linux.org>
	<20040911205707.GB28557@atrey.karlin.mff.cuni.cz>
	<200409121932.22567.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409121932.22567.blaisorblade_spam@yahoo.it>
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
Date: Mon, 13 Sep 2004 11:13:42 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> On Saturday 11 September 2004 22:57, Jan Kara wrote:
> > > jack@suse.cz said:
> > > > +HOSTCFLAGS := $(subst -fomit-frame-pointer,,$(HOSTCFLAGS))
> > >
> > > What does this fix?
> >
> >   I got errors that "omit-frame-pointer" and debugging flags exclude
> > each other.
> Well, that is wrong for two reasons:
> 
> 1) if the host programs are compiled with debugging symbols, something went 
> wrong
> 
> 2) The UML kernel has always been compiled with both -fomit-frame-pointer and 
> -g. Obviously this with GCC (but what compiler did you use? And which 
> version?)
> 
> Try to re-get the exact error message and send it us. Compile preferably with 
> "make ARCH=um V=1": the V=1 will ensure that the compiler command line is 
> shown.
  OK. I retried on a different host and the problems with compiler flags
went away so it was probably either my mistake or just somehow broken
instalation.. Sadly I don't have access to that system anymore - it was
just a borrowed notebook and I had to return it. Thank you very much for
help.

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
