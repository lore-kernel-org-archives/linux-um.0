Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2tVZ-0003pi-G7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 08:28:17 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C2tVY-0002Mk-Om for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 08:28:17 -0700
From: Dominik =?ISO-8859-1?Q?J=FCrgens?= <dcdom@gmx.de>
Content-Type: text/plain
Message-Id: <1094138889.26131.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems compiling any 2.6.x UML
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
Date: Thu, 02 Sep 2004 17:28:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net

I have a problem with compiling user-mode-linux on my debian sarge
system. Some importent package versions:
 
Hostkernel 2.6.8.1
gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)
GNU Make 3.80
GNU binutils version 2.14.90.0.7 20031029 Debian GNU/Linux

Problem: When I try to compile any 2.6.x UML-Kernel I get following
message:

make ARCH=um linux \n
...
<--zip-->
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  MAIN    arch/um/main.o
  LD      vmlinux
/bin/sh: Syntax error: "(" unexpected
  CPP     arch/um/uml.lds.s
gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
-Wl,--wrap,calloc \
        -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
/usr/bin/ld:arch/um/uml.lds.s:150: syntax error
collect2: ld returned 1 exit status
make: *** [linux] Fehler 1
</--zip-->

The content of the 'arch/um/uml.lds.s' file arround line 150:
<--zip-->
147:  init.data : { *(init.data) }
148:  .data :
149:  {
150:    . = ALIGN(); /* init_task */
151:    *(.data.init_task)
152:    *(.data)
153:    *(.gnu.linkonce.d*)
154:    CONSTRUCTORS
155:  }
</--zip-->

I googled for it a longer time and found nothing. 

Thanks for helping me :-)
Dominik Juergens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
