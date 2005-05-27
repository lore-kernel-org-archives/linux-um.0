Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbiQQ-0005nq-CG	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2005 10:15:10 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DbiQM-000759-Gc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2005 10:15:10 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050527171137.GA15030@bytesex>
References: <428086BE.5060205@exse.net>
	<200505101559.20430.blaisorblade@yahoo.it> <20050510144252.GA8323@bytesex>
	<200505101722.59437.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505101722.59437.blaisorblade@yahoo.it>
Subject: [uml-devel] [patch] x11 framebuffer driver
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
Date: Fri, 27 May 2005 19:11:37 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

> > btw:  I'll have some x11-fb changes in the queue, so there will
> > be at least one more patchkit.  The patch need some more work
> > though.  I'll want to have the x11-fb patch ready for submit
> > soon, so I can push it mainline for 2.6.13.

Uploaded to http://www.suse.de/~kraxel/uml/patches/2.6.12-rc5/
The uml-x11-fb patch depends on xen-vt-runtime

Both kernel-internal usage (fbcon) and userspace apps (map
framebuffer via mmap() and draw there) access the same pages
now, there is no copying between kernel & userspace fb pages any
more.  That should fix all the funny drawing effects older
versions had.  This version can also deal with multiple apps
mapping the framebuffer memory, that should help people testing
embedded stuff (using qt-embedded).

Keyboard issues (uml sometimes having a wrong idea of the
modifier key state) are fixed.

> However, as long as it does not touch anything if disabled, we
> can always ship it while marking it as BROKEN or EXPERIMENTAL.

Even if compiled in it shouldn't have any effect unless you
enable framebuffer + fbcon via "x11=<width>x<height>" on the
kernel command line.  Switching between uml "stdio console" and
fbcon + vt subsystem happens at runtime now (unlike the version
which is @ sf.net where this happens at compile time).

The patch enables quite a few new drivers/subsystems:

  drivers/char
	vt subsystem, fbcon needs this.

  drivers/input
	for virtual keyboard & mouse, X11 input events are
	going this way.

  drivers/video
	framebuffer core & fbcon, obviously needed for a
	framebuffer driver ;)

That might have some unwanted side effects.  It WorksForMe[tm]
though.  I'd consider it ready for mainline now.

Enjoy,

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
