Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D82tN-0002ho-3V for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 13:02:25 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D82tL-0004tp-3B
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 13:02:25 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Triage on the pending patches
References: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
	<200503032111.43966.rob@landley.net>
	<200503051657.59188.blaisorblade@yahoo.it>
In-Reply-To: <200503051657.59188.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503061459.19128.rob@landley.net>
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
Date: Sun, 6 Mar 2005 14:59:19 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Saturday 05 March 2005 10:57 am, Blaisorblade wrote:
> > Basically, my nefarious scheme is to add the squashfs patch to UML,
> > append a squashfs image to the end of the  UML executable, and have a
> > cpio ramfs init script search through /proc/self/exe for the 32 bytes
> > that were at the start of the squashfs (which includes a 4 byte magic
> > signature thingy) to determine offset to pass to "losetup -o $OFFSET
> > /dev/loop0 /proc/self/exe", and then mount /dev/loop0 / and run the
> > executable I want out of that filesystem.
>
> First, compliments.... we need such stuff going.
>
> Please note that unless I'm mistaken the above scheme does not work
> since /proc/self/exe contains what you want on the host, not on the guest.
> If you use hostfs then it's ok, otherwise you'll have to pack the squashfs
> within the cpio image (if it's possible, the cpio image could not be ready
> to cope with so much data).

That would suck mightily, since it would decompress it into ram and then eat 
swap space instead of using the file as backing store.

No, I'm a big fan of hostfs.  Part of this will probably involve changing the 
default command line of UML to something like:

rootfstype=hostfs rootflags=/ rw quiet mem=48M

Or some such.  Then /proc/self/exe is quite happy, and I can find my file to 
loopback mount it.  I can also chdir to (a readlink of) /proc/self/cwd, so 
that whatever application I'm running is working in the right current 
directory.

I think I can make it relatively transparent to the hosted application, even.  
If I want to get silly I can su away from root so things like tar aren't 
confused that they can't do mknod and chown and such, or else I can mount a 
loopback ext2 filesystem on /tmp or some such hack to give it space it can 
play permission games with...

> Also, made sure adding stuff at the end of an 
> exec. file is accepted without problems? Seems reasonable but not obvious.

If it's ELF, life should be good because the elf sections say where everything 
is and how long it is.  (Non-elf, you're on your own.)

I pondered making all this an elf section, but don't know how off the top of 
my head...

> No experience with such stuff, but isn't it a bit risky this way (a
> signature being there by mistake)? If you still go for grepping the exec.
> image, I would add a header in the end giving the size of the squashfs
> image, and parse it. With the -s option to losetup you can cut at the end
> the area seeing by the loop device.

I could do that.  Squashfs starts with a (4 byte) magic number, and I was 
worried that was insufficient so I'm grabbing the first 32 bytes to reduce 
the possibility of collisions.  (The random occurrence of 32 identical bytes 
is really really unlikely if those bytes are at all well distributed.  Not 
quite 1 in 2^256 unlikely, but pretty darn up there.  I'm basically waiting 
for the easy way to break, and implementing something else if it does.)

Sticking the length on the end is another quite valid option.  I don't even 
have to tell losetup to truncate the loop device because none of the 
filesystems I care about are put off by trailing garbage...

> Add early_printk which is a printf but shuts down when the quiet option is
> used.

Cool.  Will do.

Thanks,

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
