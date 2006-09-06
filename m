Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GL43S-0008Ql-02 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 13:31:26 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GL43Q-0004Hg-Dm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 13:31:25 -0700
Date: Wed, 6 Sep 2006 22:31:17 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <44FF2B54.5020201@nagafix.co.uk>
Message-ID: <Pine.LNX.4.62.0609062229440.14182@pademelon.sonytel.be>
References: <mailman.1307.1157397566.8760.user-mode-linux-user@lists.sourceforge.net>
	<44FF2B54.5020201@nagafix.co.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] virtual framebuffer device visible on host
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 6 Sep 2006, Antoine Martin wrote:
> Just a thought, but how hard would it be to have a virtual device in the 
> guests that mimics a framebuffer device and is in fact an X window on 
> the host? I think this could almost be a killer-app.
> Or is there already a way to do this using VFB?
> Surely an X window is rich enough to provide all the primitives that a 
> framebuffer device provides?

It's been done before (but not yet in mainline), cfr.
http://www.gatago.com/linux/kernel/6105868.html.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
