Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJ1a7-0003Wy-QV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 20:51:55 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJ1a5-0006Bw-Er for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 20:51:55 -0700
Received: by zproxy.gmail.com with SMTP id 9so27275nzo
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 05 Apr 2005 20:51:47 -0700 (PDT)
Message-ID: <cbec11ac050405205173f18157@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
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
Date: Wed, 6 Apr 2005 15:51:47 +1200
To: UML Developer <user-mode-linux-devel@lists.sourceforge.net>

Hi there,

I have applied 2.6.12-rc2 patches against 2.6.11 and gone to compile
and it fails...

Here is what I have done:
make menuconfig ARCH=um
Added in hostfs, UML networking - daemon (but also tried with these
off, no difference)
make linux ARCH=um

Output:
  HOSTCC  usr/gen_init_cpio
  CHK     usr/initramfs_list
  UPD     usr/initramfs_list
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/um/kernel/checksum.o
  QUOTE   arch/um/kernel/config.tmp
  QUOTE   arch/um/kernel/config.c
sed: -e expression #4, char 2: Extra characters after command
make[1]: *** [arch/um/kernel/config.c] Error 1
make: *** [arch/um/kernel] Error 2

and here is the file arch/um/kernel/.config.tmp.cmd that gets created
which I am guessing has the sed error
cmd_arch/um/kernel/config.tmp := sed -e 's/"/\\"/g' -e 's/^/"/' -e
's/$$/\\n"/' /home/iam4/linuxsrc/linux-2.6.12-rc2/.config >
arch/um/kernel/config.tmp

config.c also is 0 characters length

I can supply any other files needed.
System is Debian Woody, gcc 2.95.4

I don't know much yet about sed or the kernel build process but can
look into if nobody else makes sense of this. Just thought it was good
to get it out there considering it doesn't compile and rc2 has just
come out.

And UML does compile under 2.6.11 with a patch for gcc (which is
include in 2.6.12-rc4). Haven't yet tried 2.6.12-rc1 but can do later
if this will help.

Ian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
