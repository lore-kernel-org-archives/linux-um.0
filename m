Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CH9sb-00047h-2A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 16:47:01 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CH9sO-0000zJ-Ti for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 16:47:00 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Default kernel configuration on 2.6.x
References: <416B07AC.3030308@sektor37.de>
	<23090.1097535525@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <23090.1097535525@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120147.06971.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 01:47:06 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, Julian Scheid <julian@sektor37.de>, jdike@karaya.com

On Tuesday 12 October 2004 00:58, Michael Richardson wrote:
> >>>>> "Julian" == Julian Scheid <julian@sektor37.de> writes:
>
>     Julian> Therefore I think it would make sense to have the UML
>     Julian> patches for the affected kernel versions remove the second
>     Julian> through fourth element from conf_confnames (as shown above)
>     Julian> so that the build will immediately fall back to
>     Julian> arch/um/defconfig if .config isn't found, always ignoring
>     Julian> status quo configuration files on the host. A corresponding
>     Julian> patch for 2.6.8.1 is attached.
>
>   I have a better suggestion.
>   Make it ignore those suggestions *COMPLETELY* when
>        $ARCH != `uname -m`
>        $SUBARCH != `uname -m`

>   Since those suggestions are wrong for all cross-compilation as well,
> and this is a form of cross-compilation.
>
>   {well, uname -m is wrong. I never did find a standard utility that
> returned 'i386'. arch -k used to do the right thing on SunOS, but it
> never did the right thing on any Linux distro}

In fact this is workarounded in the main Makefile.

However a even better setting IMHO is to check if the user has asked for a 
cross compilation (i.e. with ARCH specified on command line, or something 
such; I'll dig anyway on this). I will put together a patch ASAP.

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
