Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaA3J-0001OU-ED for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 07:06:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaA3G-0005vc-67
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 07:06:43 -0700
Date: Mon, 1 Sep 2008 10:06:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080901140618.GA5691@c2.user-mode-linux.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291613420.15543@abydos.NerdBox.Net>
	<87ljycxldb.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ljycxldb.fsf@basil.nowhere.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: jiayingz@google.com, dkegel@google.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Steve VanDeBogart <vandebo-lkml@NerdBox.Net>

On Mon, Sep 01, 2008 at 11:32:00AM +0200, Andi Kleen wrote:
> Steve VanDeBogart <vandebo-lkml@NerdBox.Net> writes:
> > Kconfig option for Valgrind.  Suppression file, for known non-issues.
> > Valgrind header files (svn 8534) that define the client request
> > mechanism used to annotate programs plus a couple lines to integrate
> > with Kconfig.
> 
> Couldn't you just get the valgrind.h header from the currently
> installed valgrind? UML relies on host includes anyways, so
> I don't see a reason to not do that for valgrind too.

Kernel code can't get headers from the system, unless you're thinking
       #include "/usr/include/valgrind.h"
or something similar.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
