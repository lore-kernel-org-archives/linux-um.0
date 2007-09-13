Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVuDr-000680-4q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 12:19:31 -0700
Received: from scorpius.cttc.es ([84.88.62.197])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVuDq-0000jV-7Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 12:19:31 -0700
Message-ID: <46E9A824.3010808@cttc.es>
Date: Thu, 13 Sep 2007 23:14:12 +0200
From: =?ISO-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
MIME-Version: 1.0
References: <46DDAD83.4030004@cttc.es>
	<20070912203002.GA9725@c2.user-mode-linux.org>
	<46E88B64.7090705@cttc.es>
	<200709131909.01286.blaisorblade@yahoo.it>
In-Reply-To: <200709131909.01286.blaisorblade@yahoo.it>
Subject: [uml-devel] (Solved) Hanging using 'iptables -L' in UML vm booted
	with con0=pts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: =?ISO-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>

Hi,

After some more debugging I think I've solved the problem (at least :) =

An explanation follows.

First, although apparently it seemed that the modules causing the =

problem were the ones related with networking (as David Fern=E1ndez said =

in his mail) that assumption was wrong. In fact, the modules causing the =

problem are the ones that print some message in the "kernel message =

buffer" (I don't know what is the right name, but I'm referring to the =

message log that appears when the dmesg command is used) when modprobe =

load them. For example, ip_tables prints something like "ip_tables: (C) =

2000-2006 Netfilter Core Team".

The solution to the problem is using con1 instead of con0, I mean:

./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp umid=
=3Drun

instead of

./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp umid=
=3Drun

In that case you can 'iptables -L' works without problems.

Why? When the module is loaded it prints its message not only in the =

internal kernel message buffer but also in con0 (this can be checked =

running simply "./linux ubd0=3D/tmp/root_fs_debug", without con=3D =

redirectors). When con0 is redirected to null (con0=3Dnull) there is no =

problem, but if con0 is redirected to a pts (con0=3Dpts) I guess that, in =

the moment of printing the message, some problem occurs with the output =

(as Jeff suggest in its mail) thus causing the vm hang.

This explains also why putting the module in /etc/modules works. The =

loading of the list of modules in /etc/modules is performed before UML =

assign virtual console to pts devices (the sequence can be checked =

observing the booting log).

I think that my solution is more a workaround that a definitive =

solution. Why when con0 is assigned to a pts modules can not (because of =

it hangs the vm) print its message but when it is assigned to null it =

works? Is there a bug in the UML kernel that need to be fixed? Or maybe =

the bug is in modprobe? I leave the question open for the experts in the =

UML internals... :)

Regarding the tests suggested by Paolo:

> Please try logging in via SSH and reproducing the problem and the stacktr=
ace, =

> and also removing con=3Dnull - also have you double checked con=3Dnull is=
 ok =

> (maybe it was con=3Dnone, I'm not sure). I'm not sure screen is perfectly=
 safe =

> to use (it should be).

Do you really need that I perform these test or considers the report =

above is enough? If it's really needed I can do them, but it would take =

me some time (and maybe now it isn't a good idea because of they won't =

provide additional useful information :)

Best regards,

--------------------
Ferm=EDn Gal=E1n M=E1rquez
CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic s/n, 08860
Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12
Fax : +34 93 645 29 01
Email address: fermin dot galan at cttc dot es

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
