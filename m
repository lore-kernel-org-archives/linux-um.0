Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM2tW-0007qE-Pn for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 04:20:10 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CM2tV-0004i3-2x
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 04:20:10 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
Message-ID: <20041025110320.GB7551@bytesex>
References: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
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
Date: Mon, 25 Oct 2004 13:03:20 +0200
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

> I looked into this a while ago.  What I found was that you have to add UML 
> to the exclude ifdef in CheckGenericGA() from xfree86/common/xf86Bus.c, and 
> also around all the iopl() and ioperm() exclude ifdefs in 
> xfree86/os_support/linux/linux_video.c.

Well, a compile time option isn't that nice as you usually can run the
very same binaries inside and outside the UML machine ...

> I think it doesn't hurt to add  Option "PciOsConfig"  to the ServerFlags 
> section in the conf file.

Yep, I think that's another issue that on i386 the X-Server might try to
do PCI scans by directly banging on the hardware (for compatibility with
kernels without /proc/bus/pci, which is pre-2.4 (or even pre-2.2?)).

> +++ linux.new/drivers/char/vt.c		Sun Aug  1 13:44:36 2003
> int _kbd_rate(struct kbd_repeat *rep)

Hmm, in 2.6 that doesn't exist any more, probably due to the linux input
layer changes.  How this is called from userspace, is this some ioctl?

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
