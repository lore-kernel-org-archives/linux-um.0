Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HURR1-0005tX-5c for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 10:50:49 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HURQz-000420-F3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 10:50:45 -0700
Date: Thu, 22 Mar 2007 09:50:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070322095034.51a16aa5.akpm@linux-foundation.org>
In-Reply-To: <20070322160640.GA6992@c2.user-mode-linux.org>
References: <20070322160640.GA6992@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [ PATCH 0/7 ] UML - Header cleanup
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 22 Mar 2007 12:06:40 -0400 Jeff Dike <jdike@addtoit.com> wrote:

> These are post-2.6.21 material, except that if the new definition of
> ARRAY_SIZE goes to Linus, patch 1 in this series should go as well.

I have the ARRAY_SIZE change queued for 2.6.22.

It looks like the UML change needs to be folded into the same changeset to
avoid build breaks?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
