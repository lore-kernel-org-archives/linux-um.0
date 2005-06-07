Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfgPa-0003P9-FV	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 08:54:42 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user18767)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfgPT-00081H-NE	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 08:54:40 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<87psuy5jcj.fsf@amaterasu.srvr.nix>
	<200506071732.07844.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200506071732.07844.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Tue, 7 Jun 2005 16:52:37 +0200")
Message-ID: <87is0q5fik.fsf@amaterasu.srvr.nix>
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
Date: Tue, 07 Jun 2005 16:54:27 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, bugzilla-daemon@gentoo.org

On Tue, 7 Jun 2005, blaisorblade@yahoo.it said:
> On Tuesday 07 June 2005 16:31, Nix wrote:
>> On Tue, 07 Jun 2005, bugzilla-daemon@gentoo.org gibbered uncontrollably:
>> > Ok, I hope there is still somebody using UML on a NPTL-only system. The
>> > workaround suggested last time was to avoid enabling CONFIG_MODE_TT; now
>> > I think I've got over this problem, too. So, when I release 2.6.11.8-bs6
>> > (which will happen very shortly, I hope), I'd like to get some testing
>> > from you about this issue.
>>
>> I can give it a try if you like.
>>
>> (That's a MODE_TT build on a system with NPTL headers, right?)
> With NPTL-only glibc, I meant (and I guess you mean too).

Well, I've got a dual non-NPTL glibc in /lib and NPTL glibc in /lib/tls,
but I can force use of either, and the headers, the dynamic loader, and
everything other than the stuff in /lib come from the NPTL glibc build.
This is pretty much indistinguishable from a pure-NPTL system unless
you force LD_ASSUME_KERNEL, which I'm not.

> Just give me the time to actually upload the tree, which I'm doing at the 
> moment, and forgive me if I added anything ruining the compilation while I 
> was working on x86_64 host.
> 
> Ok, done... enjoy!

This is
<http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.11.8-bs6/uml-2.6.11.8-bs6.patch.bz2>,
right? (It looks like it was uploaded only a few minutes ago in some
time zone quite divergent from either of ours. :) )

Building now, atop Linux-2.6.11.10. More in a few minutes when the
build completes, in whatever way.

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
