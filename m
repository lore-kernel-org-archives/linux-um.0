Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgV8w-0005jC-83	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 15:04:54 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DgV8r-0003W9-75	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 15:04:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<871x7e54pv.fsf@amaterasu.srvr.nix> <200506080234.29043.blaisorblade@yahoo.it>
In-Reply-To: <200506080234.29043.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506100008.14664.blaisorblade@yahoo.it>
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
Date: Fri, 10 Jun 2005 00:08:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>

On Wednesday 08 June 2005 02:34, Blaisorblade wrote:
> On Tuesday 07 June 2005 21:47, Nix wrote:
> > On Tue, 7 Jun 2005, blaisorblade@yahoo.it suggested tentatively:
> > > On Tuesday 07 June 2005 18:21, Nix wrote:
> > >> OK, so it's a -static TT build that's failing?
> > >
> > > Exactly.
> >
> > Built, with a randomly selected .config (that is, a .config I use for
> > other things, not a .config with the values set at random!)
>
> Hmm, broken-out in the archives works perfectly (with patch-scripts). Go
> until uml-link-tt-mode-against-nptl.patch and retry, and possibly even with
> the previous one... please.
Hmm, ok, it works perfectly here in SKAS mode, not in TT mode (I'm enabling 
both), but it's different, so there is something wrong there... maybe it is 
the NPTL glibc. If you can confirm that, I'll have one less problem (fixing 
things for NPTL glibc will still be an issue, but that is not urgent).

Urgency is the keyword here.... I have the exam season now so I *must* study.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
