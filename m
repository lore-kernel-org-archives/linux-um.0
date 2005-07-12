Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsN0g-0007y8-Ue	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 08:49:26 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DsN0d-0000T6-E2	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 08:49:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] host cpu frequency scaling and guest bogomips
References: <42D3549D.50308@gmail.com>
In-Reply-To: <42D3549D.50308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121756.40169.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 17:56:39 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Victor Condino <un1tz3r0@gmail.com>

On Tuesday 12 July 2005 07:26, Victor Condino wrote:
> just noticed something interesting while testing out my gentoo/uml
> root-fs generation script on my laptop. my l/t is an thinkpad T42p,
> which has a p3 centrino with speedstep. i use cpufreqd to throttle the
> cpu when not on ac between 600 and 1800MHz based on load. what i noticed
> is that when I fired up UML while the host's core frequency was at
> 600mhz, /proc/cpuinfo reported ~600 bogomips in the guest, but when i
> put some load on the host and cpufreq stepped up the core frequency, UML
> still reports ~600 bogomips. likewise, when I fired up UML while the
> host was under load and it's core at 1200MHz, UML reports higher
> bogomips, but then when the host drops back down to the lower core freq,
> UML still reports the same higher bogomips.

> Not that this actually affects anything I do or would affect most
> people... just thought you guys might want to know =D
Hmm, bogomips are calculated at startup and that won't change easily. However, 
they become inaccurate in a much wider variety of situation, for instance 
when there's some load on the host; so, using CONFIG_UML_REAL_TIME_CLOCK 
(IIRC) uses the host clock for time calculation.

When you disable this option, I guess that a "sleep 10" when host is at 600, 
if UML was started at 1800, might last 30 seconds more or less...
> - V. Condino

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
