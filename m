Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hv57b-000399-Fv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 22:28:51 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hv57a-000610-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 22:28:51 -0700
Received: by ug-out-1314.google.com with SMTP id 78so681101ugn
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 03 Jun 2007 22:28:49 -0700 (PDT)
Message-ID: <dec0fd580706032228o64eb38f3t1f033db768d175db@mail.gmail.com>
Date: Mon, 4 Jun 2007 00:28:47 -0500
From: "battipatisainagendra Bhavaniprasad" <sainagendrabhavaniprasad@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Query ....
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1800568210=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1800568210==
Content-Type: multipart/alternative; 
	boundary="----=_Part_28820_31147624.1180934927847"

------=_Part_28820_31147624.1180934927847
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been beating my head against the wall trying to get a working
UML for several days, so any help is greatly appreciated!I have
downloaded
"linux-2.6.16.tar" (which has UML patch In built) followed by the commands.....

make defconfig ARCH=um

make ARCH=um

but i am getting the following errors...

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

Please help me.....

rgds,
Prasad.

------=_Part_28820_31147624.1180934927847
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<pre>I have been beating my head against the wall trying to get a working UML for several days, so any help is greatly appreciated!I have downloaded<br>&quot;linux-2.6.16.tar&quot; (which has UML patch In built) followed by the commands.....
<br><br><a name="Configuration"><tt><tt><pre>make defconfig ARCH=um<br><br><a name="Building"><tt><tt><pre>make ARCH=um<br><br>but i am getting the following errors...<br><br>arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
<br>arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared (first use in this function)<br>arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared identifier is reported only once<br>arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it appears in.)
<br>arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared (first use in this function)<br>arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared (first use in this function)<br>make[2]: *** [arch/um/os-Linux/sys-i386/registers.o] Error 1
<br>make[1]: *** [arch/um/os-Linux/sys-i386] Error 2<br><br>Please help me.....<br><br>rgds,<br>Prasad.<br></pre></tt></tt></a><br></pre></tt></tt></a><br></pre>

------=_Part_28820_31147624.1180934927847--


--===============1800568210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1800568210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1800568210==--

