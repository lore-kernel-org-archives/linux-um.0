Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSQJe-0007Ul-Id for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 20:42:34 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GSQJc-0007ym-SA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 20:42:34 -0700
Date: Tue, 26 Sep 2006 20:42:24 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060926204224.e365734f.akpm@osdl.org>
In-Reply-To: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org>
References: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/5] UML - file renaming
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

On Tue, 26 Sep 2006 13:53:15 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> Move some foo_kern.c files to foo.c now that the old foo.c files are out
> of the way.

This doesn't apply, because arch/um/kernel/process_kern.c has been altered
by uml-fix-stack-alignment.patch.

I fixed that up via

	 mv arch/um/kernel/process_kern.c arch/um/kernel/skas/process_kern.c

> Also cleaned up some whitespace and an emacs formatting comment.

So if any of these changes were made to process_kern.c, you've lost 'em.

They shouldn't have been: please do code-moving and code-changing within
distinct patches.

This file-moving also moved over a bunch of trailing-whitespace, which I
removed.  Which violates the previous rule.  I'm bad.

btw, it'd be nice to change your scripts to add a diffstat after the ^---.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
