Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqWBz-0007cY-EI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 05:08:55 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=666)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqWBy-0006Vd-OD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 05:08:55 -0700
Subject: Re: [uml-devel] uml-patch-2.4.26-2
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
	<20040730074833.GA22488@craig-wood.com>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <20040730074833.GA22488@craig-wood.com> (Nick Craig-Wood's
	message of "Fri, 30 Jul 2004 08:48:33 +0100")
Message-ID: <878yd1itow.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 30 Jul 2004 13:08:15 +0100
To: Nick Craig-Wood <nick@memset.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 30 Jul 2004, Nick Craig-Wood said:
> I'm having trouble getting this to run stably.  On a Fedora core 2
> image it locks up with 100% CPU after about 12 hours
> normally.

I think this is caused the patch to use gettimeofday(), which breaks if
time ever moves backwards. Lots of other things break if time moves
backwards, too, but most don't care if it moves backwards by only a
second or so. UML does care.

To work around it, avoid moving time backwards (ntpd and ntpdate both
have switches to avoid this and always use adjtimex() instead.)

-- 
`The copyright file is for everyone.  That we make it available in
 plain-text, uncompressed form rather than in spinning, throbbing
 OpenGL-rendered 3D text over a thumping dance music soundtrack is a
 feature, not a bug.' --- Branden Robinson



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
