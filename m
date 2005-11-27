Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgQT6-0006Eg-QU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 09:37:40 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgQSt-00087w-8r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 09:37:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87sltk9my7.fsf@amaterasu.srvr.nix>
	<200511260547.10683.rob@landley.net>
In-Reply-To: <200511260547.10683.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271837.14625.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 18:37:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Saturday 26 November 2005 12:47, Rob Landley wrote:
> On Friday 25 November 2005 20:12, Nix wrote:
> > If it's a problem you have both hostile users and no size limits on /tmp
> > and you therefore have bigger problems anyway. :)

> My original point was that the semantics of what UML wants is shared
> memory. It's trusting /tmp to provide different behavior than simply using
> ~, and this turns out to be a very unreliable assumption.  There is a
> directory (/dev/shm) whose entire definition is to provide those semantics,
> and shouldn't even _exist_ if it doesn't.  I believe that would be a better
> directory to use.

> I can submit a patch for this.  It's arch/um/os-Linux/mem.c, line 37, in
> find_tempdir().

> And while I'm at it, os-Linux/start_up.c has a check_tmpexec() that has
> "/tmp" hardwired into its messages, even if that's not what find_tempdir()
> returned...

Good note... I'd gladly accept that.

> Like "/tmp/uml.ctl" in arch/um/drivers/daemon_kern.c, line 70?
>
> (It's not obvious where this file is actually created, it's one of those
> funky callback things where data in a structure is used somewhere else...)

It's not a file, it's a AF_UNIX socket bound there - and bind() fails if the 
file exists. So it's a different story (I was puzzled by a missing 
bind(O_EXCL), but I learned with trial there's no need).

It's created at uml_switch (not setuid) startup, which can be done by anybody.

Btw, Debian moves that socket to something under /var/run/uml-utilities or 
something like that.

> > Oh. I do it all the time. I prefer not to work under the assumption that
> > I'm more brilliant than thirty years of Unix hackers and spotted
> > something none of them did, but so be it...

I recently realized that even the mktemp(1) utility works - it creates the 
file and returns the pathname. I kept wondering "but what if an attacker 
alters the file afterward", but I forgot the sticky bit - nobody else can 
delete my file.

> And the reason they duplicated /bin
> and /sbin and /lib under /usr is that they ran out of space on the root
> disk and had to leak the OS into the second disk pack which had previously
> held all the user home directories.

Seen this argumentation for Hurd systems... However until LVM2
(and-all-the-rest)-on-root works out of the box, I'll call anything else 
crap.

> I agree initrd is kinda pointless, but initramfs isn't.  The kernel guys
> are moving towards initramfs being required someday.  These are still
> nebulous future plans with no actual deadline, but they include moving to
> dynamically assigned major/minor numbers (so you need something like udev
> to
> populate /dev),

Nice move to disable init=/bin/sh. Really. Next one is moving kdelibs into the 
kernel?

> They'd proposed a serious kernel crapectomy 
Yep, I remember.
> "for 2.7" back before 2.7 got 
> put on indefinite hold.  How they're rolling it out now, we dunno.  They
> seem to be happy chewing their current mouthful, at the moment...

> > What does it look like in this brave new world of shared
> > subtrees?

> > Obviously /etc/mtab *must* be a symlink to /proc/mounts, now,
> > only oops that breaks the quota tools...)

> I rewrote busybox mount so that things work properly with /proc/mounts. 
> And I vaguely remember coming up with an in-house patch to fix the quota
> tools (they were upset by rootfs) something like four years ago.


> > I HATE FSCKING MTAB
> >
> > (in three-part harmony, probably)
>
> Everybody hates /etc/mtab.  It doesn't work if you chroot.
Right.
> It can't handle 
> --bind or --move mounts...

In my experience it does (I have 2/3 distros and use chrooting often, so I 
loop-mount half my disk):

$ grep bind /etc/mtab
/home /mnt/gen32/home none rw,bind 0 0
/var/spool/wwwoffle /mnt/gen32/var/spool/wwwoffle none rw,bind 0 0
/mnt/gen32/var/tmp/portage /var/tmp/portage none rw,bind 0 0
/home /mnt/mdk/home none rw,bind 0 0
/mnt/win_c /mnt/gen32/mnt/win_c none rw,bind 0 0

Don't know for shared mounts...

> Just symlink it to /proc/mounts and recognize 
> that any tool that can't handle that is a buggy tool that needs to be
> fixed.

No - the kernel doesn't allow storing the full set of infos which are added by 
mount there. And frankly I don't want the kernel to do that.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
