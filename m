Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaBaE-0006VH-T6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 08:44:52 -0700
Received: from mail.unilim.fr ([164.81.1.45] helo=smtp.unilim.fr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaBaC-0003T2-Im
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 08:44:50 -0700
Received: from [192.168.1.12] (APoitiers-754-1-6-183.w90-38.abo.wanadoo.fr
	[90.38.161.183]) (authenticated bits=0)
	by smtp.unilim.fr (8.13.1/8.13.1) with ESMTP id m81Ficdd010069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 1 Sep 2008 17:44:38 +0200
Message-ID: <48BC0DE7.1000703@unilim.fr>
Date: Mon, 01 Sep 2008 17:44:39 +0200
From: Julien Iguchi-Cartigny <julien.cartigny@unilim.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080504050907010301080700"
Subject: [uml-devel] Connecting UML_SWITCH and Wireshark
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080504050907010301080700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

(seems a developper question, apologies if it's more a user (moron)
question)

I'm using Netkit (www.netkit.org): it's a network simulator using UML
and I want to show packets exchanged between the UML machines. I believe
the best way is to

- use wireshark with the flag "-" to capture packets in the standard input.
- use netcat to read the data socket of uml_switch and print to the
standard output

But uml_switch uses a ctl socket to open new port. I need a way to
manually open a port by uml_switch to connect netcat. I don't think
uml_switch offer command-line instruction for this, so is the best way
to write a short program writing on the ctl socket of uml_switch ? If
yes, what data to send to uml_switch ?

Cheers,

Julien.


-- 
Trouble-a-cat Limited

--------------080504050907010301080700
Content-Type: text/x-vcard; charset=utf-8;
 name="julien_cartigny.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="julien_cartigny.vcf"

begin:vcard
fn:Julien Iguchi-Cartigny
n:Iguchi-Cartigny;Julien
org;quoted-printable;quoted-printable:Universit=C3=A9 de Limoges;D=C3=A9partement DMI
adr;quoted-printable:83, rue d'Isle;;Site Jid=C3=A9;Limoges;;87000;France
email;internet:julien.cartigny@unilim.fr
title:Assistant Professor
tel;work:+33555436930
tel;cell:+33681606483
x-mozilla-html:FALSE
url:http://msi.unilim.fr/~cartigny/
version:2.1
end:vcard


--------------080504050907010301080700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------080504050907010301080700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------080504050907010301080700--

