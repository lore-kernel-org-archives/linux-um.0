Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HSLj7-0001Yz-3v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 16:20:49 -0700
Received: from sccrmhc14.comcast.net ([204.127.200.84])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HSLj4-0001WS-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 16:20:49 -0700
MIME-Version: 1.0
From: Roland McGrath <roland@redhat.com>
In-Reply-To: Jeff Dike's message of  Friday, 16 March 2007 12:25:52 -0400
	<20070316162552.GB7948@c2.user-mode-linux.org>
Message-Id: <20070316232007.0CE881801C5@magilla.sf.frob.com>
Date: Fri, 16 Mar 2007 16:20:06 -0700 (PDT)
Subject: Re: [uml-devel] [PATCH] UML utrace support, step 1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> Did I send the right patch?  The one I meant to send (appended below),
> indeed builds and runs without utrace-regset.patch and
> utrace-core.patch applied.  It's utrace-1 in the following:

That is not the same patch I tried before.  This one does apply and build
fine (after make defconfig ARCH=um).  

Technically utrace_native_view doesn't belong in the tracehook patch (but
in the regset one to follow it), but it is harmless.

I've merged it into my current tree.  You can get this via GIT if you like
that.  I do regular merges from Linus's GIT tree, so any upstream UML
changes that merge cleanly or have trivial conflict fixes I can do will be
taken care of automatically.  For future updates, please send me
incremental changes based on my current stuff; the GIT branches and the
2.6-current patches on my utrace web page always match up.  My patch set
generation uses just one fixed log message for utrace-tracehook-um.patch,
so tell me if you want to adjust it from log text in today's patch.


Thanks,
Roland

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
