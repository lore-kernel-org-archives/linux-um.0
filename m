Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuV5z-00074d-IR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 04:19:27 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CuV5w-0003P9-OU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 04:19:27 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] State of gdkfb ?
In-Reply-To: <1106908848.25603.10.camel@gandalf.tm.informatik.uni-frankfurt.de>
Message-ID: <Pine.GSO.4.61.0501281318210.20061@waterleaf.sonytel.be>
References: <1106908848.25603.10.camel@gandalf.tm.informatik.uni-frankfurt.de>
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
Date: Fri, 28 Jan 2005 13:19:19 +0100 (MET)
To: Michael 'Mickey' Lauer <mickey@tm.informatik.uni-frankfurt.de>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 28 Jan 2005, Michael 'Mickey' Lauer wrote:
> could you be so kind and give me a status update about your uml
> framebuffer patch regarding kernel 2.6? UML in 2.6.11-rc1-mm1 is the
> first version since quite a while that works here. We use it to
> prototype root file systems for our embedded Linux distributions like
> OpenZaurus and familiar Linux.

I didn't continue to work on it since quite a while.
However, I did try Gerd Knorr's x11fb and it worked much better than mine!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
