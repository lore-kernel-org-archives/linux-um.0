Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaAFY-0002jm-4O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 07:19:24 -0700
Received: from one.firstfloor.org ([213.235.205.2] ident=nadie)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaAFW-00019z-Fy
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 07:19:24 -0700
Date: Mon, 1 Sep 2008 16:22:19 +0200
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20080901142219.GH18288@one.firstfloor.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291613420.15543@abydos.NerdBox.Net>
	<87ljycxldb.fsf@basil.nowhere.org>
	<20080901140618.GA5691@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080901140618.GA5691@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Steve VanDeBogart <vandebo-lkml@NerdBox.Net>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, dkegel@google.com, jiayingz@google.com

On Mon, Sep 01, 2008 at 10:06:18AM -0400, Jeff Dike wrote:
> On Mon, Sep 01, 2008 at 11:32:00AM +0200, Andi Kleen wrote:
> > Steve VanDeBogart <vandebo-lkml@NerdBox.Net> writes:
> > > Kconfig option for Valgrind.  Suppression file, for known non-issues.
> > > Valgrind header files (svn 8534) that define the client request
> > > mechanism used to annotate programs plus a couple lines to integrate
> > > with Kconfig.
> > 
> > Couldn't you just get the valgrind.h header from the currently
> > installed valgrind? UML relies on host includes anyways, so
> > I don't see a reason to not do that for valgrind too.
> 
> Kernel code can't get headers from the system, unless you're thinking
>        #include "/usr/include/valgrind.h"
> or something similar.

Some um files at least least include sys/* files which are surely
user space?  If they can include that why not valgrind.h? 


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
