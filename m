Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jq7oR-0005x6-Os for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Apr 2008 07:25:08 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user55488)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jq7oQ-00057C-23
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Apr 2008 07:25:07 -0700
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id
	m3RE3mkk000427 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Apr 2008 15:03:48 +0100
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Sun, 27 Apr 2008 15:02:33 +0100
In-Reply-To: <871w4sqxgv.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Sat, 26 Apr 2008 19:31:44 +0100")
Message-ID: <87wsmjbdl2.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 26 Apr 2008, nix@esperi.org.uk uttered the following:

> On 25 Apr 2008, nix@esperi.org.uk uttered the following:
>
>> On 25 Apr 2008, nix@esperi.org.uk told this:
>>
>>> I suspect this can go wrong anywhere, but it happens to have been a
>>> CBQ-triggered gettimeofday() while sending an arp that did it. (My ADSL
>>> router pretty much bombs the poor damn machine with ARP packets all the
>>> time.)
>>
>> Woo, it's happening a lot tonight.
>
> The cause of this is almost certainly time-skewing on the *host* via
> adjtimex(). I stopped ntpd and there were no problems for half a day: I
> restarted it, and as soon as ntpd had synched and begun slewing the time
> (within a second of slewing beginning, probably less than that), *wham*:

Time-stepping on the host is enough to cause trouble. I switched to
using ntpdate -b to keep time in synch, and since then my UML instances
have gone into mad loops only on the hour, when the ntpdate time-step
should take place.

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
