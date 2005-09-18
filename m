Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGxOb-00039q-2B	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 04:31:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGxOW-0005Lw-Bx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 04:31:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
References: <1126653933.3769.45.camel@localhost>
	<200509171741.30694.blaisorblade@yahoo.it>
	<1126982040.1169.17.camel@localhost>
In-Reply-To: <1126982040.1169.17.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181329.07873.blaisorblade@yahoo.it>
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
Date: Sun, 18 Sep 2005 13:29:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

On Saturday 17 September 2005 20:34, Antoine Martin wrote:
> > Sorry, was talking about UML. But I assume it locks up. Was SMP enabled?
> > In that case, there's a couple of things in -bs1 (just published) which
> > may help it.

> Initial testing reveals (one just one x86 box so far), that the kernel
> stops booting right after:
Add stderr=1 to see some the rest...
> Checking PROT_EXEC mmap in /tmp...OK

> only when using:
> 2.6.12-bs11
> 2.6.13-bs1

> but not using 2.6.12-bb12
Since the only difference between -bb12 and -bs11 is SKAS0, in which modes are 
you running those kernels? Use the "UML running in XXX mode" message to make 
sure.
> Hope that helps...
> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
