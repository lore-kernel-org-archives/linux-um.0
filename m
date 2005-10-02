Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMCvQ-0007od-3x	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 16:07:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EM17n-0003Fi-Mr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 03:31:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
References: <200509281346.23592.blaisorblade@yahoo.it>
	<200509291614.03229.blaisorblade@yahoo.it>
	<20051002010812.GB4778@localhost.localdomain>
In-Reply-To: <20051002010812.GB4778@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510021231.05260.blaisorblade@yahoo.it>
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
Date: Sun, 2 Oct 2005 12:31:04 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>

On Sunday 02 October 2005 03:08, Jeff Dike wrote:
> On Thu, Sep 29, 2005 at 04:14:02PM +0200, Blaisorblade wrote:
> > I now even found (by chance) the original mail from Allan Graves - and
> > the changes in arch/um/include/sysdep-x86_64/ptrace.h weren't in his
> > patch and are unrelated.
> > Plus, I think they're also bogus (those registers exist), but I may be
> > wrong,

> The patch uses UPT_REG apparently for the first time.  Those registers
> exist, but there are no defines for them in the x86_64 ptrace.h.  UPT_REG
> is never called with any of those as its argument, so it's easy to just
> remove those cases.
Ah, ok.

> > The only problem I see is that we need to test it on a wide glibc range -
> > you're using an internal header detail, so glibc will break it at will.

> Yeah, it's bad.  The other way to do it is to explictly save the registers
> in the thread struct, which is effectively the reimplementing setjmp option
> which you mentioned.
At least, if we save them separately from the jmpbuf_t, we can use them for 
sysrq t, without reimplementing setjmp() and longjmp(). Not nice, wastes 24 
bytes, but would work.

I have the doubt that the location of those registers is part of the ABI, 
(pending: find an example where I can be statically linked to glibc and 
dynamically linked to a library dynamically linked to glibc, and must pass 
jmpbuf_t between the two implementations)
even if the C names aren't part of the API, so we could copy the structure.

Probably, however, it's just better to test on, say, a Slackware 8.1, and hope 
for the best and go doing a fix when things change.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
