Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <htmldeveloper@gmail.com>) id 1KxaB9-00036E-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Nov 2008 04:39:39 +0000
Received: from an-out-0708.google.com ([209.85.132.251])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KxaB7-0007eb-Dd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Nov 2008 04:39:39 +0000
Received: by an-out-0708.google.com with SMTP id c38so391013ana.37
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 04 Nov 2008 20:39:36 -0800 (PST)
Message-ID: <804dabb00811042039s2dd4d9dv940059deea522dd8@mail.gmail.com>
Date: Wed, 5 Nov 2008 12:39:36 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] UML: multiple error in compilation
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Al Viro <viro@zeniv.linux.org.uk>, Steven Rostedt <srostedt@redhat.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I am on linus git tree:

45beca08dd8b6d6a65c5ffd730af2eac7a2c7a03		branch 'master' of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

after attempting to compile for UML, I got "undefined reference to
`save_stack_trace'", and so I applied the following:

http://groups.google.com/group/linux.kernel/browse_thread/thread/84e3655b604ecc40/1b16192ff6b216b9?lnk=raot

and then make again:

/root/download/linux-2.6_latest>make linux ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sda2/download/linux-2.6_latest/uml'.
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  Using /mnt/sda2/download/linux-2.6_latest as source for kernel
  GEN     /mnt/sda2/download/linux-2.6_latest/uml/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-um
  CALL    /mnt/sda2/download/linux-2.6_latest/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      kernel/trace/trace.o
/mnt/sda2/download/linux-2.6_latest/kernel/trace/trace.c: In function
'ftrace_trace_stack':
/mnt/sda2/download/linux-2.6_latest/kernel/trace/trace.c:710: error:
storage size of 'trace' isn't known
/mnt/sda2/download/linux-2.6_latest/kernel/trace/trace.c:710: warning:
unused variable 'trace'
make[3]: *** [kernel/trace/trace.o] Error 1
make[2]: *** [kernel/trace] Error 2
make[1]: *** [kernel] Error 2
make: *** [sub-make] Error 2

Hm...possibly some header got error.....any hints?

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
