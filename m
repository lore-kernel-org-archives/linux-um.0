Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM3WC-0005q9-U5 for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 05:00:08 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CM3WB-0001P4-8V
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 05:00:08 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
Message-ID: <20041025114055.GB7895@bytesex>
References: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
	<20041025110320.GB7551@bytesex>
	<Pine.GSO.4.61.0410251326250.25582@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410251326250.25582@waterleaf.sonytel.be>
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
Date: Mon, 25 Oct 2004 13:40:55 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, User-mode Linux Kernel Development <User-mode-linux-devel@lists.sourceforge.net>

> | linux-2.6.9/drivers/char/keyboard.c:int kbd_rate(struct kbd_repeat *rep)

Ah, just moved.

That function does already return "success" unconditionally, so we
can't trick X11 by patching that one :-/

Guess I'll go fetch the good, old XF86_FBDev server for the next
experiments ...

> Keyboard rate has been controlled using an ioctl() since ages, but of course X
> kept on banging the hardware...

Yep.  There is also some other code being pretty upset when run within a
UML environment because several assumtions they make about i386 machines
are not true any more.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
