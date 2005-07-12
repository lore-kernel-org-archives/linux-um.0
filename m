Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds8kU-0007z8-S5	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 17:35:46 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds8kR-0000Cv-6v	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 17:35:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel 2.6.13-rc2 host kernel configuration
References: <1121127912.9308.41.camel@localhost.localdomain>
In-Reply-To: <1121127912.9308.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120242.50232.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 02:42:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <Anthony_Brock@ous.edu>

On Tuesday 12 July 2005 02:25, Anthony Brock wrote:
> I'm about to build a 2.6.13-rc2 kernel for testing as a host kernel.
> I've patched it with the '-mm1' patches and the 'skas-2.6.12-v8.2'
> patch. The later applied with a minor tweak to 'mm/Makefile'.
>
> However, I'm now trying to build a configuration for the newer kernel.
> Unfortunately, I'm not certain how to best answer some of the questions
> for a machine whose primary purpose is to host UML instances.
> Specifically, any idea concerning the "Timer frequency" option? Here is
> the help provided during configuration:
>
> Timer frequency
>   1. 100 HZ (HZ_100) (NEW)
>
> > 2. 250 HZ (HZ_250) (NEW)
>
>   3. 1000 HZ (HZ_1000) (NEW)
> choice[1-3?]: ?

>
>
> Are timer interrupts used by a UML instance? If so, should I select
> "1000 HZ"? Or would "100 HZ" free up system resources and allow the
> instances to run with less contention?
The question is difficult to answer, and somebody should run some benchmarks. 
I think I'll have the time to answer properly ASAP.

However, what I see is that UML uses heavily signals, and increasing HZ speeds 
up signal delivery.

So, using 1000 (which is what previous kernels used) is IMHO the best option.

Don't know if the downsides of HZ=1000 would have bigger impact, but I still 
think that's the best choice.
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
