Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUE9q-0008TX-PN	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 19:03:22 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUE9p-0008LQ-AX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 19:03:22 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Unassociated ubd in sysfs?
References: <200510221318.00565.rob@landley.net>
	<200510250124.21434.blaisorblade@yahoo.it>
In-Reply-To: <200510250124.21434.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510242103.11608.rob@landley.net>
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
Date: Mon, 24 Oct 2005 21:03:11 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 24 October 2005 18:24, Blaisorblade wrote:
> On Saturday 22 October 2005 20:18, Rob Landley wrote:
> > I'm trying to play with a system that doesn't have any hardwired
> > major/minors in it, just an initscript doing "find /sys -name dev", a bit
> > of sed work, and mknod.  (Eventually I'll get the full udev up, but for
> > now a dumb little shell script works pretty well.)
> >
> > Unfortunately, it doesn't list any unassociated ubd devices when I do
> > this. I get loop devices, ttys, even /dev/zero and friends, but no ubd.
> >
> >  If I
> > associate one with a file from the command line, it shows up in sys,
>
> Ah, ok, sorry for my previous email. Yes, this matches with what I
> remember. And this also makes sense - it's as for hd* - only present
> devices are shown.

I was expecting it to behave like loop devices.  You can't losetup 
a /dev/loop* that isn't there, so if they only show up after losetup binds 
them to something there's a chicken and egg problem with anything like udev.

> > but I
> > was under the impression I could associate them from "mount" as well..?
>
> Sorry, but __how__?

Apparently it's not implemented.

> And to _which purpose_? 

To try to find an existing block device from the script running inside the UML 
instance?

I suppose I'm trying to do something strange.  After all, with normal bootable 
kernels trying to mount NFS partitions, it would be silly to try to specify 
the server to attach to from the mount command rather than specifying the 
association at boot time on the kernel command line...

I can modify the kernel's default command line to work around this.  Or 
possibly come up with my own patch...

> The only way you have is:
> *) ssh/(telnet) to the host
> *) uml_mconsole
> *) config ubd0=path (path relative to the UML cwdir at startup). Yes, this
> is hotplug. And it also works for network devices. It's as wonderful as it
> gets.

I keep thinking that when I do things like "mount -t hostfs path1 path2" that 
path1 actually means something.  My bad.

I only recently started playing with ubd because I needed swap partitions.  
(You can't compile gcc 4.0.2 in 128 megs of ram.  You must either specify 256 
megs of ram or provide swap.)

Rob

P.S.  My Firmware Linux thing had another release.

http://www.landley.net/code/firmware

If you don't feel like building from source, I have a precompiled 2.5 megabyte 
UML containing busybox and uClibc in a squashfs partition that's appended to 
the executable and automatically loopback mounted on boot via an initramfs 
that mounts hostfs, finds /proc/self/exe, and does the losetup and 
not-quite-pivot_root...

http://www.landley.net/code/firmware/downloads/base-uml

Fun little proof-of-concept, that...


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
