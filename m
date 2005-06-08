Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dg1hT-0003Hh-FQ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 07:38:35 -0700
Received: from server.ispbrasil.com.br ([209.67.213.235]
	helo=ispbrasil.com.br)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dg1hR-0004Mq-0M
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 07:38:35 -0700
Message-ID: <000501c56c37$c5abf830$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] compile error on 2.6.11.8-bs6 guest
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
Date: Wed, 8 Jun 2005 11:38:39 -0300
To: uml-user <user-mode-linux-user@lists.sourceforge.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[root@router linux-2.6.11.8]# nice -n -20 make linux ARCH=um
  CHK     include/linux/version.h
make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
  CHK     arch/um/include/skas_ptregs.h
  CHK     arch/um/include/sysdep-i386/sc.h
  CHK     arch/um/include/task.h
  CHK     arch/um/include/kern_constants.h
make[1]: `arch/um/sys-i386/util/mk_thread' is up to date.
  CHK     arch/um/include/sysdep-i386/thread.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
arch/um/kernel/Makefile:34: arch/um/scripts/Makefile.rules: No such file or 
directory
make[1]: *** No rule to make target `arch/um/scripts/Makefile.rules'.  Stop.
make: *** [arch/um/kernel] Error 2
[root@router linux-2.6.11.8]#

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://vps.ispbrasil.com.br --->>> servidores linux 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
