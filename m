Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL6XA-0005sg-27 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 14:01:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CL6X9-00075H-Ds for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 14:01:11 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
In-Reply-To: <87r7nq8qq2.fsf@bytesex.org>
Message-ID: <Pine.GSO.4.61.0410222300300.11567@waterleaf.sonytel.be>
References: <20041022184126.GA9104@bytesex>
	<Pine.GSO.4.61.0410222117070.11567@waterleaf.sonytel.be>
	<87r7nq8qq2.fsf@bytesex.org>
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
Date: Fri, 22 Oct 2004 23:01:07 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 22 Oct 2004, Gerd Knorr wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > > X11 doesn't run yet, the X-Server wants IOPL access for some obscure
> > > reason, it shouldn't need that when running on top of a framebuffer
> > > device.  Anyone has an idea on that?
> > 
> > Ugh, that's probably a hardcoded dependency on __i386__ somewhere...
> 
> The google hits I had on that suggest that as well :-/
> 
> > Try the good old XF86_FBDev from XFree86 3.x? :-)
> 
> I would, but don't have a copy any more.  Ha, that was fun, first days
> of vesafb, my good old machine being busy for many hours building
> xfree86, and the X-Servers name was XF68_FBDev ;)

Debian still has it: pool/main/x/xfree86v3/xserver-fbdev_3.3.6-44_i386.deb

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
