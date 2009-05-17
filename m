Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shlomopongratz@gmail.com>) id 1M5eYD-00066C-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 May 2009 11:29:05 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5eY8-0006mg-IH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 May 2009 11:29:05 +0000
Received: by bwz22 with SMTP id 22so2884233bwz.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 May 2009 04:28:58 -0700 (PDT)
MIME-Version: 1.0
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Sun, 17 May 2009 14:28:38 +0300
Message-ID: <88ea9a580905170428g2e6fd26ck205e38962a5eded3@mail.gmail.com>
Subject: [uml-devel] mcmodel=kernel and mem=512M
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4058903890338270218=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============4058903890338270218==
Content-Type: multipart/alternative; boundary=001485f7bec8d371bf046a19fb7d

--001485f7bec8d371bf046a19fb7d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I know that this is an old issue but I can't find the solution no matter how
much I've Googled.
I've build a 2.6.27 64 bit kernel and build modules with make modules
ARCH=um.
When I run the linux binary with mem=256M I can "insmod" the module loop.ko
without any problem.
However if  I use mem=512M and try to "insmod" loop.ko I'm getting the
message;

# cd /lib/modules
# insmod loop.ko
overflow in relocation type 11 val 848351e2
`loop' likely not compiled with -mcmodel=kernel
insmod: cannot insert 'loop.ko': Invalid module format (-1): Exec format
error
#

My host is;

$ uname -a
Linux lnx6004 2.6.9-42.ELsmp #1 SMP Wed Jul 12 23:32:02 EDT 2006 x86_64
x86_64 x86_64 GNU/Linux

Thanks,

S.P.

--001485f7bec8d371bf046a19fb7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I know that this is an old issue but I can&=
#39;t find the solution no matter how much I&#39;ve Googled.<br>I&#39;ve bu=
ild a 2.6.27 64 bit kernel and build modules with make modules ARCH=3Dum.<b=
r>

When I run the linux binary with mem=3D256M I can &quot;insmod&quot; the mo=
dule loop.ko without any problem.<br>However if=A0 I use mem=3D512M and try=
 to &quot;insmod&quot; loop.ko I&#39;m getting the message;<br><br># cd /li=
b/modules<br>

# insmod loop.ko<br>overflow in relocation type 11 val 848351e2<br>`loop&#3=
9; likely not compiled with -mcmodel=3Dkernel<br>insmod: cannot insert &#39=
;loop.ko&#39;: Invalid module format (-1): Exec format error<br>#=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>

<br>My host is;<br><br>$ uname -a<br>Linux lnx6004 2.6.9-42.ELsmp #1 SMP We=
d Jul 12 23:32:02 EDT 2006 x86_64 x86_64 x86_64 GNU/Linux<br><br>Thanks,<br=
><br>S.P.<br><br><br></div>

--001485f7bec8d371bf046a19fb7d--


--===============4058903890338270218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--===============4058903890338270218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4058903890338270218==--


