Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM35D-0001VR-Te for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 04:32:15 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM35B-0006dL-4w for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 04:32:15 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
In-Reply-To: <20041025110320.GB7551@bytesex>
Message-ID: <Pine.GSO.4.61.0410251326250.25582@waterleaf.sonytel.be>
References: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
	<20041025110320.GB7551@bytesex>
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
Date: Mon, 25 Oct 2004 13:28:05 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, User-mode Linux Kernel Development <User-mode-linux-devel@lists.sourceforge.net>

On Mon, 25 Oct 2004, Gerd Knorr wrote:
> > I looked into this a while ago.  What I found was that you have to add UML 
> > to the exclude ifdef in CheckGenericGA() from xfree86/common/xf86Bus.c, and 
> > also around all the iopl() and ioperm() exclude ifdefs in 
> > xfree86/os_support/linux/linux_video.c.
> 
> Well, a compile time option isn't that nice as you usually can run the
> very same binaries inside and outside the UML machine ...

Indeed.

> > I think it doesn't hurt to add  Option "PciOsConfig"  to the ServerFlags 
> > section in the conf file.
> 
> Yep, I think that's another issue that on i386 the X-Server might try to
> do PCI scans by directly banging on the hardware (for compatibility with
> kernels without /proc/bus/pci, which is pre-2.4 (or even pre-2.2?)).

/proc/bus/pci is 2.4, IIRC.
/proc/pci was 2.2 or 2.0.

> > +++ linux.new/drivers/char/vt.c		Sun Aug  1 13:44:36 2003
> > int _kbd_rate(struct kbd_repeat *rep)
> 
> Hmm, in 2.6 that doesn't exist any more, probably due to the linux input
> layer changes.  How this is called from userspace, is this some ioctl?

| tux$ grep kbd_rep linux-2.6.9/drivers/char/*c
| linux-2.6.9/drivers/char/keyboard.c:int kbd_rate(struct kbd_repeat *rep)
| linux-2.6.9/drivers/char/vt_ioctl.c:            struct kbd_repeat kbrep;
| linux-2.6.9/drivers/char/vt_ioctl.c:            if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat)))
| linux-2.6.9/drivers/char/vt_ioctl.c:            if (copy_to_user(up, &kbrep, sizeof(struct kbd_repeat)))
| tux$

Keyboard rate has been controlled using an ioctl() since ages, but of course X
kept on banging the hardware...

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
