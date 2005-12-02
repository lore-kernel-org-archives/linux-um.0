Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiNco-0006Zw-4q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 18:59:46 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EiNcn-0000pp-TX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 18:59:46 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
References: <200511272159.38069.blaisorblade@yahoo.it>
	<200511291728.56515.blaisorblade@yahoo.it>
	<20051129175556.GA14058@ccure.user-mode-linux.org>
In-Reply-To: <20051129175556.GA14058@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512020118.27879.blaisorblade@yahoo.it>
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
Date: Fri, 2 Dec 2005 01:18:27 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Tuesday 29 November 2005 18:55, Jeff Dike wrote:
> On Tue, Nov 29, 2005 at 05:28:56PM +0100, Blaisorblade wrote:
> > So, again: can we finally rewrite clone.c in assembly? Or, otherwise, to
> > use a unique assembly macro joining mmap, the return and trap_myself?
>
> I would favor the second, although I would just join the mmap and storing
> of the error value.
I want to add the int3 too - that's the only way to be deterministically sure 
that GCC doesn't use %ebp after the unmap.

> The stack switching is at the heart of our recent 
> problems here, so some asm which hides that should be OK.  I think the rest
> is OK with the pseudo-C, right?
Yes, mostly.... there is also the problem with hardened toolchains (two 
different reports), which makes inline syscalls bleach (hardened toolchains 
use PIE code and need to have %EBX reserved for GOT/PLT handling), but I 
currently I do not consider fixing it before I can reproduce it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
