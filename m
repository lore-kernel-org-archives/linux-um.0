Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Az1jl-0002ai-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 14:54:41 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Az1C0-0007WJ-CE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 14:19:48 -0800
Message-ID: <108601c4023a$7f0f3bc0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<200403040216.i242GLWo009037@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] compile issue when removing CONFIG_MODE_TT
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
Date: Thu, 4 Mar 2004 23:46:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net

hi,
this is not actually a real "problem" for me, but i think it`s worth reporting.

when unsetting CONFIG_MODE_TT (i dont need and want TT) in .config, i get the following error, when compiling uml:

---- snipp ----
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D
_LARGEFILE64_SOURCE   -Iarch/um/include -I/tmp/uml/linux-2.6.3-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 -g -c -o
arch/um/kernel/config.o arch/um/kernel/config.c
  CC      arch/um/kernel/exec_kern.o
  CC      arch/um/kernel/exitcode.o
  CC      arch/um/kernel/frame_kern.o
  CC      arch/um/kernel/init_task.o
  CC      arch/um/kernel/irq.o
  CC      arch/um/kernel/ksyms.o
arch/um/kernel/ksyms.c:35: `host_task_size' undeclared here (not in a function)
arch/um/kernel/ksyms.c:35: initializer element is not constant
arch/um/kernel/ksyms.c:35: (near initialization for `__ksymtab_host_task_size.value')
make[1]: *** [arch/um/kernel/ksyms.o] Error 1
make: *** [arch/um/kernel] Error 2

regards
roland



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
