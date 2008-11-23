Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rmy@tigress.co.uk>) id 1L4ImY-0003FW-J0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Nov 2008 17:30:02 +0000
Received: from mail.tigress.co.uk ([195.172.168.163] helo=intgat.tigress.co.uk)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L4ImV-0005IS-79
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Nov 2008 17:30:02 +0000
Received: (from uucp@localhost)
	by intgat.tigress.co.uk (8.13.1/8.13.1) id mANHTtIu013295
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 23 Nov 2008 17:29:55 GMT
Received: from tiffany.internal.tigress.co.uk (tiffany [157.147.97.76])
	by tigress.co.uk (8.12.11.20060308/8.11.6) with ESMTP id mANHTBfo016281
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 23 Nov 2008 17:29:11 GMT
Received: from tiffany.internal.tigress.co.uk (localhost [127.0.0.1])
	by tiffany.internal.tigress.co.uk (8.13.8+Sun/8.13.8) with ESMTP id
	mANHTA7l020563 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 23 Nov 2008 17:29:11 GMT
Received: (from rmy@localhost)
	by tiffany.internal.tigress.co.uk (8.13.8+Sun/8.13.8/Submit) id
	mANHT1uE020562 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Nov 2008 17:29:01 GMT
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200811231729.mANHT1uE020562@tiffany.internal.tigress.co.uk>
Date: Sun, 23 Nov 2008 17:28:59 +0000
MIME-Version: 1.0
Subject: [uml-devel] A shared memory framebuffer for UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

I've done some work on a patch to implement a shared memory framebuffer
for UML.  (Patch to follow in a separate message, or pick it up from
my website:  http://intgat.tigress.co.uk/rmy/shmfb/index.html)

Apply the patch and build the kernel in the usual way:

   tar xfj linux-2.6.27.7.tar.bz2
   cd linux-2.6.27.7
   patch -p1 <linux-2.6.27.7-shm-fb.patch
   make defconfig ARCH=um
   make menuconfig ARCH=um
   make linux ARCH=um

During the menuconfig phase you should enable framebuffer devices
(UML-specific options/Graphics support/Support for frame buffer
devices). Then, in the UML-specific options/Graphics support/Console
display driver support menu disable VGA text console, enable Framebuffer
Console support, enable Select compiled-in fonts and select a suitable
font, for example, VGA 8x16 font. Back in the UML-specific options menu
enable Shared Memory Framebuffer driver.

To enable the shared memory framebuffer device add the option
shmfb=widthxheightxdepth to the kernel command line. For example,
shmfb=800x600x4. The width and height can have any reasonable values. The
depth can currently only be 2 or 4 bytes per pixel.

When the kernel boots it will use the framebuffer device as its console,
but you won't be able to see anything! To make the framebuffer console
visible you need a separate client application to run on the host. Two
clients are provided, a simple Xt-based window and a VNC server:

   http://intgat.tigress.co.uk/rmy/shmfb/uml_fb-0.1.0.tar.gz

To build the VNC server client you'll need libvncserver. If this isn't
in your distro's package repository you can get it from the project's
Sourceforge page: http://libvncserver.sourceforge.net/.

Once you've built the clients you can run them as:

   uml_xtfb --umid <name>

or

   uml_vncfb --umid <name>

where <name> is the name of your UML instance. If you've run the VNC
client you still won't be able to see anything! You now need to run a
VNC viewer:

   vncviewer localhost:0

As an alternative to starting the client programs by hand you can also use
a kernel command line option of the form shmfb_client=<path_to_client>,
where <path_to_client> is, as you might expect, the path to the client
you'd like to use.

There are a few problems with the client programs:

    * the cursor in the virtual console doesn't track the mouse very well;
    * the X server in the UML instance tends to get confused and sends
      the mouse to the top left hand corner of the display, where it sits
      and sulks.
    * the mouse wheel doesn't work;
    * the VNC client is hardcoded for a US keyboard. (Probably. I've
      got a UK keyboard, so some of the less used characters may not be
      quite right);
    * if any keys are pressed when the client loses focus it never sees
      the key release, so thinks that, for example, the control key is
      always pressed.

(Adjusting the mouse acceleration in the console mouse server (gpmd)
or X server (set m, or your desktop manager's GUI equivalent) helps with
some of the mouse issues.)

The kernel patch is based on the X11 framebuffer driver by Gerd
Knorr. Without Gerd's work I wouldn't have been able to achieve
anything. Thanks!

Any problems with the patch are my fault.  In particular, I'd very much
appreciate some hint as to what should be done about fb_pgprotect in fb.h.

Ron

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
