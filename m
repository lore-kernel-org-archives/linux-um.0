Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzXFQ-0006dV-MR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:05:44 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BzXFQ-0005n1-29 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:05:44 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] gdkfb
In-Reply-To: <20040824084755.GA32746@bytesex>
Message-ID: <Pine.GSO.4.58.0408241103040.26345@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0408021210420.23627@anakin>
	<87isb9yjfj.fsf@bytesex.org>
	<Pine.LNX.4.58.0408232116540.13834@anakin>
	<20040824084755.GA32746@bytesex>
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
Date: Tue, 24 Aug 2004 11:05:28 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 24 Aug 2004, Gerd Knorr wrote:
> > > Q2: Any chance to track the changes (using page faults maybe?),
> > >     so I can do more clever screen updates than simply blitting
> > >     the whole screen now and then?
> >
> > BenH told me at OLS that Mac-On-Linux uses page faults.
>
> Do you have details on that?

No, I haven't looked at MOL yet.

> > You can look at the logic of take_over_console().
>
> No, doesn't help.  The current uml stdio console acts one level below
> that.  It doesn't register as linux console driver, but as tty driver
> for the major/minor numbers usually used by the linux console subsystem
> for the virtual consoles.

Yep, forgot about that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
