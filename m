Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Argzp-0004bx-I6
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 09:20:57 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Arguz-0006E6-Lb
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 09:15:57 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: patch/RFC: add bypass for "debug" parameter
In-Reply-To: <20040213141512.C8503@almesberger.net>
Message-ID: <Pine.GSO.4.58.0402131817210.29056@waterleaf.sonytel.be>
References: <20040208185334.H9021@almesberger.net>
 <20040212154958.GB2834@ccure.user-mode-linux.org> <20040212214058.R25203@almesberger.net>
 <Pine.GSO.4.58.0402131052540.23784@waterleaf.sonytel.be>
 <20040213141512.C8503@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 18:18:55 +0100 (MET)
To: Werner Almesberger <werner@almesberger.net>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 13 Feb 2004, Werner Almesberger wrote:
> Geert Uytterhoeven wrote:
> > Be careful not to break the feature to pass all remaining arguments to init.
>
> Hmm, I don't see it. How does it work ?

All kernel parameters that are not recognized by the kernel are passed to init
using its argv[].

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
