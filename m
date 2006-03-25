Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNF2r-0005sq-57 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 12:07:33 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FNF2p-0004jv-In
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 12:07:33 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060325200845.GA4143@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
Subject: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
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
Date: Sat, 25 Mar 2006 15:08:45 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 25, 2006 at 08:26:08PM +0100, Jan Engelhardt wrote:
> 
> >> +	char buf[sizeof("18446744073709551615\0")];
> 
> And this one seems wrong[*] to me too (making it a rofl??).
> It is two chars (or one[*]) too long.

One - it needs to be NULL-terminated.
> 
> Consider this test:
> 
> 	#include <stdio.h>
> 	#include <string.h>
> 	int main(void) {
> 	    printf("%d\n", sizeof("18446744073709551615\0"));
> 	    printf("%d\n", sizeof("18446744073709551615"));
> 	    printf("%d\n", strlen("18446744073709551615"));
> 	}
> 
> Which will print, when executed,
> 
> 	22
> 	21
> 	20	(the "pure string" length)
> 

Oops, I was basing this on a hazy (too hazy, apparently) recollection
that the C standard specified sizeof("literal string") as being the
pure string length.  Now that I'm actually thinking about it, the
actual behavior makes much more sense.

Thanks for checking this out in time for me to fix it in my revised
patch.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
