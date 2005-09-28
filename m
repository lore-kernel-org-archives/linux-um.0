Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKezi-0006IQ-OG	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:41:22 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKeze-0001gH-40
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:41:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Uml showstopper bugs for 2.6.14
References: <200509271846.51804.blaisorblade@yahoo.it>
	<200509281415.18586.blaisorblade@yahoo.it>
	<20050928145250.GB11610@ccure.user-mode-linux.org>
In-Reply-To: <20050928145250.GB11610@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281840.23816.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 18:40:22 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday 28 September 2005 16:52, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 02:15:18PM +0200, Blaisorblade wrote:
> > Do you know when this was introduced, and the last working UML version?

> It's always been broken, I think.
Ah, but you're talking of SKAS0.

In this case (which seems strange, given the number of people using x86_64 and 
not complaining - or maybe it's just me who didn't say "enable frame 
pointers" to any of the various bug reports), if the patch is not trivial 
enough (it seems to be), make sure to at least force frame pointers.

Even if I think, if I understood the thing correctly, that this workaround is 
not even guaranteed to work.

> It results from the stub having to 
> sigreturn by hand because it has no access to the libc restorer, and thus
> needing to restore the stack pointer to where it was on entry.  I did this
> by popping the requisite number of times.

> Bodo fixed this for i386,
By restoring in sp the address of first param (or something like that), right?
> and  
> I need to do something similar for x86_64.

The bug killing almost everybody testing 2.6.12-bb? In this case, it's SKAS0 
specific.

But especially, couldn't this be triggered by another GCC version, changing 
the stack layout?
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
