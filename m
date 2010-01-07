Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <golubovsky@gmail.com>) id 1NSk7M-0003cO-AO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jan 2010 04:37:04 +0000
Received: from fg-out-1718.google.com ([72.14.220.155])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSk7H-00011D-TK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jan 2010 04:37:04 +0000
Received: by fg-out-1718.google.com with SMTP id e12so908375fga.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Jan 2010 20:36:53 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 6 Jan 2010 23:36:53 -0500
Message-ID: <bcba51a1001062036i3343fdccxbca2cc2ec246410a@mail.gmail.com>
From: Dimitry Golubovsky <golubovsky@gmail.com>
Subject: [uml-devel] How to intercept int 0x40 in UML
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I am trying to implement some ideas of Glendix [1], but without
patching the underlying Linux kernel, staying completely within UML.

I am experimenting with kernel 2.6.31.6 sources (the same version for
which Glendix patch is available)

I got stuck trying to intercept the "int 0x40" instruction which is
used for syscalls in Plan 9. Example code below (NASM syntax, example
borrowed from Glendix):

======================
section .data
        hello:     db 'Hello world!',10    ; 'Hello world!' plus a
linefeed character
        helloLen:  equ $-hello             ; Length of the 'Hello world!' string

section .text
        global _start

_start:
        mov eax,8
        mov ebx,hello
        int 40h
======================

I am trying to find a place within arch/um/os-Linux/skas/process.c
where to my understanding the code responsible for intercepting
syscalls is located - the place where I could insert my own code to
intercept 0x40 interrupt and translate it to some kernel action.

When I run this program compiled I get "Segmentation fault" message.

I tried to insert printk call in the "userspace" function in
arch/um/os-Linux/skas/process.c in various places to see if the "int
0x40" instruction is trapped by the UML kernel, unsuccessfully so far.

In particular, I tried:
  * right after the if(WIFSTOPPED(status)) statement
(arch/um/os-Linux/skas/process.c, line 406)
  * right before the same check (like this: if (!WIFSTOPPED(status)) printk ...)
  * inside the "fatal_sigsegv" function in arch/um/kernel/trap.c

None caused any output when running the test program

Any suggestions where can I intercept it? Or does this signal
completely bypass UML?

Thanks for any ideas.

----------------
[1] http://www.glendix.org - Linux kernel patch to run Plan9 binaries
on Linux kernel

-- 
Dimitry Golubovsky

Anywhere on the Web

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

