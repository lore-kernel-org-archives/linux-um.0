Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM7KZ-00020v-Sj for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 09:04:23 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM7KZ-000503-6g for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 09:04:23 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
In-Reply-To: <20041025154753.GA10318@bytesex>
Message-ID: <Pine.GSO.4.61.0410251802520.25582@waterleaf.sonytel.be>
References: <BAY24-F2R77bieLYCT40001280e@hotmail.com>
	<20041025110320.GB7551@bytesex>
	<Pine.GSO.4.61.0410251326250.25582@waterleaf.sonytel.be>
	<20041025114055.GB7895@bytesex>
	<Pine.GSO.4.61.0410251403130.25582@waterleaf.sonytel.be>
	<20041025154753.GA10318@bytesex>
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
Date: Mon, 25 Oct 2004 18:04:14 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, User-mode Linux Kernel Development <User-mode-linux-devel@lists.sourceforge.net>

On Mon, 25 Oct 2004, Gerd Knorr wrote:
> > > Guess I'll go fetch the good, old XF86_FBDev server for the next
> > > experiments ...
> 
> Well, that one segfaults in a function called "xf86SetKbdRepeat".
> *gna*, this is not funny :-/

Ah yes, it was compiled for ia32 ;-)

Compile TinyX/KDrive yourself?

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
