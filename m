Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4ka7-0005X2-SE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:20:39 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C4ka6-0001JN-V9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:20:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] uml: no extraversion in
	arch/um/Makefile for mainline
References: <20040906173524.EE034B977@zion.localdomain>
	<20040906193620.A8502@infradead.org>
In-Reply-To: <20040906193620.A8502@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072016.01749.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Sep 2004 20:16:01 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Monday 06 September 2004 20:36, Christoph Hellwig wrote:
> Could you please fix UML to not use ghash.h and remove that one before
> playing with new toys?  This has been requested a few times now.
Yes, I can try - but I'd like to know the exact reason (I'm not developing UML 
as long as Jeff does).

My idea is that ghash.h is just trivial boilerplate which does not deserve 
generalized code, so that even rewriting the same exact code without using 
those macros (and maybe embedding some assumptions about this usage) would be 
a fine solution; also, there is just one user of it 
(arch/um/kernel/physmem.c, with just one hash defined), so it shouldn't be 
hard.

However, if the problem with ghash.h is different, I need more explainations.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
