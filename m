Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EXTcY-0003Hz-UB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 17:10:26 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EXTcU-000797-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 17:10:26 -0800
Received: from rgminet02.oracle.com ([148.87.122.31])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1EXPpJ-0002LH-F4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 13:07:22 -0800
Message-ID: <43690BDD.1060409@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080203000902090704040307"
Subject: [uml-devel] [Fwd: patch info]
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
Date: Wed, 02 Nov 2005 13:56:29 -0500
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080203000902090704040307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's what i get when i compile the patch with 2.6.14 and skas-ldt 
patch.  Sorry for the duplication in the patch list itself, it includes 
the dry run.

--------------080203000902090704040307
Content-Type: message/rfc822;
 name="patch info"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch info"

Return-Path: <anton.verhulst@oracle.com>
Received: from rgmum104.us.oracle.com by rgmum300.us.oracle.com
	with ESMTP id 344594481130957375; Wed, 02 Nov 2005 11:49:35 -0700
Received: from rgmsgw300.us.oracle.com by rgmum104.us.oracle.com
	with ESMTP id 3771938311130957372; Wed, 02 Nov 2005 11:49:32 -0700
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	by rgmsgw300.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	jA2InWtM023080
	for <allan.graves@oracle.com>; Wed, 2 Nov 2005 11:49:32 -0700
Received: from [138.2.230.199] (averhuls-lnx.us.oracle.com [138.2.230.199])
	by rgmsgw300.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	jA2InVES023068
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <allan.graves@oracle.com>; Wed, 2 Nov 2005 11:49:32 -0700
Message-ID: <43690A3B.30001@oracle.com>
Date: Wed, 02 Nov 2005 13:49:31 -0500
From: Anton Verhulst <anton.verhulst@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Allan Graves <allan.graves@oracle.com>
Subject: patch info
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[ averhuls_avd ] bash-3.00# make linux ARCH=um modules
  CHK     arch/um/include/user_constants.h
  CHK     include/linux/version.h
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing -fno-common -ffreestanding -O2     
-fomit-frame-pointer -g  -D__arch_um__ -DSUBARCH=\"i386\" 
-Iarch/um/include  -I/usr/src/linux-2.6.14/arch/um/kernel/tt/include  
-I/usr/src/linux-2.6.14/arch/um/kernel/skas/include -Dvmap=kernel_vmap 
-Din6addr_loopback=kernel_in6addr_loopback -Derrno=kernel_errno 
-Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -U__i386__ -Ui386 
-D_LARGEFILE64_SOURCE -Wdeclaration-after-statement   -nostdinc -isystem 
/usr/lib/gcc/i386-redhat-linux/3.4.4/include -D__KERNEL__ -Iinclude  -S 
-o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
In file included from arch/um/include/um_mmu.h:17,
                 from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-i386/kernel-offsets.c:3:
/usr/src/linux-2.6.14/arch/um/kernel/skas/include/mmu-skas.h:19: error: 
syntax error before "uml_ldt_t"
/usr/src/linux-2.6.14/arch/um/kernel/skas/include/mmu-skas.h:19: 
warning: no semicolon at end of struct or union
In file included from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-i386/kernel-offsets.c:3:
arch/um/include/um_mmu.h:25: error: field `skas' has incomplete type
make: *** [arch/um/kernel-offsets.s] Error 1
[ averhuls_avd ] bash-3.00# exit
ade:[ averhuls_avd ] [averhuls@staca07 uml]$ exit
[averhuls@staca07 ~]$ !!





gcc (GCC) 3.4.4 20050721 (Red Hat 3.4.4-2)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


ade:[ averhuls_avd ] [averhuls@staca07 uml]$ patch -p1 --dry-run 
</uml/skas-hold
-own-ldt
patching file arch/um/kernel/skas/include/mmu-skas.h
patching file arch/um/kernel/skas/include/skas.h
patching file arch/um/kernel/skas/mem.c
patching file arch/um/kernel/skas/mmu.c
patching file arch/um/kernel/skas/process.c
Hunk #1 succeeded at 370 (offset -11 lines).
patching file arch/um/kernel/skas/process_kern.c
patching file arch/um/os-Linux/start_up.c
patching file arch/um/scripts/Makefile.rules
patching file arch/um/sys-i386/ldt.c
patching file arch/um/sys-x86_64/Makefile
patching file arch/um/sys-x86_64/syscalls.c
patching file include/asm-um/ldt-i386.h
patching file include/asm-um/ldt.h
patch unexpectedly ends in middle of line
ade:[ averhuls_avd ] [averhuls@staca07 uml]$ vim /uml/skas-hold-own-ldt
ade:[ averhuls_avd ] [averhuls@staca07 uml]$ patch -p1 --dry-run < 
/uml/skas-hol
d-own-ldt
patching file arch/um/kernel/skas/include/mmu-skas.h
patching file arch/um/kernel/skas/include/skas.h
patching file arch/um/kernel/skas/mem.c
patching file arch/um/kernel/skas/mmu.c
patching file arch/um/kernel/skas/process.c
Hunk #1 succeeded at 370 (offset -11 lines).
patching file arch/um/kernel/skas/process_kern.c
patching file arch/um/os-Linux/start_up.c
patching file arch/um/scripts/Makefile.rules
patching file arch/um/sys-i386/ldt.c
patching file arch/um/sys-x86_64/Makefile
patching file arch/um/sys-x86_64/syscalls.c
patching file include/asm-um/ldt-i386.h
patching file include/asm-um/ldt.h

-- 

The system of refusing the mere act of drinking and leaving the
desire in full force, is unintelligent war tactics, it seems to me.

Mark Twain


--------------080203000902090704040307--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
