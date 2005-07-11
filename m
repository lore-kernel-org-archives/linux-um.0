Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds6HJ-000080-JS	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:57:29 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds6HF-0003FM-7p	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:57:29 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: SKAS0 test tree against 2.6.12
References: <20050707182817.9601389260@sc8-sf-spam1.sourceforge.net>
	<200507091240.46934.blaisorblade@yahoo.it>
	<200507112346.17413.blaisorblade@yahoo.it>
In-Reply-To: <200507112346.17413.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200507120004.35828.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 00:04:35 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

On Monday 11 July 2005 23:46, Blaisorblade wrote:
> On Saturday 09 July 2005 12:40, Blaisorblade wrote:
> > On Friday 08 July 2005 12:29, antoine wrote:
> > > Don't know if you're interested in this report but it does not build
> > > for x86_64:
> > >   SYMLINK arch/um/sys-x86_64/semaphore.c
> > >   CC      arch/um/sys-x86_64/semaphore.o
> > >   CC      arch/um/sys-x86_64/sigcontext.o
> > >   CC      arch/um/sys-x86_64/signal.o
> > > arch/um/sys-x86_64/signal.c: In function ‘setup_signal_stack_si’:
> > > arch/um/sys-x86_64/signal.c:171: error: invalid lvalue in assignment
> > > make[1]: *** [arch/um/sys-x86_64/signal.o] Error 1
> > > make: *** [arch/um/sys-x86_64] Error 2
> >
> > I remember this report, only I just suggested the fix and didn't post it
> > (was busy at that time). It's SKAS0 - unrelated I think (I may be wrong,
> > but the whole patchset does not include it) but triggered by GCC4.
>
> Please keep remembering I *am* stupid, as just noted by Russell King (ARM
> maintainer) :-(.
>
> The attached patch makes more sense... however it seems that the affected
> code is anyway buggy, so I hope Jeff will help fixing this (unless I get to
> understand this magically).
Correction: the affected should be improved, but it anyway works.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
