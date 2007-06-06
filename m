Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hvtav-0003bo-0W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 04:22:30 -0700
Received: from mu-out-0910.google.com ([209.85.134.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hvtat-0005HW-Dq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 04:22:28 -0700
Received: by mu-out-0910.google.com with SMTP id w9so108412mue
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Jun 2007 04:22:25 -0700 (PDT)
Message-ID: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
Date: Wed, 6 Jun 2007 16:52:25 +0530
From: "battipatisainagendra Bhavaniprasad" <sainagendrabhavaniprasad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] doubt regarding UML instlation please help me.
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
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hello sir,
              This is Prasad working on UML.I have tried running UML
with latest source from www.kernel.org but I could not get.
the problem was as followes....

with 2.6.16 kernel i have given the following commands....

1.make defconfig ARCH=um
2.make ARCH=um

but i am getting an error which is as followes...

arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':


arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared
(first use in this function)

arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared
identifier is reported only once

arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it
appears in.)

arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared
(first use in this function)

arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared
(first use in this function)

make[2]: *** [arch/um/os-Linux/sys-i386/registers.o] Error 1

make[1]: *** [arch/um/os-Linux/sys-i386] Error 2


next i went with the latest kernel i.e..linux-2.6.21.tar.bz2
but when i run command i.e...make ARCH=um

it's going on exexuting the same sequence of things....finally i could
NOT get the linux bin image.


please suggest me which kernel mirror to use which has already uml
patch built in....

waiting for your reply.....

thank you,
rgds,
prasad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
