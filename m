Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4225-0000BT-TI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jun 2007 15:00:10 -0700
Received: from wx-out-0506.google.com ([66.249.82.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4224-0006h9-Ll
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jun 2007 15:00:09 -0700
Received: by wx-out-0506.google.com with SMTP id h31so661242wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Jun 2007 15:00:07 -0700 (PDT)
Message-ID: <9604cc9f0706281500v42d672bu3a42efde2e1ce4a3@mail.gmail.com>
Date: Thu, 28 Jun 2007 23:00:07 +0100
From: "kototama kototama" <kototamo@gmail.com>
In-Reply-To: <20070628210943.GA10683@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <9604cc9f0706281104l7f10e0bbu9ce89514a10a106d@mail.gmail.com>
	<20070628195713.GA9754@c2.user-mode-linux.org>
	<9604cc9f0706281326x148fd378n9165ce9ccdc587ca@mail.gmail.com>
	<20070628210943.GA10683@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [uml-user] unlock_kernel symbol
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1882271212=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

--===============1882271212==
Content-Type: multipart/alternative; 
	boundary="----=_Part_1238_20494849.1183068007909"

------=_Part_1238_20494849.1183068007909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> What versions of the host kernel and UML?


host is 2.6.20-16-generic , the raw one from feisty fawn
uml is 2.6.20.3-ubuntu1 , the same built from the ubuntu kernel sources

Otherwise the printk in the module doesn't work in the uml whereas it works
in the host and otherwise printk works well (I tried for instance the log
command with uml_mconsole). Perhaps because of the version magic (I'm fixing
this) and my force (modprobe -f) to load the module ?

------=_Part_1238_20494849.1183068007909
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br>What versions of the host kernel and UML?</blockquote><div><br>host is 2.6.20-16-generic
 , the raw one from feisty fawn<br>uml is 2.6.20.3-ubuntu1 , the same built from the ubuntu kernel sources<br><br>Otherwise the printk in the module doesn&#39;t work in the uml whereas it works in the host and otherwise printk works well (I tried for instance the log command with uml_mconsole). Perhaps because of the version magic (I&#39;m fixing this) and my force (modprobe -f) to load the module ?
<br></div></div><br>

------=_Part_1238_20494849.1183068007909--


--===============1882271212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1882271212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1882271212==--

