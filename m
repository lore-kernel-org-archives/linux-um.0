Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200403040305.i2435EWo009397@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 04 Mar 2004 00:11:32 +0100."
	<0d2e01c40174$dfda5b40$2000000a@schlepptopp> 
References: <40430B47.3000004@sms.ed.ac.uk>
	<200403022005.42635.blaisorblade_spam@yahoo.it>
	<0d2e01c40174$dfda5b40$2000000a@schlepptopp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Hang at ipv4 setup is a cpufreq issue!
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
Date: Wed, 03 Mar 2004 22:05:14 -0500
To: roland <for_spam@gmx.de>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

for_spam@gmx.de said:
> i did an "modprobe p4-clockmod" and then "echo 0%40%50%performance >/
> proc/cpufreq" to reduce the speed of my 2.6 ghz p4 (40% minimum, 50%
> maximum)
> and........
> THE UML STARTS FINE AND THE HANG AT IPV4 SETUP IS GONE!
> so - this is the workaround.
> now we need a patch ;)
> do we need the so called "rtc fix" ? does it exist already for 2.6
> kernel ? 

2.4 and 2.6 are identical as far as the rtc stuff goes.  So, there's something
else wrong.  I'm wondering whether this is somehow related to the rdtsc
problem that came up recently.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
