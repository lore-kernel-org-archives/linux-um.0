Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As4iK-0007mi-FG
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 10:40:28 -0800
Received: from web60103.mail.yahoo.com ([216.109.118.82])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1As4bz-0001K4-9k
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 10:33:55 -0800
Message-ID: <20040214183745.20159.qmail@web60103.mail.yahoo.com>
From: =?iso-8859-1?q?kenz=20kenz?= <kenz260@yahoo.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1694461515-1076783865=:19245"
Subject: [uml-devel] need help , uml .....
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 14 Feb 2004 19:37:45 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net


--0-1694461515-1076783865=:19245
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id i1EIdvtw003638

hello, i'm a student trauing to use uml in my project , i have a P4 proce=
ssor ; i install linux redhat 9 in my computer . i try to install uml in =
it but i didn't succeed .=20
i have done this :
1- i unzip linux-2.4.20......tar.bz2
   tar -jxvf linux......
2- i have patch this kernel
    bunzip uml-patch...bz2|patch 1
   (in this commande i was obligede to create a new directory um in linux=
-2.4.20/arch so the patch functions correctly )
3- i done make xconfig ARCH=3Dum
4- make dep
a window appeared , i save an exsit this window
5- make uml-linux ARCH=3Dum
6- when trying to run the binary with=20
    uml-linux ubd0=3Dpath-of-file-system
it dosen't work complitly , it ended with a message like :
kernel panic ...........line 603
an i return to shell .
thank you for any helpful information that you can give me .
=20

	=09
---------------------------------
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout !
Cr=E9ez votre Yahoo! Mail
--0-1694461515-1076783865=:19245
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id i1EIdvtw003638

<DIV>hello, i'm a student trauing to use uml in my project , i have a P4 =
processor ; i install linux redhat 9 in my computer . i try to install um=
l in it but i didn't succeed . </DIV>
<DIV>i have done this :</DIV>
<DIV>1- i unzip linux-2.4.20......tar.bz2</DIV>
<DIV>&nbsp;&nbsp; tar -jxvf linux......</DIV>
<DIV>2- i have patch this kernel</DIV>
<DIV>&nbsp;&nbsp;&nbsp; bunzip uml-patch...bz2|patch 1</DIV>
<DIV>&nbsp;&nbsp; (in this commande i was obligede to create a new direct=
ory um in linux-2.4.20/arch so the patch functions correctly )</DIV>
<DIV>3- i done make xconfig ARCH=3Dum</DIV>
<DIV>4- make dep</DIV>
<DIV>a window appeared , i save an exsit this window</DIV>
<DIV>5- make uml-linux ARCH=3Dum</DIV>
<DIV>6- when trying to run the binary with </DIV>
<DIV>&nbsp;&nbsp;&nbsp; uml-linux ubd0=3Dpath-of-file-system</DIV>
<DIV>it dosen't work complitly , it ended with a message like :</DIV>
<DIV>kernel panic ...........line 603</DIV>
<DIV>an i return to shell .</DIV>
<DIV>thank you for any helpful information that you can give me .</DIV>
<DIV>&nbsp;</DIV><p>
		<hr size=3D1>
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout !
<br><a href=3D"http://fr.rd.yahoo.com/mail/taglines/*http://fr.benefits.y=
ahoo.com/">Cr=E9ez votre Yahoo! Mail</a>
--0-1694461515-1076783865=:19245--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
