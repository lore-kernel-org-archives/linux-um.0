Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLrOU-0003Ky-OU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 16:35:38 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DLrOR-0001Mw-3m
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 16:35:38 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] The sickest thing that's been done with UML yet.
References: <200504130605.44419.rob@landley.net>
	<20050413152711.GB5089@ccure.user-mode-linux.org>
In-Reply-To: <20050413152711.GB5089@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504131832.16766.rob@landley.net>
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
Date: Wed, 13 Apr 2005 18:32:16 -0400
To: jdike@addtoit.com
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wednesday 13 April 2005 11:27 am, jdike@addtoit.com wrote:
> On Wed, Apr 13, 2005 at 06:05:43AM -0400, Rob Landley wrote:
> > Remember when I talked about making UML and its root filesystem be one
> > file you can just run?  Well, I made one as a proof of concept...
> >
> > http://www.landley.net/code/firmware/notes.html
>
> Hehe, nice.  I've been considering doing this with an initramfs.  It sounds
> like you're doing something different (I couldn't find a one-or-two line
> here's-how-it-works on your page :-).

I _really_ need to update that page.  I've been busy getting the build script 
and source tarball cleaned up for release (possibly even tonight, but don't 
hold your breath)...

How it works: 

It's a squashfs root partition (over 11 of the 13.7 megs), where the initramfs 
script does "mount -t hostfs -o / / /sub", examines sub/proc/self/exe to find 
the running executable, reads bytes 12-15 of that (where I wrote the length 
of the original UML exe; note that the 16 byte elf header ends with 6 bytes 
of padding, I grabbed the last four), and then does an "losetup -o 
$OFFSET /dev/loop0 sub/proc/self/exe", mounts that, pivot_root, and 
exec /bin/sh or /sbin/init or whatever you want...

The reality is slightly more complicated due to details like /proc/self/exe 
being a symlink to an absolute path while hostfs is mounted in a 
subdirectory.  And I had to patch busybox losetup to have a readonly option 
because if losetup tries to open a running executable file read-write it dies 
with a "text file busy" error.  But they weren't too hard to fix.  (Just time 
consuming.)

The main advantage of doing this rather than a huge initramfs is that we don't 
eat so much memory.  The squashfs naturally uses the host file as backing 
store.

P.S.  Hang the UML kernel!  When it comes up, try "mount 
--move /mnt/proc /proc".  Apparently, when rootfs moves and afterwards you 
try to relocate a mount point that's bound under it, something gets very, 
very confused.

Here's the UML options I used:

> make ARCH=um allnoconfig &&
> cat >> .config << EOF &&
> CONFIG_MODE_TT=y
> CONFIG_LD_SCRIPT_STATIC=y
> CONFIG_BINFMT_ELF=y
> CONFIG_HOSTFS=y
> CONFIG_SYSCTL=y
> CONFIG_STDERR_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_INITRAMFS_SOURCE="initramfs/initramfs.txt"
> CONFIG_LBD=y
> CONFIG_EXT2_FS=y
> CONFIG_PROC_FS=y
> CONFIG_SQUASHFS=y
> CONFIG_ZLIB_INFLATE=y
> EOF
> yes "" | make ARCH=um oldconfig &&
> make ARCH=um &&
> mv linux .. &&
> cd ..

Yes, tt.  It's portable.

Hopefully this weekend I can get this up and running on my server upstairs, 
and thus get my website moved onto my spiffy 3 megabit (symmetrical!) cable 
modem.  Then it should be a much much faster download.  Right now it's on a 
friend's DSL connection...

Of course to do that, I have to learn about UML network bridging... :)

> 				Jeff

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
