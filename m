Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C904A-0004g3-J1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 04:41:14 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C9047-000478-N1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 04:41:13 -0700
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Managing 2.6 merge
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<20040918205250.GB3748@ccure.user-mode-linux.org>
In-Reply-To: <20040918205250.GB3748@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409191338.12871.blaisorblade_personal@yahoo.it>
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
Date: Sun, 19 Sep 2004 13:38:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Saturday 18 September 2004 22:52, Jeff Dike wrote:
> On Sat, Sep 18, 2004 at 07:44:58PM +0200, Paolo Giarrusso wrote:
> > Jeff, could you please make sure you CC: me /the uml-devel list on every
> > patch you send to Andrew Morton? I'm working on merging a lot of patches
> > myself, so I'd like to be notified.
>
> OK, easy enough.  BTW, I've seen cc-ing LKML, so it's not like I've been
> doing it privately.
>
> > However, if you now are working on the mainline tree yourself, I'm going
> > to send you a tarball containing my remaining patches. I've got a lot of
> > them, right now.
>
> OK.  If you can point out the ones which you think should go into mainline
> soon, that would make my life a bit easier.
Well, since I'm doing a lot of Makefile work, can you (when I send the 
patches) move 
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.8.1-1um/patches/clean
out of the way? I'm going to merge those changes in the ones I send you (with 
appropriate credit) and to correct them (for instance, TOPDIR is deprecated).

I have a lot of experience about kbuild, so I can put appropriate care about 
makefiles quality.

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
