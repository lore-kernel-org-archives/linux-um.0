Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9pc9-0002eS-Av for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:43:45 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C9pc8-0007UH-Ba for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:43:45 -0700
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to merge
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409202030.49422.blaisorblade_personal@yahoo.it>
	<20040921123704.GA20191@bytesex>
In-Reply-To: <20040921123704.GA20191@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409211955.41103.blaisorblade_personal@yahoo.it>
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
Date: Tue, 21 Sep 2004 19:55:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>

On Tuesday 21 September 2004 14:37, Gerd Knorr wrote:
> On Mon, Sep 20, 2004 at 08:30:49PM +0200, Paolo Giarrusso wrote:
> > On Monday 20 September 2004 11:38, Gerd Knorr wrote:
> > > kbuild wishlist item #1: working parallel builds aka "make -j" for UML.
> >
> > Done and posted to Jeff - the complete set of patches which I posted him
> > is now available at this URL (no link in the page, sorry):

> Works great, thanks.

> It took some time to figure that the kernel binary 
> is vmlinux now and not linux any more through, guess that will surprise
> a few other people as well.  Is there some good reason for that change?
Making kallsyms work, since that does a post-processing on vmlinux which 
results become invalid if you later relink it - adding a "mv vmlinux linux" 
is not a problem to avoid surprising people, I've just been waiting for "what 
to do here".

In fact, now, when UML outputs a stack trace, it also outputs the function 
names, as 2.6 i386 (and other archs) do. Check also uml-use-kallsyms about 
this. It should help bug reporters, too.

Finally, this also fixes the "empty /proc/kallsyms" problem.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
