Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGzwi-0006qO-AA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:28:44 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KGzwg-0004T6-EB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:28:44 -0700
Date: Thu, 10 Jul 2008 13:28:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710172830.GC18429@c2.user-mode-linux.org>
References: <486FC187.6010802@gmx.de>
	<20080707203912.GB7648@c2.user-mode-linux.org>
	<487514EE.3000903@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <487514EE.3000903@gmx.de>
Subject: Re: [uml-devel] hostfs oddities
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
To: Ingo van Lil <inguin@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 09, 2008 at 09:43:42PM +0200, Ingo van Lil wrote:
> I gave all this a little more thought: The ideal solution would be to 
> somehow share the host's page cache for that file. That way concurrent 
> read and write accesses on both sides would be automatically 
> synchronized, just as when multiple regular processes access the same 
> file. I guess that's not easily possible, is it?

It is possible.  mappng pages from the host into the UML page cache
will do that.  Adding mmap support to UML is possible, just there
hasn't been a lot of demand for it.

       	      	     Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
