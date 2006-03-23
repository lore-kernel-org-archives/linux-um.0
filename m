Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMZTW-0005Us-0t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 15:44:18 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMZTT-0005HR-LB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 15:44:18 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
References: <200603230317.48384.blaisorblade@yahoo.it>
	<20060323211424.GA6130@ccure.user-mode-linux.org>
In-Reply-To: <20060323211424.GA6130@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240044.06196.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 00:44:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Antoine Martin <antoine@nagafix.co.uk>

On Thursday 23 March 2006 22:14, Jeff Dike wrote:
> On Thu, Mar 23, 2006 at 03:17:45AM +0100, Blaisorblade wrote:

> Do you have a set of patches which are candidates for akpm?  I'm
> looking at
> 	http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.15-bb6/
>broken-out/series

> and that seems unsuitable, as some patches seem to reverse earlier
> ones.

Yes, that is true, but meanwhile give a testing to them, especially regression 
test the new patches. I can't merge new patches in until I'm sure they don't 
cause regressions.

ASAP I'll test them bypassing the "x86_64 different host numbers" bug, and if 
they work and no issue seems introduced I'll do the merge.

Meanwhile I could merge the initial stack without anything touching that extra 
load_TLS call in process_kern.c, but I hope to get to the real solution early 
enough.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
