Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbNHb-0000pF-41 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 11:12:55 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EbNHY-0005Rq-GA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 11:12:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<20051113193256.GA25736@ccure.user-mode-linux.org>
In-Reply-To: <20051113193256.GA25736@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511132020.01596.blaisorblade@yahoo.it>
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
Date: Sun, 13 Nov 2005 20:20:00 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

On Sunday 13 November 2005 20:32, Jeff Dike wrote:
> On Sat, Nov 12, 2005 at 07:36:41PM -0600, Rob Landley wrote:
> > Stub registers -
> >         0 - 9090909090909090
> >         1 - 9090909090909090
> >         2 - 9090909090909090
> >         3 - 9090909090909090
> >         4 - 9090909090909090
> >         5 - 9090909090909090
> >         6 - 9090909090909090
> >         7 - 9090909090909090
> >         8 - 9090909090909090
> >         9 - 9090909090909090
> >         10 - 0
> >         11 - 9090909090909090
> >         12 - 9090909090909090
> >         13 - 9090909090909090
> >         14 - 9090909090909090
> >         15 - ffffffffffffffff
> >         16 - 9090909090909090
> >         17 - 33
> >         18 - 292
> >         19 - 9090909090909090
> >         20 - 2b
>
> I remain baffled by this.  There is nothing valid there.  At the very least
> RSP and RIP should be reasonable, and they're not.

Jeff, given the current state, I think that we need a look at the disassembly 
- or better:
*) build a 2.6.15-rc1 binary with Rob's config.
*) test that it works
*) send him and see if it works for him
*) finally, conclude GCC is misassembling stuff and take measures for this 
case.

Meanwhile, Rob, can you provide the disassembly? We need to look at 
disassembled arch/um/sys-x86_64/stub_segv.c arch/um/kernel/skas/clone.c, i.e. 
stub_segv_handler() and stub_clone_handler().

* Also, about the miscompilation bug you described:
is it caused by GCC saving the "from" value (UML_CONFIG_STUB_DATA) on the 
stack and re-loading it?


* Ah, Jeff, while giving a casual look: should I remove x86_64 "syscall_stub" 
label from stub.S, since it should be unused (replaced by 
batch_syscall_stub), doesn't exist for 386 and the content is bogus?

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
