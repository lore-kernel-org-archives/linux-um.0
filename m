Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPuJl-0002jB-Ok for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 18:59:13 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CPuJk-0005Ta-4t
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 18:59:13 -0800
Received: from [192.168.0.4] (office.rimuhosting.co.nz [222.152.52.159] (may
	be forged)) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id iA52x4qL032498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 5 Nov 2004 02:59:08 GMT
Message-ID: <418AEC78.2010502@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] __wrap_malloc compile error without CONFIG_MODE_TT
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
Date: Fri, 05 Nov 2004 15:59:04 +1300
To: user-mode-linux-devel@lists.sourceforge.net

Hi.  I just compiled 2.6.9 + uml-2.6.9-bb1.patch.bz2 and got a compile 
error with CONFIG_MODE_TT turned off.  Posting here in case it is of 
interest to anyone.

diff workingconfig brokenconfig

14c14,15
< CONFIG_MODE_TT=y
---
 > # CONFIG_MODE_TT is not set
 > # CONFIG_STATIC_LINK is not set
22d22
< # CONFIG_SMP is not set
276a277,279
 > # CONFIG_NET_SCH_CLK_JIFFIES is not set
 > # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
 > # CONFIG_NET_SCH_CLK_CPU is not set


  LD      lib/built-in.o
   AR      lib/lib.a
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/um/kernel/built-in.o(.text+0x1a5f): In function `__wrap_malloc':
arch/um/kernel/main.c:192: undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x1ade): In function `__wrap_free':
arch/um/kernel/main.c:236: undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x1b21):arch/um/kernel/main.c:240: 
undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x6a7b): In function `sig_handler':
arch/um/kernel/trap_user.c:108: undefined reference to 
`sig_handler_common_tt'
arch/um/kernel/built-in.o(.text+0x6abe): In function `alarm_handler':
arch/um/kernel/trap_user.c:121: undefined reference to 
`sig_handler_common_tt'
arch/um/kernel/built-in.o(.text+0x6a5a): In function `usr2_handler':
arch/um/kernel/trap_user.c:80: undefined reference to `syscall_handler_tt'
arch/um/kernel/built-in.o(.text+0x72a3): In function `not_dead_yet':
arch/um/kernel/umid.c:192: undefined reference to `tracing_pid'
arch/um/drivers/built-in.o(.text+0x36f8): In function `register_winch':
arch/um/drivers/chan_user.c:153: undefined reference to `is_tracer_winch'
collect2: ld returned 1 exit status
   KSYM    .tmp_kallsyms1.S
nm: .tmp_vmlinux1: No such file or directory
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
arch/um/kernel/built-in.o(.text+0x1a5f): In function `__wrap_malloc':
arch/um/kernel/main.c:192: undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x1ade): In function `__wrap_free':
arch/um/kernel/main.c:236: undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x1b21):arch/um/kernel/main.c:240: 
undefined reference to `tracing_pid'
arch/um/kernel/built-in.o(.text+0x6a7b): In function `sig_handler':
arch/um/kernel/trap_user.c:108: undefined reference to 
`sig_handler_common_tt'
arch/um/kernel/built-in.o(.text+0x6abe): In function `alarm_handler':
arch/um/kernel/trap_user.c:121: undefined reference to 
`sig_handler_common_tt'
arch/um/kernel/built-in.o(.text+0x6a5a): In function `usr2_handler':
arch/um/kernel/trap_user.c:80: undefined reference to `syscall_handler_tt'
arch/um/kernel/built-in.o(.text+0x72a3): In function `not_dead_yet':
arch/um/kernel/umid.c:192: undefined reference to `tracing_pid'
arch/um/drivers/built-in.o(.text+0x36f8): In function `register_winch':
arch/um/drivers/chan_user.c:153: undefined reference to `is_tracer_winch'
collect2: ld returned 1 exit status
make: *** [.tmp_vmlinux2] Error 1
make linux


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
