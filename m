Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOr6j-0003jt-8k for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 00:02:45 -0800
Received: from rwcrmhc13.comcast.net ([204.127.192.83])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOr6g-00046B-Az
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 00:02:43 -0800
MIME-Version: 1.0
From: Roland McGrath <roland@redhat.com>
In-Reply-To: Jeff Dike's message of  Monday, 5 March 2007 14:21:20 -0500
	<20070305192120.GA7320@ccure.user-mode-linux.org>
Message-Id: <20070307080159.F27C41801C4@magilla.sf.frob.com>
Date: Wed,  7 Mar 2007 00:01:59 -0800 (PST)
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

> On Thu, Feb 22, 2007 at 07:19:03PM -0800, Roland McGrath wrote:
> > Your replacement patch still has utrace_regset stuff in it, so it doesn't
> > compile without the later patches in the series.  Try applying only
> > utrace-tracehook.patch from the series, then get it to build and make your
> > utrace-tracehook-um.patch.
> 
> Below is a tracehook patch for UML which goes right after
> utrace-utrace-tracehook.patch.

It does not.  That patch has regset and ptrace stuff in it.  It indeed
applies fine before or after utrace patches.  But it doesn't close to
compile without utrace-regset.patch and utrace-core.patch applied,
and even with utrace-ptrace-compat.patch it still doesn't compile for me
with a lot of complaints about TIF_SINGLESTEP not being defined where
it's used in asm/tracehook.h.


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
