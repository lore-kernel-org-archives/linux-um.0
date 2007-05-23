Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hqq38-0000Wr-RC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 05:34:43 -0700
Received: from mu-out-0910.google.com ([209.85.134.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hqq37-0004QW-F1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 05:34:42 -0700
Received: by mu-out-0910.google.com with SMTP id i2so138025mue
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 May 2007 05:34:40 -0700 (PDT)
Message-ID: <dec0fd580705230534ga1614a8y464bd23be785cabe@mail.gmail.com>
Date: Wed, 23 May 2007 18:04:39 +0530
From: "battipatisainagendra Bhavaniprasad" <sainagendrabhavaniprasad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Doubt regarding UML
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi All,
           This is prasad,I am new to UML.Can any one clearfy the
 following doubts....
1.What is skas patch,is it required for 2.6 kernel or i comes with
 built in and if apply skas patch for my host kernel ,is it required to
 recompile the hole kernel and then install UML.

2.I have downloaded linux 2.4.27 from kernel.org and applyed
uml-patch-2.4.27-1.bz2 to it.
  after giving following command ......
  make menuconfig ARCH=um
  I have got a prompt to select SKAS mode in gendral setup option.
 My doubt is will linux 2.4.20(which is my host kernel) will have
already skas patch built in?

3.Is there any document to debug kernel by mounting gdb from host kernel.

 please reply ASAP.

 rgds,
 Prasad.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
