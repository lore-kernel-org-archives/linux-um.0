Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgRkx-00028t-40 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:00:11 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgRkq-0005N0-MS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:00:08 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260547.10683.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
In-Reply-To: <200511271837.14625.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271259.35968.rob@landley.net>
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
Date: Sun, 27 Nov 2005 12:59:35 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 11:37, Blaisorblade wrote:
> > Like "/tmp/uml.ctl" in arch/um/drivers/daemon_kern.c, line 70?
> >
> > (It's not obvious where this file is actually created, it's one of those
> > funky callback things where data in a structure is used somewhere
> > else...)
>
> It's not a file, it's a AF_UNIX socket bound there - and bind() fails if
> the file exists. So it's a different story (I was puzzled by a missing
> bind(O_EXCL), but I learned with trial there's no need).
>
> It's created at uml_switch (not setuid) startup, which can be done by
> anybody.
>
> Btw, Debian moves that socket to something under /var/run/uml-utilities or
> something like that.

Any user can create /tmp/uml.ctl and the sticky bit prevents anybody else from 
deleting it, so any user can block UML switch from working right.  
Under /var/run you can have a persistent directory belonging to a GID or some 
such that UML switch is setgid to, so under /var you are at least _capable_ 
of dealing with this sort of thing...

> > > Oh. I do it all the time. I prefer not to work under the assumption
> > > that I'm more brilliant than thirty years of Unix hackers and spotted
> > > something none of them did, but so be it...
>
> I recently realized that even the mktemp(1) utility works - it creates the
> file and returns the pathname. I kept wondering "but what if an attacker
> alters the file afterward", but I forgot the sticky bit - nobody else can
> delete my file.

Although if your permissions are wrong they can alter its contents.  But yeah, 
the stick bit's a good thing...

> > And the reason they duplicated /bin
> > and /sbin and /lib under /usr is that they ran out of space on the root
> > disk and had to leak the OS into the second disk pack which had
> > previously held all the user home directories.
>
> Seen this argumentation for Hurd systems... However until LVM2
> (and-all-the-rest)-on-root works out of the box, I'll call anything else
> crap.

What argument for hurd systems?  Hard drives are enormous these days, and if 
your OS itself is larger than 10 gigs there's something deeply wrong with it.  
(Your application data may be huge, but that's not your OS.)

> > I agree initrd is kinda pointless, but initramfs isn't.  The kernel guys
> > are moving towards initramfs being required someday.  These are still
> > nebulous future plans with no actual deadline, but they include moving to
> > dynamically assigned major/minor numbers (so you need something like udev
> > to
> > populate /dev),
>
> Nice move to disable init=/bin/sh. Really. Next one is moving kdelibs into
> the kernel?

Try "rdinit=/bin/sh", that affects what init gets run on the initramfs.  
(Assuming the initramfs has a comand shell...)

> > > I HATE FSCKING MTAB
> > >
> > > (in three-part harmony, probably)
> >
> > Everybody hates /etc/mtab.  It doesn't work if you chroot.
>
> Right.
>
> > It can't handle
> > --bind or --move mounts...
>
> In my experience it does (I have 2/3 distros and use chrooting often, so I
> loop-mount half my disk):

So this was fixed in util-linux then?  (I know _busybox_ gets it right, but 
that's because I took it into account in my rewrite...)

http://www.busybox.net/lists/busybox/2005-August/015285.html

> > Just symlink it to /proc/mounts and recognize
> > that any tool that can't handle that is a buggy tool that needs to be
> > fixed.
>
> No - the kernel doesn't allow storing the full set of infos which are added
> by mount there. And frankly I don't want the kernel to do that.

For which use?  I got the loopback functionality working just fine (to the 
point where you don't have to specify -o loop anymore.  If you try to mount a 
file instead of a block device, it'll do the losetup for you.  I'm pondering 
adding support for "mount -o offset=12345 file.img /woot" even...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
