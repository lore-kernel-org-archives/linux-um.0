Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEHgo-0007sN-TG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:03:14 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DEHgn-0003Wh-5f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:03:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050322162123.890086BA6F@zion>
	<20050322181140.GA22149@infradead.org>
In-Reply-To: <20050322181140.GA22149@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503240302.29153.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 03:02:28 +0100
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 22 March 2005 19:11, Christoph Hellwig wrote:
> On Tue, Mar 22, 2005 at 05:21:23PM +0100, blaisorblade@yahoo.it wrote:
> > Export this symbol which is not satisfied currently. The code using it
> > has been merged, so please export this symbol.

> and it's still bogus, and you haven't replied when I mentioned it last
> time.
In this moment I need to clean up the missing symbol. If anyone wants to 
remove the code using this, then he might post a patch explictly removing it, 
and getting it refused probably.

Or at least CC uml-devel when discussing those problems. I'm not currently 
able to find on marc.theaimsgroup.com the mail you talk about. Can you please 
provide the URL to the discussion? (even on any other archive you like, 
obviously).

That said, there are people still using that code, so it should be kept in.

Also, you blocked an important patch (the one adding ->release to 
hw_interrupt_type) saying that *perhaps* UML should avoid having any hard 
irq, a la S390. You forced so the merge of a very ugly patch manually calling 
what should have been UML's release method (i.e. free_irq_by_irq_and_dev) in 
every place calling free_irq() (and in fact one was missed at first). Might 
you reconsider your position on that issue ? (URL of the discussion below)

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=3&s=uml+irq&q=b

The patch adding the generic handling is this one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109834481320519&w=2

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
