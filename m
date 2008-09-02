Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaWtK-0003RQ-E7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 07:29:58 -0700
Received: from mail.unilim.fr ([164.81.1.45] helo=smtp.unilim.fr)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaWtG-0001cI-C1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 07:29:58 -0700
Message-ID: <48BD4DC9.6080005@unilim.fr>
Date: Tue, 02 Sep 2008 16:29:29 +0200
From: Julien Iguchi-Cartigny <julien.cartigny@unilim.fr>
MIME-Version: 1.0
References: <48BC0DE7.1000703@unilim.fr> <1220291098.2995.3.camel@clownix>
	<48BCFBAE.3050402@unilim.fr> <20080902101808.GR3824@pintsize>
In-Reply-To: <20080902101808.GR3824@pintsize>
Content-Type: multipart/mixed; boundary="------------060506050902060903090700"
Subject: Re: [uml-devel] Connecting UML_SWITCH and Wireshark
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
To: Luca Bigliardi <shammash@artha.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060506050902060903090700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Luca,

> On wireshark(1) they say this works only if you have a libpcap format on
> wireshark's STDIN, but in this way you'll have pure ethernet frames.

Damn it ! I didn't think of this problem.

> Does Netkit support uml's vde network?
> If it does then you can use the 'pdump' plugin in vde_switch which dumps
> all the traffic in pcap format.

I don't think so (I didn't see reference to vde_switch in netkit
distribution).

One idea is to do the same think: use pdump on uml_switch (vde_switch
seems close to uml_switch, right ?).

An other idea  could be to extend uml_switch to dump traffic on standard
output in cap format. Don't seem too difficult (include libcap is
needed, and some code of course).

The only problem is how to connect the standard input of wireshark and
the standard output of this "new" uml_switch; netcat is an interesting
"brut hack" to do this (not really "elegant") but maybe some people have
a better solution ????

Cheers,

Julien.

> Here you can find an example of pdump usage:
> http://qemu-forum.ipi.fi/viewtopic.php?f=2&p=13488#p13488
> 
> 
> HTH
> 
> luca
> 


-- 
Trouble-a-cat Limited

--------------060506050902060903090700
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


--------------060506050902060903090700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------060506050902060903090700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------060506050902060903090700--

