Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGFAP-0007eN-MZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Mar 2005 03:45:53 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DGFAO-000504-1T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Mar 2005 03:45:53 -0800
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20050329114529.GA26005@infradead.org>
References: <20050322162123.890086BA6F@zion>
	<20050322181140.GA22149@infradead.org>
	<200503240302.29153.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240302.29153.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 03/12] uml: export getgid for hostfs
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
Date: Tue, 29 Mar 2005 12:45:29 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


On Thu, Mar 24, 2005 at 03:02:28AM +0100, Blaisorblade wrote:
> In this moment I need to clean up the missing symbol. If anyone wants to 
> remove the code using this, then he might post a patch explictly removing it, 
> and getting it refused probably.
> 
> Or at least CC uml-devel when discussing those problems. I'm not currently 
> able to find on marc.theaimsgroup.com the mail you talk about. Can you please 
> provide the URL to the discussion? (even on any other archive you like, 
> obviously).

My unaswered reply to the first submission is at

http://groups-beta.google.com/group/linux.kernel/messages/de9504fe5963ccd1,0c05294c599b22b1,eab26a4ed3f8ff17?thread_id=16c905c7e28e7498&mode=thread&noheader=1&q=uml-export-getgid-for-hostfs#doc_eab26a4ed3f8ff17

(sorry, couldn't find it on marc), it's been Cc'ed to the lists you sent
the patch to.

> That said, there are people still using that code, so it should be kept in.

But the code is totally bogus, so it should _not_ be kept.

> Also, you blocked an important patch (the one adding ->release to 
> hw_interrupt_type) saying that *perhaps* UML should avoid having any hard 
> irq, a la S390. You forced so the merge of a very ugly patch manually calling 
> what should have been UML's release method (i.e. free_irq_by_irq_and_dev) in 
> every place calling free_irq() (and in fact one was missed at first). Might 
> you reconsider your position on that issue ? (URL of the discussion below)
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=3&s=uml+irq&q=b
> 
> The patch adding the generic handling is this one:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109834481320519&w=2

I still think it's a really bad idea.  But I'm not the irq code maintainer,
it could very well be Ingo overrides me.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
