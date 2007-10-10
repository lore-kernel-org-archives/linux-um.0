Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfcR5-0003P2-TS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 07:21:19 -0700
Received: from mail.dit.upm.es ([138.4.2.7]
	ident=[fj10vkh+bgfJUf2aczmH+8Rpw9DsjiCF])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IfcR1-0005LK-Ck
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 07:21:18 -0700
From: =?iso-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
References: <46DDAD83.4030004@cttc.es>
	<200709131909.01286.blaisorblade@yahoo.it>
	<46E9A824.3010808@cttc.es>
	<200709181706.22905.p.giarrusso@gmail.com>
	<46F17B9D.7010404@cttc.es>
Date: Wed, 10 Oct 2007 16:21:08 +0200
Message-ID: <00b901c80b48$cd9bcdb0$9603048a@obelix>
MIME-Version: 1.0
In-Reply-To: <46F17B9D.7010404@cttc.es>
Subject: Re: [uml-devel] (Workarounded) Hanging using 'iptables -L' in UML
	vm booted with con0=pts
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
To: =?iso-8859-1?Q?'Ferm=EDn_Gal=E1n_M=E1rquez'?= <fermin.galan@cttc.es>, 'Paolo Giarrusso' <p.giarrusso@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


Hi,

Just a mail to confirm that this problem persists with new kernel 2.6.23.

I just downloaded and compiled 2.6.23 for UML
(http://www.dit.upm.es/vnuml/download/kernels/linux-2.6.23-1m.tar.bz2) and
tested that using "con0=3Dpts" the virtual machines hang when loading kernel
modules that drop traces.

Using "con1=3Dpts" the problem is solved, exactly as seen with previous ker=
nel
versions.

Best regards,
David


  > -----Mensaje original-----
  > De: Ferm=EDn Gal=E1n M=E1rquez [mailto:fermin.galan@cttc.es] =

  > Enviado el: mi=E9rcoles, 19 de septiembre de 2007 21:42
  > Para: Paolo Giarrusso
  > CC: user-mode-linux-devel@lists.sourceforge.net; David Fern=E1ndez
  > Asunto: Re: [uml-devel] (Workarounded) Hanging using =

  > 'iptables -L' in UML vm booted with con0=3Dpts
  > =

  > Dear Paolo,
  > =

  > >> The solution to the problem is using con1 instead of =

  > con0, I mean:
  > >>
  > >> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/t=
mp =

  > >> umid=3Drun
  > >>
  > >> instead of
  > >>
  > >> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/t=
mp =

  > >> umid=3Drun
  > > =

  > > This was con0=3Dpts, I checked your other mail. Right?
  > =

  > Absolutely :)
  > =

  > Best regards,
  > =

  > --------------------
  > Ferm=EDn Gal=E1n M=E1rquez
  > CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya =

  > Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic =

  > s/n, 08860 Castelldefels, Spain Room 1.02 Tel : +34 93 645 =

  > 29 12 Fax : +34 93 645 29 01 Email address: fermin dot =

  > galan at cttc dot es
  > =



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
