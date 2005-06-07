Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dff7O-0006Tl-Sk	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 07:31:50 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user79083)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dff7N-0002DA-4g	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 07:31:50 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	(bugzilla-daemon@gentoo.org's
	message of "Tue, 07 Jun 2005 00:57:58 +0000")
Message-ID: <87psuy5jcj.fsf@amaterasu.srvr.nix>
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
Date: Tue, 07 Jun 2005 15:31:40 +0100
To: bugzilla-daemon@gentoo.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 07 Jun 2005, bugzilla-daemon@gentoo.org gibbered uncontrollably:
> Ok, I hope there is still somebody using UML on a NPTL-only system. The 
> workaround suggested last time was to avoid enabling CONFIG_MODE_TT; now I 
> think I've got over this problem, too. So, when I release 2.6.11.8-bs6 (which 
> will happen very shortly, I hope), I'd like to get some testing from you about 
> this issue. 

I can give it a try if you like.

(That's a MODE_TT build on a system with NPTL headers, right?)

-- 
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
