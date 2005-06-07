Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfgpX-0005E8-U5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:21:31 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user81949)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfgpW-00048d-VB	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 09:21:31 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506071732.07844.blaisorblade@yahoo.it>
	<87is0q5fik.fsf@amaterasu.srvr.nix>
	<200506071811.52440.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200506071811.52440.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Tue, 7 Jun 2005 18:11:51 +0200")
Message-ID: <87acm25e9j.fsf@amaterasu.srvr.nix>
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
Date: Tue, 07 Jun 2005 17:21:28 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 7 Jun 2005, blaisorblade@yahoo.it gibbered uncontrollably:
> On Tuesday 07 June 2005 17:54, Nix wrote:
>> On Tue, 7 Jun 2005, blaisorblade@yahoo.it said:
>> > On Tuesday 07 June 2005 16:31, Nix wrote:
>> >> On Tue, 07 Jun 2005, bugzilla-daemon@gentoo.org gibbered uncontrollably:
>> >> > Ok, I hope there is still somebody using UML on a NPTL-only system.
>> >> > The workaround suggested last time was to avoid enabling
>> >> > CONFIG_MODE_TT; now I think I've got over this problem, too. So, when
>> >> > I release 2.6.11.8-bs6 (which will happen very shortly, I hope), I'd
>> >> > like to get some testing from you about this issue.
>> >>
>> >> I can give it a try if you like.
>> >>
>> >> (That's a MODE_TT build on a system with NPTL headers, right?)
>> >
>> > With NPTL-only glibc, I meant (and I guess you mean too).
> 
>> Well, I've got a dual non-NPTL glibc in /lib and NPTL glibc in /lib/tls,
>> but I can force use of either,
> Even for static linking? In this case, strange setup.

Yes.

>                                                       If dynamic linking, it 
> already worked, when you used dynamic linking i.e. disabled SKAS.

OK, so it's a -static TT build that's failing?

Will try.

>> and the headers, 
> Different headers too? I didn't know that (and it makes me suspicious about 
> binary compatibility).

Yeah, the headers differ. There *are* some binary compatibility
problems, mostly in the area of thread cancellation, but in that case
Ulrich would probably say that build-against-NPTL-run-against-LinuxThreads
is not officially supported for much the same reason as build-against-
2.3.5-run-against-2.2.4 is unsupported...

>> This is
>> <http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.11.8-bs
>>6/uml-2.6.11.8-bs6.patch.bz2>, right?
> 
> Not sure about that... I uploaded and destroyed it multiple times, so here's 
> the MD5 of the current version:
> 
> md5sum uml-2.6.11.8-bs6.patch.bz2
> 1a6868d70c7af75f3375eba3b7dfd466  uml-2.6.11.8-bs6.patch.bz2

That matches the MD5 of that patch. (The one wot doesn't work. ;} See
other mail.)

>>(It looks like it was uploaded only a few minutes ago in some time
>>zone quite divergent from either of ours. :) )
> Hmm, the first upload was done during this night, so I guess it was not a 
> timezone problem but an actual crazy boy fixing sucking compile errors at a 
> late time.

Gosh, I can't imagine anyone here doing anything like that.

[fixed one bug in a local administrative script at 04:00 this morning...
 insomnia sucks, hay fever sucks, temperatures above 15C suck...]

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
