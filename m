Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xlxQ-000474-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 04:19:20 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xlxP-000058-UL
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 04:19:20 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20030912110805.GA16252@bytesex.org>
Message-ID: <Pine.GSO.4.21.0309121311060.2312-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: pthreads?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Sep 2003 13:18:35 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 12 Sep 2003, Gerd Knorr wrote:
> > > What is the point of using gdk?  I'd go with Xlib for that, if all you
> > > need is just a X11 window to blit the vitual framebuffer to IMHO isn't
> > > worth the trouble involved when using gdk/gtk.  You just don't need
> > > all the fancy stuff provided by the toolkit ...
> > 
> > GdkRgb is nice for displaying pictures, without having to care about X server
> > visuals, etc. I.e. I need to write less code.
> 
> I would probably try to map the X11 ximage format directly into linux
> framebuffer format, so you can use XPutImage() (or XShmPutImage()) to
> display the virtual framebuffer memory without any conversions.
> 
> > And I want a few buttons to control the fbdev behavior.
> 
> Well, ok, at this point it becomes very ugly with plain Xlib.  What
> stuff do you want control there?

  - The rate at which the display is updated
  - The visual type (it's in fb_fix_screeninfo, so the user cannot specify it)
  - The frame buffer layout (it's in fb_fix_screeninfo), to e.g. debug code for
    bitplanes

So at first I want to start with chunky 8 bpp 640x480, but later I want to add
support for other pixel formats and visuals.

GdkRgb allows to easily draw 8 bpp pseudocolor or grayscale, and 24 or 32 bpp
RGB, and display it on whatever X server you have available.

> > BTW, it's libX11 that needs libpthread...
>
> Oops.  I'd expected it is one of the many gtk libs ...

Me too, but it proved to be different...

Right now I added dummies for the various needed pthread_* calls. The kernel
starts fine, but as soon as I make calls to GTK or GDK it breaks.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
