Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6F07-0000Py-5Q for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 14:01:39 -0700
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6F06-0003EE-Ds for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 14:01:39 -0700
From: Jan Kara <jack@suse.cz>
Subject: Re: [uml-devel] UML compile fix
Message-ID: <20040911205957.GC28557@atrey.karlin.mff.cuni.cz>
References: <20040904075520.GA5799@atrey.karlin.mff.cuni.cz>
	<200409100355.i8A3tEg1005654@ccure.user-mode-linux.org>
	<200409101929.28931.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101929.28931.blaisorblade_spam@yahoo.it>
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
Date: Sat, 11 Sep 2004 22:59:57 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> On Friday 10 September 2004 05:55, Jeff Dike wrote:
> > jack@suse.cz said:
> > > +HOSTCFLAGS := $(subst -fomit-frame-pointer,,$(HOSTCFLAGS))
> >
> > What does this fix?
> >
> > 				Jeff
> It's used for host programs. Actually, however, that line is useless, IMHO. 
> Nobody else needed it. Jan, can you test not using that line (and using just 
> the EXPORT_SYMBOL removal) and report the errors you get, if any, or a 
> success?
  What does exactly mean "EXPORT_SYMBOL removal"?

						Thanks for help
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
