Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4nVU-0001vM-MR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:28:04 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4nVU-00018x-6b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:28:04 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [patch 1/1] uml: no extraversion in
	arch/um/Makefile for mainline
Message-Id: <20040907142613.2ab5775e.akpm@osdl.org>
In-Reply-To: <200409072016.01749.blaisorblade_spam@yahoo.it>
References: <20040906173524.EE034B977@zion.localdomain>
	<20040906193620.A8502@infradead.org>
	<200409072016.01749.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Tue, 7 Sep 2004 14:26:13 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, hch@infradead.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> On Monday 06 September 2004 20:36, Christoph Hellwig wrote:
>  > Could you please fix UML to not use ghash.h and remove that one before
>  > playing with new toys?  This has been requested a few times now.
>  Yes, I can try - but I'd like to know the exact reason (I'm not developing UML 
>  as long as Jeff does).
> 
>  My idea is that ghash.h is just trivial boilerplate which does not deserve 
>  generalized code, so that even rewriting the same exact code without using 
>  those macros (and maybe embedding some assumptions about this usage) would be 
>  a fine solution; also, there is just one user of it 
>  (arch/um/kernel/physmem.c, with just one hash defined), so it shouldn't be 
>  hard.
> 
>  However, if the problem with ghash.h is different, I need more explainations.

Take one look at ghash.h and you'll see why we don't want it in the tree.

ghash was removed for a while and it was not intended that it come back -
it snuck back by accident.  Please, rewrite that piece of UML so we can
again remove ghash.h.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
