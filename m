Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1DqJ-0007dG-R5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Mar 2004 16:14:31 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B1D9u-0002c7-31 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Mar 2004 15:30:42 -0800
Message-ID: <212201c406fc$242caf50$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0403100234590.6567-200000@pluto2.express.org>
Subject: Re: [uml-devel] 2.6 UML Kernel Woes (re UDB Device)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 11 Mar 2004 01:02:26 +0100
To: "William R. Lorenz" <wrl@express.org>, user-mode-linux-devel@lists.sourceforge.net

mhhhh....
do you use devfs=nomount with your 2.4.x kernel, too?
what about _trying_ devfs?

also see: http://usermodelinux.org/modules.php?name=News&file=article&sid=134

hth
roland


----- Original Message ----- 
From: "William R. Lorenz" <wrl@express.org>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, March 10, 2004 8:47 AM
Subject: [uml-devel] 2.6 UML Kernel Woes (re UDB Device)


> Greetings,
> 
> I've grabed the 2.6.3 kernel source an applied uml-patch-2.6.3-rc2-1.bz2
> as made available on the UML site @ SourceForge.  I've then configured the
> kernel with a `make ARCH=um menuconfig`, compiled it with a `make ARCH=um
> linux`, and tried to run it on a 2.4.23 skas3+fairsched patched host.  I
> also added in an MPPE patch for PPTP-related stuff, which should be fine.
> 
> When I run the 2.6.3 binary, I get the following error to the console:
> 
>   VFS: Cannot open root device "ubd0" or unknown-block(0,0)
>   Please append a correct "root=" boot option
>   Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> I'm calling the UML binary with the following command-line options:
> 
>   user$ ./linux-2.6.3.mppe.bin devfs=nomount mem=128M \
>     ubd0=fedora-core1.disk \
>     con0=fd:0,fd:1 con=/dev/null \
>     eth0=tuntap,tap3 root=/dev/ubd0
> 
> It's not a permissions problem with the 'fedora-core1.disk' file, as this
> file works just fine with a 2.4.x UML kernel, and it's an ext3 filesystem:
> 
>   [root@phobos linux-2.6.3]# grep EXT3 .config
>   CONFIG_EXT3_FS=y
>   CONFIG_EXT3_FS_XATTR=y
>   CONFIG_EXT3_FS_POSIX_ACL=y
>   # CONFIG_EXT3_FS_SECURITY is not set
>   [root@phobos linux-2.6.3]# grep EXT2 .config
>   CONFIG_EXT2_FS=y
>   # CONFIG_EXT2_FS_XATTR is not set
>   [root@phobos linux-2.6.3]# 
> 
> I've attached the complete kernel .config I used for this 2.6 compilation.
> 
> Any help would be very much appreciated.  Thanks, in advance.
> 
> --          _ 
> __ __ ___ _| | William R. Lorenz <wrl@express.org> 
> \ V  V / '_| | http://www.clevelandlug.net/ ; "Every revolution was 
>  \./\./|_| |_| first a thought in one man's mind." - Ralph Waldo Emerson 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
