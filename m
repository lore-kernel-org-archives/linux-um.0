Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHB2W-000250-43 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:01:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CHB2U-0006H5-Cm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:01:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Default kernel configuration on 2.6.x
References: <416B07AC.3030308@sektor37.de>
	<200410120146.06254.blaisorblade_spam@yahoo.it>
	<416B281C.3090201@sektor37.de>
In-Reply-To: <416B281C.3090201@sektor37.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120301.35666.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 03:01:35 +0200
To: Julian Scheid <julian@sektor37.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

On Tuesday 12 October 2004 02:41, Julian Scheid wrote:
> BlaisorBlade wrote:
> > On Tuesday 12 October 2004 00:22, Julian Scheid wrote:
> >>This is especially fatal because without a virtual character device
> >>driver, stdio initialization will fail silently or with an unhelpful
> >>error message ("sleeping process got unexpected signal 11"), leaving
> >>unsuspecting users like me completely puzzled.
> >
> > I.e. that error comes from this?????? Thanks a lot for this solution, but
> > could you explain which is exactly the wrong CONFIG_ option set for this
> > to happen?

> No, not exactly, but I believe it's the file descriptor channel support.

> Long answer: when I encountered this problem ("signal 11") and realized
> that my kernel config could be missing something I found that without
> exception, all UML-specific options were disabled (for the reasons
> mentioned).
>
> I proceeded to enable most of them (except the watchdog and some virtual
> network drivers which sounded arcane) and the problem went away.

> So I don't know exactly which option was necessary to get around the
> SEGV, but since it always happened around the stdio initialization and I
> was using "con=pty con0=fd:0,fd:1" I would say the culprit was the
> missing file descriptor channel support and/or pty channel support.

> If you can't reproduce it like this, let me know and I will try to nail
> it down.

Thanks a lot for this analysis, I'll check it here and let you know.

> > [Please always avoid sending that kind of patches; you **MUST ALWAYS**
> > use unified diffs, i.e. diff -u; the preferred setting is -puNr].
>
> I noticed that too just a minute ago, very newbie-ish. Pardon, I'm not
> submitting patches too often, I'll take more care next time.

> But hey, that's no reason to shout at me, I'm just trying to be helpful ;)

Oh, sorry. Yes, I was maybe a bit rude, and it was not my intention - however 
what I try to do is to correct issues like these to avoid people being flamed 
somewhere where people are less polite. Here we are nice - if you hit LKML, 
someone may flame you seriously, so I try helping. In fact I used CAPITAL 
just to make it clear, not to shout and flame you; again sorry for that.

> > About this, see the other responses - this must be done in mainline
> > whenever we are cross-compiling.
>
> Agree 100% with Michael and you, this is the right solution. I was
> focused on UML but in fact it's a larger issue.
Yeah - I should be sending this to Sam Ravnborg (Kbuild maintainer) when I 
have time to focus on this - now it's 3 a.m. and I think I'll be asleep 
shortly :-)

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
