Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfSLr-0008Q2-6T	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:53:55 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DfSLn-0005Ol-Aq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:53:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML
	binary
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
	<200506070105.20422.blaisorblade@yahoo.it>
	<20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506070256.43104.blaisorblade@yahoo.it>
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
Date: Tue, 7 Jun 2005 02:56:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 01:53, Al Viro wrote:
> On Tue, Jun 07, 2005 at 01:05:19AM +0200, Blaisorblade wrote:
> > On Monday 06 June 2005 22:08, Jeff Dike wrote:
> > > From Al Viro - this turns the tt mode remapping of the binary into arch
> > > code.
> >
> > NACK at all, definitely, don't apply this one please. This patch:
> >
> > 1) On i386 does not fix the problem it was supposed to fix when I
> > originately sent the first version (i.e. avoiding to create a
> > .thread_private section to allow linking against NPTL glibc). It's done
> > on x86_64 and forgot on i386.
>
> True.  i386 still assumes non-NPTL (as it is on the box I'm working on -
> such setups *do* exist).
Yes, it's the most common one, and it's even the setup for my box currently.
> > 2) Splitting the linker script for subarchs is definitely not needed.
>
> Per-subarch - perhaps not.  Per-glibc-type - definitely needed.
No, because the setup for NPTL glibc works also on non-NPTL one. Actually, to 
be exact, I've tested it *only* on normal glibc. I'm still waiting to get 
some testing in NPTL environments, but I expect it to work.
> > 3) This removes the fix (done through objcopy -G switcheroo) to a link
> > time conflict happening on some weird glibc combinations.

> *What* link-time conflict?  We don't link libc into switcheroo anymore.
Hmm, yes, I noted this... and maybe it could even be good (it makes sense, at 
least). Probably you are right on this, too.

P.S: is it only me or you've sent about 20 copies of your last message?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
