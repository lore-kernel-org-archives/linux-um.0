Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2Zmp-0007Hf-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 10:20:15 -0700
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A2Zmo-0002Sv-FZ
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 10:20:14 -0700
Received: from mail-e1000-1.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with SMTP id h8PHK4go022662
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 12:20:08 -0500 (CDT)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.44.0309251132320.26334-100000@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.42.0309260059180.22929-100000@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] RE: ptrace_faultinfo ptrace_ldt redefined
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
Date: Fri, 26 Sep 2003 01:18:04 +0800 (SGT)
To: Adam Heath <adam@doogie.org>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@karaya.com>


On Thu, 25 Sep 2003, Adam Heath wrote:

> > Please apply the patch below to host-skas3.patch so that it does not need
> > to be undone when compiling uml.
>
> Maybe a common include, for both files.

Problem is uml has to be compiled under a separate path other than the
standard path /usr/src/linux. /usr/include/asm/ptrace.h is not accessed
until the very end.

And I was trying to minimize changes to the original patch.

Jeff Dike ... any comments?


Thanks,
Jeff.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
