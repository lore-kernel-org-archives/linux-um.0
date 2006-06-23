Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtgKv-00033B-4b for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 00:44:17 -0700
Received: from outboundsmtp.bordersgroupinc.com ([198.179.227.40]
	helo=corpex01.bgpcorp.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtgKu-0001Wq-RK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 00:44:17 -0700
content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 23 Jun 2006 03:43:30 -0400
Message-ID: <CA52872BEA6FD41182A50008C724B23003F2FFE3@corp01uk.bordersgroupinc.com>
From: "Carl Radford (DC0854-IT)" <CRADFORD@bordersgroupinc.com>
Subject: Re: [uml-devel] Another cause for UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, Laurent@lvivier.info, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, for@gmx.de


This is a list of the stock kernel files that om patches, and may have
a knock-on effect with um. Not all files are heavily patched, some are
trivial (conditionally compile out "static" from function declarations). 

|-- Makefile
|-- arch
|   |-- i386
|   |   |-- Kconfig
|   |   |-- kernel
|   |   |   |-- asm-offsets.c
|   |   |   |-- entry.S
|   |   |   |-- i387.c
|   |   |   |-- process.c
|   |   |   |-- signal.c
|   |   |   |-- sys_i386.c
|   |   |   `-- vm86.c
|   |   `-- lib
|   |       `-- usercopy.c
|   |-- ppc
|   |   |-- Kconfig
|   |   `-- kernel
|   |       |-- asm-offsets.c
|   |       |-- entry.S
|   |       `-- misc.S
|   `-- x86_64
|       |-- Kconfig
|       |-- kernel
|       |   |-- asm-offsets.c
|       |   |-- entry.S
|       |   `-- sys_x86_64.c
|       `-- lib
|           |-- copy_user.S
|           `-- usercopy.c
|-- fs
|   |-- namei.c
|   `-- proc
|       |-- base.c
|       `-- root.c
|
|-- include
|   |-- asm-i386
|   |   `-- uaccess.h
|   |-- asm-ppc
|   |   `-- uaccess.h
|   `-- linux
|       |-- compiler.h
|       |-- hpc.h
|       |-- init_task.h
|       |-- net.h
|       |-- sched.h
|       `-- signal.h
|-- kernel
|   |-- exit.c
|   |-- fork.c
|   `-- sched.c
|-- mm
|   |-- mlock.c
|   `-- mmap.c
|-- net
    `-- socket.c


-----Original Message-----
From: Jeff Dike [mailto:jdike@addtoit.com]
Sent: 22 June 2006 22:31
To: Paolo Giarrusso
Cc: Carl Radford (DC0854-IT); Laurent@lvivier.info; for@gmx.de; Jeff
Dike; UML-devel
Subject: Re: [uml-devel] Another cause for UML


On Thu, Jun 22, 2006 at 01:16:49AM +0200, Paolo Giarrusso wrote:
> Start posting some of these errors and we'll look at how trivial it
> is (unless the compiler is flooding you). If they look trivial to us
> we may try it...

I agree.

> But my 1st question is: does OpenMosix currently support anything
> else than x86? If not a little compatibility layer may be needed and
> this may hinder significantly the porting - however they'll have to
> fix this anyway to support x86_64 at the very least.

My recollection is that OM dropped stuff directly into arch.

				Jeff







Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
