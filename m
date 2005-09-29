Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL3zA-0007qj-4i	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:28 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EL3z8-0000jf-9U
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
References: <200509281346.23592.blaisorblade@yahoo.it>
	<20050928213125.GA16955@ccure.user-mode-linux.org>
In-Reply-To: <20050928213125.GA16955@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291614.03229.blaisorblade@yahoo.it>
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
Date: Thu, 29 Sep 2005 16:14:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 28 September 2005 23:31, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 01:46:15PM +0200, Blaisorblade wrote:
> > Also, there are some calls to kmalloc in the shutdown path - and they
> > work. I know this because I saw a problem with one of them: it gave
> > "might_sleep while atomic", and it was kmalloc in the shutdown, or
> > rather, in panic() - for the broken sysrq t (where's the fix you
> > promised?).

> Attached.

I now even found (by chance) the original mail from Allan Graves - and the 
changes in arch/um/include/sysdep-x86_64/ptrace.h weren't in his patch and 
are unrelated.

Plus, I think they're also bogus (those registers exist), but I may be wrong, 
I'm not looking at these unrelated changes since they pertain to something 
else and I've no changelog.

On the patch: it makes sense, and the "XXX" removed comment, which explained 
the bug, was added by myself.

On the bogus value: I'm more accustomed to 0xdeadbeef, since 0xbadbabe could 
be valid while 0xdeadbeef not (it's in the last giga).

The only problem I see is that we need to test it on a wide glibc range - 
you're using an internal header detail, so glibc will break it at will.

Sadly, we haven't a better fix (except reimplementing setjmp(), which is even 
worse than the original problem - plus I don't like glibc sources enough to 
go picking the code).
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
