Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ka5lX-0006fz-Gp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 02:32:07 -0700
Received: from one.firstfloor.org ([213.235.205.2] ident=nessuno)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ka5lV-0004Vm-RB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 02:32:07 -0700
From: Andi Kleen <andi@firstfloor.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291613420.15543@abydos.NerdBox.Net>
Date: Mon, 01 Sep 2008 11:32:00 +0200
In-Reply-To: <alpine.DEB.1.00.0808291613420.15543@abydos.NerdBox.Net> (Steve
	VanDeBogart's message of "Fri, 29 Aug 2008 16:14:32 -0700 (PDT)")
Message-ID: <87ljycxldb.fsf@basil.nowhere.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/6] base: Valgrind headers and Kconfig
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
Cc: jiayingz@google.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dkegel@google.com

Steve VanDeBogart <vandebo-lkml@NerdBox.Net> writes:

> Kconfig option for Valgrind.  Suppression file, for known non-issues.
> Valgrind header files (svn 8534) that define the client request
> mechanism used to annotate programs plus a couple lines to integrate
> with Kconfig.

Couldn't you just get the valgrind.h header from the currently
installed valgrind? UML relies on host includes anyways, so
I don't see a reason to not do that for valgrind too.

-Andi

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
