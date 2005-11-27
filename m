Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgRJJ-0000gC-E5 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:31:37 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user88658)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgRJE-0002vR-2R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:31:33 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260033.25661.blaisorblade@yahoo.it>
	<87sltk9my7.fsf@amaterasu.srvr.nix>
	<200511260547.10683.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511260547.10683.rob@landley.net> (Rob Landley's message of
	"Sat, 26 Nov 2005 05:47:10 -0600")
Message-ID: <877jau7xjc.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 27 Nov 2005 18:31:19 +0000
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Sat, 26 Nov 2005, Rob Landley murmured woefully:
> On Friday 25 November 2005 20:12, Nix wrote:
>> If it's a problem you have both hostile users and no size limits on /tmp
>> and you therefore have bigger problems anyway. :)
> 
> The size limits on /tmp aren't per-user.

True. TODO: add tmpfs quota support. :)

>> > However, the idea of an OOM could be made to work, if you can kill an app
>> > based on the derivative of its memory usage (i.e. how fast usage has
>> > increased over the last moments).
>>
>> ... and the VM appears to be growing things that might help in that area :)
> 
> We get better as time goes on.
> 
> My original point was that the semantics of what UML wants is shared memory.  
> It's trusting /tmp to provide different behavior than simply using ~, and 
> this turns out to be a very unreliable assumption.  There is a directory 
> (/dev/shm) whose entire definition is to provide those semantics, and 
> shouldn't even _exist_ if it doesn't.  I believe that would be a better 
> directory to use.

I have to agree, not least because it is counterintuitive to set a strict
size limit on /tmp on the host and then find you can't start big UMLs.

>> ... with a random name, obviously. :)
> 
> Like "/tmp/uml.ctl" in arch/um/drivers/daemon_kern.c, line 70?

Um. :/

>             I personally symlink /bin, /sbin, and /lib to the 
> corresponding /usr directories and consolidate the whole mess, myself.  Yes, 
> you have to patch gcc's paths (in collect2) to not search _both_ /lib 
> and /usr/lib because if gnu's linker finds the same symbols in two different 
> libraries it statically links them in rather than trying to figure out which 
> one is right, resulting in executables as big as if they're statically linked 
> but still refusing to run if they can't find their shared libraries at run 
> time.  That's a bug in ld.

I'll say! I'll see if I can fix that (if it isn't already fixed: I'm having
trouble reproducing it here, with binutils 2.16.91.0.2...)

>> > - back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount
>> > the new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.
>>
>> Ah, well, I never use initrd if I can avoid it, and a bug in one tool is
>> a reason to *fix that tool*, not rejig the whole damn system.
> 
> I agree initrd is kinda pointless, but initramfs isn't.  The kernel guys are 
> moving towards initramfs being required someday.

I didn't properly understand the difference (using rootfs versus not) when
I wrote that email. I do now thanks to your nice little document recently
mentioned on l-k, and I have to agree that initramfs seems a whole lot nicer.

>                                                  These are still nebulous 
> future plans with no actual deadline, but they include moving to dynamically 
> assigned major/minor numbers (so you need something like udev to 
> populate /dev),

How terrible. :)

>                 having userspace find and mount the real root partition (so 
> when you're booting from a USB key but your root paritition lives on an NFS 
> server that in order to access it you have to dhcp yourself an address, 
> nslookup the server name, and then login with a public key from said USB 
> stick...)  All the various partitioning schemes could be moved over to device 
> mapper.  And so on.

It's a little annoying for those of us *without* horribly complex boot
schemes; I guess there'll be a `default initramfs' which replicates the
current behaviour.

> They'd proposed a serious kernel crapectomy "for 2.7" back before 2.7 got put 
> on indefinite hold.  How they're rolling it out now, we dunno.  They seem to 
> be happy chewing their current mouthful, at the moment...

Yeah, the change rate of the kernel doesn't exactly seem to be at an
all-time low :)

>> What does it look like in this brave new world of shared 
>> subtrees?
> 
> I had this discussion on the kernel list a week or so back: namespaces are 
> reference counted so as soon as the last process that can see a mount goes 
> away, umount happens.  This means that umount -a should only zap everything 
> in your current namespace, so that after init kills all sub-processes it can 
> then run umount -a for pid 1, life is good.

Yeah, but what does /proc/mounts say? Does it show only references that the
querying process can see?

... actually, hey, yes, it's a symlink to /proc/self/mounts, so it does the
right thing already. Nifty.

>> Obviously /etc/mtab *must* be a symlink to /proc/mounts, now, 
>> only oops that breaks the quota tools...)
> 
> I rewrote busybox mount so that things work properly with /proc/mounts.  And I 
> vaguely remember coming up with an in-house patch to fix the quota tools 
> (they were upset by rootfs) something like four years ago.

Please feed it upstream to the quota tools people before I have to write the
same damn patch ;)))

>> I HATE FSCKING MTAB
>>
>> (in three-part harmony, probably)
> 
> Everybody hates /etc/mtab.  It doesn't work if you chroot.  It can't handle 
> --bind or --move mounts...  Just symlink it to /proc/mounts and recognize 
> that any tool that can't handle that is a buggy tool that needs to be fixed.

Well, ideally the kernel should allow mount(2) to feed it *arbitrary*
options in the `data' argument, reflecting those it doesn't understand
back into /proc/mounts. That would avoid breaking the quota tools and,
um, whatever else depends on this (I've seen distributed administration
tools that mark up filesystems with custom options in the expectation
that they'll land in mtab, too: I think there's some automated fstab
editor in HAL that does the same thing).

[...]
> First time I've heard of the tool, but then back under 2.4.7 I remember I had 
> rsync regularly triggering the OOM killer.  Not because rsync was leaking, 
> but because the servers backing up only had 128 megs of memory and the 
> balancing was _terrible_ so the dentry cache and page cache would squeeze out 
> anonymous pages to the point where rsync itself got OOM killed...

Ick, yes. I switched to 2.4 around that time and switched right back to
2.2 again because the MM had so many problems...

> People who want truly insane amounts of memory these days (often for graphics 
> or video editing) tend to mmap their data files directly and work in there.  
> Once again rendering insane amounts of swap less useful...

Not necessarily, given the existence of MAP_PRIVATE. (The problem with working
directly in data files without MAP_PRIVATE is that if you lose power at *any*
time, your data file is toast.)

> If we had a "treat this like it's on tmpfs" madvice, that would be ideal...

Agreed. Combine that with per-user filesytems and, well, give every user
a small tmpfs mount of their own on /tmp and let apps use suitably
advised mmaps for everything else :)

(security holes? but other users can't *see* that /tmp, which is why it's
mode 640, just like their $HOME...)

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
