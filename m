Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWfjq-0008RH-Dv for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jun 2004 11:17:50 -0700
Received: from morpheus-adsl.ednet.co.uk ([212.20.233.177]
	helo=mail.morpheux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BWfjp-0003eL-Ma
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jun 2004 11:17:50 -0700
Received: from morpheux.org
	(IDENT:NqLbFva1lJ2yfKgt62hIGckyzm4eXZbk@sue.morpheux.org
	[192.168.42.3]) (authenticated bits=0)
	by mail.morpheux.org (8.12.11/8.12.11) with ESMTP id i55IHemt007435
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 5 Jun 2004 19:17:42 +0100
Message-ID: <40C20E43.1090305@morpheux.org>
From: Faye Gibbins <wibble@morpheux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.6 compile crashing on Fed Core 2
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
Date: Sat, 05 Jun 2004 19:17:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net


Hi,

Just finished compiling 2.6.6 with UML patch 2.6.6-1. compile crashed with:

snip---

gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wrap,calloc \
         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
vmlinux(.text+0x605f): In function `mem_init':
arch/um/kernel/mem.c:71: undefined reference to `phys_page'
vmlinux(.init.text+0x3380): In function `kmap_init':
include/asm/pgtable.h:394: undefined reference to `pte_offset'
collect2: ld returned 1 exit status
make: *** [linux] Error 1
Died at get_uml_patch.pl line 173.

snip---

gcc 3.3.3

On a PII 233 with a fresh Fed Core 2 install (everythign installed) plus 
all current updates as of 30 May 04.

Can supply kernel '.config' and build script (perl) upon request, but 
essentially I'm doing :

snip---

use constant K => '2.6.6';
use constant TMP => '/tmp/';
use constant PATCHWWW => 
'http://heanet.dl.sourceforge.net/sourceforge/user-mode-linux/';
use constant PATCH => 'uml-patch-'.K.'-1';
use constant PATCHMD5BZ2 => 'ac6131657b587aba2d306d3708142ec6';
use constant PATCHMD5 => '7c27d8acc8aa0ea6fe8dec712b0d4462';
use constant KWWW => 
'http://www.mirror.ac.uk/sites/ftp.kernel.org/pub/linux/kernel/v2.6/';
use constant KERNEL => 'linux-'.K.'.tar';
use constant KMD5BZ2 => '5218790bc3db41e77a7422969639a9ad';
use constant KMD5 => 'eaf803a496e7b8458ba332b04b89c0c0';

#.....

     chdir TMP || die "$!";

     system("tar","-xf",TMP.KERNEL)&&die"$!";

     chdir TMP."/linux-".K || die "$!";

     print "Patching...";
     {
	open(P,"<",TMP.PATCH)||die"$!";
	my @p = <P>;
	close P;
	
	open(OUT,"| patch -p1")||die"$!";
	print OUT @p;
	close OUT || die"$!";
     }

#.....

copy("$FindBin::Bin/uml.2.6.6",TMP."/linux-".K."/.config")||die"$!";

chdir TMP."/linux-".K || die "$!";

system("make oldconfig ARCH=um") && die "$!";
system("make linux ARCH=um") && die "$!";

snip---

Any help would be appreciated.

-- 
Yours
Faye

This time she's the lesser of two evils.

http://www.morpheux.org





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
