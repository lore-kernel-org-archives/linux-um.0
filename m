Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRtfv-0000gX-Hh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 06:42:19 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRtft-0001Dm-VQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 06:42:19 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<41920646.3090802@fujitsu-siemens.com>
	<Pine.GSO.4.61.0411101342120.17015@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0411101342120.17015@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411101532.11446.blaisorblade_spam@yahoo.it>
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
Date: Wed, 10 Nov 2004 15:32:10 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, stian@nixia.no, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?utf-8?q?K=EF=BF=BDhler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

On Wednesday 10 November 2004 13:47, Geert Uytterhoeven wrote:
> On Wed, 10 Nov 2004, Bodo Stroesser wrote:
> > Geert Uytterhoeven wrote:
> > > On Wed, 10 Nov 2004 stian@nixia.no wrote:

> Yes, according to the man page getpid returns the process ID of the current
> process. Doesn't it do that?

> [ digging into mail archives ]

> Sorry, I misunderstood. Yes, this must be a glibc bug.
> Sorry for the confusion...

> Gr{oetje,eeting}s,

>       Geert
What's more, I think that fork() cannot be a plain syscall or it would 
experience the same bug.

So, the same thing applies to clone().

Btw, the issue is not only with getpid(), I guess, but rather with any 
__thread variable (the so-called Thread Local Storage).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
