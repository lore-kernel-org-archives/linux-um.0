Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiMO4-0007NB-D8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:31:24 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AiMO3-0004IN-Nx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:31:24 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [uml-user] /dev/anon available
Message-ID: <20040118235331.GB21046@ccure.user-mode-linux.org>
References: <200401130510.i0D5AlS4026784@ccure.user-mode-linux.org>
	<200401172048.47847.blaisorblade_spam@yahoo.it>
	<20040118045439.GE8571@ccure.user-mode-linux.org>
	<200401181637.35418.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401181637.35418.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jan 2004 18:53:31 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 05:13:38PM +0100, BlaisorBlade wrote:
> Yes, that's obvious with MAP_PRIVATE (and using MAP_SHARED would be 
> meaningless, if at all worked). But I wasn't aware you needed to map the same
> region twice; I guess this is done for pages shared (even with copy on write)
> between different processes inside UML, right? 

Pages are shared all over the place.  Pages are mapped into
	the UML physical memory region (the entire file as one chunk)
	the UML virtual memory region (in response to vmalloc)
	UML processes

They can be shared between processes
	between a fork and exec
	as shared memory
	as shared readonly data (i.e. program text)

> Also, since with skas the 
> mm_struct's of the virtual processes have nothing in common, they cannot

What do you mean by this?

> However, have you asked to Linus if he likes /dev/anon? Maybe he'll suggest 
> another interface for the same need (like when you two discussed skas4).

No, I haven't.  I did get a reaction from the tmpfs author.  He wasn't too
fond of the interface, but didn't immediately have any better suggestions.

I'm not too fond of it either, but it's the best I could think of off the
top of my head.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
