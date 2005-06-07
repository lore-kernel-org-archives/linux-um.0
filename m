Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfgdJ-0004VC-C5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:08:53 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DfgdH-00020B-Fe	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:08:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506071732.07844.blaisorblade@yahoo.it> <87is0q5fik.fsf@amaterasu.srvr.nix>
In-Reply-To: <87is0q5fik.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506071811.52440.blaisorblade@yahoo.it>
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
Date: Tue, 7 Jun 2005 18:11:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>

On Tuesday 07 June 2005 17:54, Nix wrote:
> On Tue, 7 Jun 2005, blaisorblade@yahoo.it said:
> > On Tuesday 07 June 2005 16:31, Nix wrote:
> >> On Tue, 07 Jun 2005, bugzilla-daemon@gentoo.org gibbered uncontrollably:
> >> > Ok, I hope there is still somebody using UML on a NPTL-only system.
> >> > The workaround suggested last time was to avoid enabling
> >> > CONFIG_MODE_TT; now I think I've got over this problem, too. So, when
> >> > I release 2.6.11.8-bs6 (which will happen very shortly, I hope), I'd
> >> > like to get some testing from you about this issue.
> >>
> >> I can give it a try if you like.
> >>
> >> (That's a MODE_TT build on a system with NPTL headers, right?)
> >
> > With NPTL-only glibc, I meant (and I guess you mean too).

> Well, I've got a dual non-NPTL glibc in /lib and NPTL glibc in /lib/tls,
> but I can force use of either,
Even for static linking? In this case, strange setup. If dynamic linking, it 
already worked, when you used dynamic linking i.e. disabled SKAS.
> and the headers, 
Different headers too? I didn't know that (and it makes me suspicious about 
binary compatibility).
> the dynamic loader, and 
> everything other than the stuff in /lib come from the NPTL glibc build.
> This is pretty much indistinguishable from a pure-NPTL system unless
> you force LD_ASSUME_KERNEL, which I'm not.
>
> > Just give me the time to actually upload the tree, which I'm doing at the
> > moment, and forgive me if I added anything ruining the compilation while
> > I was working on x86_64 host.
> >
> > Ok, done... enjoy!
>
> This is
> <http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.11.8-bs
>6/uml-2.6.11.8-bs6.patch.bz2>, right?

Not sure about that... I uploaded and destroyed it multiple times, so here's 
the MD5 of the current version:

md5sum uml-2.6.11.8-bs6.patch.bz2
1a6868d70c7af75f3375eba3b7dfd466  uml-2.6.11.8-bs6.patch.bz2

>(It looks like it was uploaded only a 
> few minutes ago in some time zone quite divergent from either of ours. :) )
Hmm, the first upload was done during this night, so I guess it was not a 
timezone problem but an actual crazy boy fixing sucking compile errors at a 
late time.
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
