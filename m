Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6YPu-0003x9-RK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 10:45:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C6YPt-000132-Lh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 10:45:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML compile fix
References: <20040904075520.GA5799@atrey.karlin.mff.cuni.cz>
	<200409100355.i8A3tEg1005654@ccure.user-mode-linux.org>
	<20040911205707.GB28557@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040911205707.GB28557@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121932.22567.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 19:32:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jan Kara <jack@suse.cz>, Jeff Dike <jdike@addtoit.com>

On Saturday 11 September 2004 22:57, Jan Kara wrote:
> > jack@suse.cz said:
> > > +HOSTCFLAGS := $(subst -fomit-frame-pointer,,$(HOSTCFLAGS))
> >
> > What does this fix?
>
>   I got errors that "omit-frame-pointer" and debugging flags exclude
> each other.
Well, that is wrong for two reasons:

1) if the host programs are compiled with debugging symbols, something went 
wrong

2) The UML kernel has always been compiled with both -fomit-frame-pointer and 
-g. Obviously this with GCC (but what compiler did you use? And which 
version?)

Try to re-get the exact error message and send it us. Compile preferably with 
"make ARCH=um V=1": the V=1 will ensure that the compiler command line is 
shown.

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
