Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dfg0v-0001or-OG	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 08:29:13 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Dfg0p-0003fs-MV	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 08:29:13 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<87psuy5jcj.fsf@amaterasu.srvr.nix>
In-Reply-To: <87psuy5jcj.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1668257.B8Xg6TKigv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506071732.07844.blaisorblade@yahoo.it>
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
Date: Tue, 7 Jun 2005 16:52:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>, bugzilla-daemon@gentoo.org

--nextPart1668257.B8Xg6TKigv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 June 2005 16:31, Nix wrote:
> On Tue, 07 Jun 2005, bugzilla-daemon@gentoo.org gibbered uncontrollably:
> > Ok, I hope there is still somebody using UML on a NPTL-only system. The
> > workaround suggested last time was to avoid enabling CONFIG_MODE_TT; now
> > I think I've got over this problem, too. So, when I release 2.6.11.8-bs6
> > (which will happen very shortly, I hope), I'd like to get some testing
> > from you about this issue.
>
> I can give it a try if you like.
>
> (That's a MODE_TT build on a system with NPTL headers, right?)
With NPTL-only glibc, I meant (and I guess you mean too).

Just give me the time to actually upload the tree, which I'm doing at the=20
moment, and forgive me if I added anything ruining the compilation while I=
=20
was working on x86_64 host.

Ok, done... enjoy!
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--nextPart1668257.B8Xg6TKigv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCpb33qH9OHC+5NscRAmvRAKCNCHzgE+8S+oAiZRbmHNQP8QEYOwCdGmAi
/ji4IcYMCun28Mxs8fz5YK0=
=0kye
-----END PGP SIGNATURE-----

--nextPart1668257.B8Xg6TKigv--

		
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
