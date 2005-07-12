Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsNjZ-0001ip-QK	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:35:49 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsNjY-0002EX-Rf	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:35:49 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] host cpu frequency scaling and guest bogomips
In-Reply-To: <200507121756.40169.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.62.0507121834280.4187@numbat.sonytel.be>
References: <42D3549D.50308@gmail.com>
	<200507121756.40169.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 12 Jul 2005 18:35:35 +0200 (CEST)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Victor Condino <un1tz3r0@gmail.com>

On Tue, 12 Jul 2005, Blaisorblade wrote:
> On Tuesday 12 July 2005 07:26, Victor Condino wrote:
> > just noticed something interesting while testing out my gentoo/uml
> > root-fs generation script on my laptop. my l/t is an thinkpad T42p,
> > which has a p3 centrino with speedstep. i use cpufreqd to throttle the
> > cpu when not on ac between 600 and 1800MHz based on load. what i noticed
> > is that when I fired up UML while the host's core frequency was at
> > 600mhz, /proc/cpuinfo reported ~600 bogomips in the guest, but when i
> > put some load on the host and cpufreq stepped up the core frequency, UML
> > still reports ~600 bogomips. likewise, when I fired up UML while the
> > host was under load and it's core at 1200MHz, UML reports higher
> > bogomips, but then when the host drops back down to the lower core freq,
> > UML still reports the same higher bogomips.
> 
> > Not that this actually affects anything I do or would affect most
> > people... just thought you guys might want to know =D
> Hmm, bogomips are calculated at startup and that won't change easily. However, 
> they become inaccurate in a much wider variety of situation, for instance 
> when there's some load on the host; so, using CONFIG_UML_REAL_TIME_CLOCK 
> (IIRC) uses the host clock for time calculation.
> 
> When you disable this option, I guess that a "sleep 10" when host is at 600, 
> if UML was started at 1800, might last 30 seconds more or less...

I don't think user space sleep uses the kernel's udelay() or mdelay()...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
