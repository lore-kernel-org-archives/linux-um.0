Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfyWl-0006K7-1z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 03:47:35 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfyWk-0002z8-EJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 03:47:35 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260033.25661.blaisorblade@yahoo.it>
	<87sltk9my7.fsf@amaterasu.srvr.nix>
In-Reply-To: <87sltk9my7.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511260547.10683.rob@landley.net>
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
Date: Sat, 26 Nov 2005 05:47:10 -0600
To: Nix <nix@esperi.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 20:12, Nix wrote:
> If it's a problem you have both hostile users and no size limits on /tmp
> and you therefore have bigger problems anyway. :)

The size limits on /tmp aren't per-user.

> >> Yeah, true, if you think the OOM killer is worthwhile (I do: most of the
> >> MM hackers don't. I know who knows more about the Linux kernel's MM and
> >> it's not me!)
> >
> > Its euristics are crap (many cases breaking them), and the concept is
> > crap: damn hell, a C programmer has been taught to check that malloc()
> > can return NULL, not that he should patch a kernel to get a meaningful
> > behaviour.
>
> Yeah, but it does sort of work. Personally I prefer to just never run out
> of memory :)

My laptop has 512 megs of ram, and 700 megs of swap.  I'm running QEMU to boot 
a knoppix image with 256 megs of ram, running UML to build gcc 4 (which has a 
high water mark of disk usage somewhere north of 128 megs).  I have two 
konqueror windows open with an average of 30 tabs in each.  I have kmail open 
with a threaded view of linux-kernel with 69,649 messages in that folder.  
Plus the general overhead for kde, two standalone pdf viewers, several 
terminal windows, a partridge in a pear tree, and so on.

It's been a few weeks since I've triggered the OOM killer, but I've done it.

> > However, the idea of an OOM could be made to work, if you can kill an app
> > based on the derivative of its memory usage (i.e. how fast usage has
> > increased over the last moments).
>
> ... and the VM appears to be growing things that might help in that area :)

We get better as time goes on.

My original point was that the semantics of what UML wants is shared memory.  
It's trusting /tmp to provide different behavior than simply using ~, and 
this turns out to be a very unreliable assumption.  There is a directory 
(/dev/shm) whose entire definition is to provide those semantics, and 
shouldn't even _exist_ if it doesn't.  I believe that would be a better 
directory to use.

I can submit a patch for this.  It's arch/um/os-Linux/mem.c, line 37, in 
find_tempdir().

And while I'm at it, os-Linux/start_up.c has a check_tmpexec() that has "/tmp" 
hardwired into its messages, even if that's not what find_tempdir() 
returned...

> >> > Using /tmp for anything has been kind of discouraged for a while,
> >> > because throwing any insufficiently randomized filename in there is a
> >> > security hole waiting to happen.
> >>
> >> Um, atomically create a directory,
> >
> > DoS-able if filenames are predictable...
>
> ... with a random name, obviously. :)

Like "/tmp/uml.ctl" in arch/um/drivers/daemon_kern.c, line 70?

(It's not obvious where this file is actually created, it's one of those funky 
callback things where data in a structure is used somewhere else...)

> > Never seen anybody doing it, IIRC. Not even mkstemp() (even if today I
> > discover mkdtemp()).
>
> Oh. I do it all the time. I prefer not to work under the assumption that
> I'm more brilliant than thirty years of Unix hackers and spotted
> something none of them did, but so be it...

30 years ago the Unix hackers were working on a 16-bit PDP-11 with two RK05 
disk packs storing 2.5 megabytes each.  And the reason they duplicated /bin 
and /sbin and /lib under /usr is that they ran out of space on the root disk 
and had to leak the OS into the second disk pack which had previously held 
all the user home directories.  And people never revisited this decision for 
the next three decades, despite the fact the "needed for early boot" 
rationale was entirely a pragmatic thing of the moment, and makes _no_ sense 
on a modern system ever since the invention of the initial ramdisk, let alone 
initramfs.  I personally symlink /bin, /sbin, and /lib to the 
corresponding /usr directories and consolidate the whole mess, myself.  Yes, 
you have to patch gcc's paths (in collect2) to not search _both_ /lib 
and /usr/lib because if gnu's linker finds the same symbols in two different 
libraries it statically links them in rather than trying to figure out which 
one is right, resulting in executables as big as if they're statically linked 
but still refusing to run if they can't find their shared libraries at run 
time.  That's a bug in ld.

The point is, it's important to know _what_ conclusions the 30 years of unix 
hackers came to, but keep in mind that the computing environment of 2005 is 
in some ways very different from the computing environments of 1976 or 1984.

> > - back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount
> > the new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.
>
> Ah, well, I never use initrd if I can avoid it, and a bug in one tool is
> a reason to *fix that tool*, not rejig teh whole damn system.

I agree initrd is kinda pointless, but initramfs isn't.  The kernel guys are 
moving towards initramfs being required someday.  These are still nebulous 
future plans with no actual deadline, but they include moving to dynamically 
assigned major/minor numbers (so you need something like udev to 
populate /dev), having userspace find and mount the real root partition (so 
when you're booting from a USB key but your root paritition lives on an NFS 
server that in order to access it you have to dhcp yourself an address, 
nslookup the server name, and then login with a public key from said USB 
stick...)  All the various partitioning schemes could be moved over to device 
mapper.  And so on.

They'd proposed a serious kernel crapectomy "for 2.7" back before 2.7 got put 
on indefinite hold.  How they're rolling it out now, we dunno.  They seem to 
be happy chewing their current mouthful, at the moment...

> (and `mount', of course, only lists mounts if you trust /proc/mounts to
> be accurate.

If the kernel doesn't know what's mounted, you have bigger problems.

> What does it look like in this brave new world of shared 
> subtrees?

I had this discussion on the kernel list a week or so back: namespaces are 
reference counted so as soon as the last process that can see a mount goes 
away, umount happens.  This means that umount -a should only zap everything 
in your current namespace, so that after init kills all sub-processes it can 
then run umount -a for pid 1, life is good.

I had this discussion because I wanted to make sure busybox umount would be 
doing it right.

> Obviously /etc/mtab *must* be a symlink to /proc/mounts, now, 
> only oops that breaks the quota tools...)

I rewrote busybox mount so that things work properly with /proc/mounts.  And I 
vaguely remember coming up with an in-house patch to fix the quota tools 
(they were upset by rootfs) something like four years ago.

> > (Btw, the problem was that he added a new external disk, but labeled it
> > /boot, like an existing /boot partition , so mount -a choked with
> > "duplicate label '/boot'" and it stopped before mounting /home).
>
> I think now is an appropriate time to say
>
> I HATE FSCKING MTAB
>
> (in three-part harmony, probably)

Everybody hates /etc/mtab.  It doesn't work if you chroot.  It can't handle 
--bind or --move mounts...  Just symlink it to /proc/mounts and recognize 
that any tool that can't handle that is a buggy tool that needs to be fixed.

> >> You've never used dar in infinint mode or watched large matrix maths
> >> stuff churn through to completion :/ there really are things with insane
> >> memory requirements and good locality of reference. (I think the most I
> >> ever saw dar eat was 15Gb of swap. *gah*)
> >
> > Boy, be serious - we are talking about normal systems, and you know that
> > you'd better run dar on properly sized systems...
>
> I still boggle that infinint mode is the default for that tool.

First time I've heard of the tool, but then back under 2.4.7 I remember I had 
rsync regularly triggering the OOM killer.  Not because rsync was leaking, 
but because the servers backing up only had 128 megs of memory and the 
balancing was _terrible_ so the dentry cache and page cache would squeeze out 
anonymous pages to the point where rsync itself got OOM killed...

People who want truly insane amounts of memory these days (often for graphics 
or video editing) tend to mmap their data files directly and work in there.  
Once again rendering insane amounts of swap less useful...

I'm under the vague impression there's some kind of madvise you can do that 
says "don't flush this before close unless you're responding to memory 
pressure".  Hmmm...  Closest I can find is MADV_RANDOM...

If we had a "treat this like it's on tmpfs" madvice, that would be ideal...

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
