Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6wEP-0007yn-RW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 12:11:17 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6wEN-0000EQ-2D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 12:11:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 2/2] add-SIGPROF-get-set_signals
References: <20040912182629.3FEC49F37@zion.localdomain>
	<20040913033239.GA13207@ccure.user-mode-linux.org>
In-Reply-To: <20040913033239.GA13207@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132012.29994.blaisorblade_spam@yahoo.it>
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
Date: Mon, 13 Sep 2004 20:12:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Monday 13 September 2004 05:32, Jeff Dike wrote:
> On Sun, Sep 12, 2004 at 08:26:29PM +0200, blaisorblade_spam@yahoo.it wrote:
> >  {
> >  	sigset_t mask;
> > +	sigset_t old_mask;
> >  	int ret;

> Weren't you just complaining about stack consumption?  Do you know how
> big a sigset_t is?

> 	(gdb) p sizeof(sigset_t)
> 	$1 = 128
Yes, I realize (glibc seems seriously original about this - who ever can use 
1024 different signals? The kernel just uses 64 signals - 8 bit).

> I went to a reasonable amount of trouble to get that function to only
> use one sigset_t and now you are proposing to add the old one back.
> Fix the patch and I'll put it in.
I rechecked the patch and understood why I put that in - I understand your 
point, but since that needs at least some, but using such unobvious tricks 
requires at least some comment - I'm adding the comment to the patch (and 
sending it inline separately).

Obviously feel free to delete/change the comment.

> Also, if you're going to fix something, send a patch which does
> nothing but make the fix, and save whatever cleanups you want to make
> for a differet patch.
Ok, I agree at all, and most times I already work like that.
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
