Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6gEj-00075S-Pv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 19:06:33 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C6gEg-0004dr-P3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 19:06:33 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
Message-ID: <20040913031014.GA13184@ccure.user-mode-linux.org>
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409111745.18659.blaisorblade_spam@yahoo.it>
	<20040911182615.GB2966@ccure.user-mode-linux.org>
	<200409121752.07398.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409121752.07398.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 23:10:14 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, David Jeffery <djeffery@britsys.net>, linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 05:52:44PM +0200, BlaisorBlade wrote:
> It worked no worse than current version (which is broken). In fact the 2.4 
> clone had 2 arguments. So it's obvious.

In fact, it worked better.  It worked on a modern Debian filesystem, where
my old code didn't.  Hence I didn't notice the mistake (although I should 
have compared what I did with David's patch and justified the differences,
if any).

> However, this is non-standard. I've added just a comment for now, since you 
> may have reason to keep the current code, but such behaviour calls for 
> breakage when things change.

Yeah, I not sure why I did things the way I did.  That's very old code, and
there may have been some good reason for it which has since disappeared.

Offhand, it looks like doing things in the standard way will clean up
copy_thread a bit.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
