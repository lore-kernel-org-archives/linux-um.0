Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqYef-0001Sg-3M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 07:46:41 -0700
Received: from boxa.alphawave.net ([207.218.5.130] helo=box.alphawave.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqYeb-00045Q-Kq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 07:46:38 -0700
From: Nick Craig-Wood <nick@memset.com>
Subject: Re: [uml-devel] uml-patch-2.4.26-2
Message-ID: <20040730144606.GA27236@memset.com>
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
	<20040730074833.GA22488@craig-wood.com>
	<878yd1itow.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878yd1itow.fsf@amaterasu.srvr.nix>
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
Date: Fri, 30 Jul 2004 15:46:06 +0100
To: Nix <nix@esperi.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 30, 2004 at 01:08:15PM +0100, Nix wrote:
> On Fri, 30 Jul 2004, Nick Craig-Wood said:
> > I'm having trouble getting this to run stably.  On a Fedora core 2
> > image it locks up with 100% CPU after about 12 hours
> > normally.
> 
> I think this is caused the patch to use gettimeofday(), which breaks if
> time ever moves backwards. Lots of other things break if time moves
> backwards, too, but most don't care if it moves backwards by only a
> second or so. UML does care.
> 
> To work around it, avoid moving time backwards (ntpd and ntpdate both
> have switches to avoid this and always use adjtimex() instead.)

Yes you are right - Thanks!  The time of the crash lined up exactly
with the time being reset on the host.  I've changed it to use
adjtimex which should work around the problem.

However I view the above to be a bug in UML - it shouldn't lock up.
Its entitled to miss events etc though.  gettimeofday(2) isn't
guaranteed to be monotonic, but unfortunately there isn't a monotonic
timer (like jiffies) that escapes to user space AFAIK.

( We've got a laptop in the office who's time jumps backwards (just by
a few ms) quite regularly due to buggy BIOS and speedstep.  This
causes a few problems (notably with sawfish)...  I even sent a patch
to fix this to LKML but it was deemed that the BIOS should be fixed
instead of the kernel )

-- 
Nick Craig-Wood   Tel: 0800 195 4968   Net: nick@memset.com
Memset Ltd                             Web: http://www.memset.com


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
