Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzXAV-00060V-HX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:00:39 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BzXAS-00052u-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:00:39 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] gdkfb
Message-ID: <20040824084755.GA32746@bytesex>
References: <Pine.LNX.4.58.0408021210420.23627@anakin>
	<87isb9yjfj.fsf@bytesex.org>
	<Pine.LNX.4.58.0408232116540.13834@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408232116540.13834@anakin>
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
Date: Tue, 24 Aug 2004 10:47:55 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

> > stealing ENTER keys ;)
> 
> That's the advantage. The disadvantage is that's it's more difficult to
> write a GUI for it...

I don't plan to write a GUI.

> My main reason to work on a frame buffer device for UML is debugging the
> fbdev subsystem. I.e. I want a GUI to tune various parameters
> (resolution, color depth, pixel format, ...).

Ok, thats a different focus ;)

> > Size is configurable at boot time.  Runs on TrueColor displays only.
> > Screen parameters are passed through, i.e. if your X11 display is
> > 16bpp the fb device inside the uml machine will have 16bpp as well, so
> > I don't have to convert any data ;)
> 
> That's indeed simple. Have you tried running on X with depth 24?
> So far I tried on my Athlon with Radeon 9200 in depth 24, and I get the
> attached result (xdpyinfo output attached as well). Colors are a bit
> off.

Yep, here as well.  Looks like the X-Server uses 32 bit/pixel but x11fb
uses 24 bit/pixel.  I had tested 16bpp only.

> > One thread for the communication with the X-Server, any events (fb
> > updates, data on the X11 socket) will wake up that thread to handle
> > it.  Screen updates can happen much more often than once per second.
> > Only changed screen areas will be updated.
> 
> You seem to have much more experience with threads in UML than I have...

It's my first uml kernel thread ;)

But I have both general X11 and kernel programming experience, which
helps alot, yes.

> > Same here (no special logo through).
> 
> So I attached a patch to bring it back ;-)

I'll have a look.

> > >   - Userspace access to the frame buffer doesn't work yet.
> >
> > Same here.  Havn't even looked at that yet.  The memory block for the
> > framebuffer is either simply malloced or a shared memory segment,
> > depending on whenever sharing memory with the X-Server works or not
> > (MIT-SHM Extention).
> >
> > Q1: Can I map that into the address space of a uml process?
> 
> Maybe. It may be safer to use kmalloc() (limited size), or just steal it from
> the UML system memory, to make sure /dev/fb mmap() can use a similar
> implementation as /dev/mem mmap() (this assumes /dev/mem mmap() works in
> UML).

Problem is I _want_ use shared memory (if possible) for performance
reasons.  And if possible remap that directly into the applications
address space.  Looking at /dev/mem is a nice idea through ;)

> > Q2: Any chance to track the changes (using page faults maybe?),
> >     so I can do more clever screen updates than simply blitting
> >     the whole screen now and then?
> 
> BenH told me at OLS that Mac-On-Linux uses page faults.

Do you have details on that?

Device drivers can catch missing pages via ->no_page() handler.  Not
sure whenever it is possible to catch write access to read-only mappings
as well, but as apps usually do write-only access to fb memory not
having read-only mappings shouldn't hurt much.

So one possible way I can see is to map in the pages in the nopage
handler.  For screen updates you can check which pages are actually
mapped and only update these.  And also unmap them, so you'll get a new
page fault if the application writes to them again.

> > The updated patch does that as well now.  There seems to be no way to
> > switch at runtime between the stdio console and the vt subsystem, if
> > vt is enabled it is registered for /dev/tty<n> unconditionally, even
> > without any console driver being activated (no dummy console, no
> > fbcon).
> 
> You can look at the logic of take_over_console().

No, doesn't help.  The current uml stdio console acts one level below
that.  It doesn't register as linux console driver, but as tty driver
for the major/minor numbers usually used by the linux console subsystem
for the virtual consoles.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
