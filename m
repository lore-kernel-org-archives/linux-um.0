Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FbziE-0005AN-RT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 05:47:14 -0700
Received: from [212.34.199.38] (helo=etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FbziD-0001wE-8u
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 05:47:15 -0700
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20060505124937.GA4327@SteX>
Reply-To: stefano.melchior@openlabs.it
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Subject: [uml-devel] Problem on generation a locales on uml image
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 May 2006 14:49:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia <malattia@debian.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear all,
I encountered an unexpected error during the installation of a pkg on my
debian uml image. I tried to install locales pkg and when it was
generating a locales env, it displayed the following output:

*********************************************************

Unpacking locales (from .../locales_2.3.6-7_all.deb) ...
Setting up locales (2.3.6-7) ...
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE =3D "it_IT.UTF-8",
        LC_ALL =3D "it_IT.UTF-8",
        LC_MESSAGES =3D "it_IT.UTF-8",
        LC_CTYPE =3D "it_IT.UTF-8",
        LANG =3D "it_IT.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_MESSAGES to default locale: No such file or
directory
locale: Cannot set LC_ALL to default locale: No such file or directory
Generating locales (this might take a while)...
  en_GB.UTF-8...BUG: soft lockup detected on CPU#0!

EIP: 0073:[<40058d3f>] CPU: 0 Not tainted ESP: 007b:af86bd78 EFLAGS:
00200246
    Not tainted
EAX: 4014ea20 EBX: 4014eff4 ECX: af86c394 EDX: af86c428
ESI: 0808c3e4 EDI: 00000000 EBP: af86c370 DS: 007b ES: 007b
0f307ba8:  [<0806efa0>] show_regs+0xb4/0xb9
0f307bd4:  [<0808ab3e>] softlockup_tick+0x46/0x4b
0f307be8:  [<0807b1cd>] do_timer+0xa4/0xaa
0f307bf8:  [<0805cb10>] um_timer+0xf/0x94
0f307c14:  [<0808acc3>] handle_IRQ_event+0x2a/0x5e
0f307c3c:  [<0808ad51>] __do_IRQ+0x5a/0x99
0f307c54:  [<08059c87>] do_IRQ+0x22/0x2e
0f307c60:  [<0805cab4>] timer_irq+0xff/0x12d
0f307c84:  [<0805cdcc>] timer_handler+0x46/0x4e
0f307c9c:  [<0806caa4>] user_signal+0x3e/0x5a
0f307cb4:  [<0806c2dc>] userspace+0x213/0x23f
0f307d04:  [<0805e486>] fork_handler+0x82/0x89
0f307d1c:  [<ffffe420>] _etext+0xf7e6d406/0x0

 done
  en_US.UTF-8... done
  it_IT.UTF-8...BUG: soft lockup detected on CPU#0!

EIP: 0073:[<4008a26d>] CPU: 0 Not tainted ESP: 007b:afe2ce24 EFLAGS:
00210206
    Not tainted
EAX: 93939393 EBX: 4014eff4 ECX: 000c5f4c EDX: 00524d10
ESI: 00524d10 EDI: 40b48000 EBP: afe2ce2c DS: 007b ES: 007b
0f39388c:  [<0806efa0>] show_regs+0xb4/0xb9
0f3938b8:  [<0808ab3e>] softlockup_tick+0x46/0x4b
0f3938cc:  [<0807b1cd>] do_timer+0xa4/0xaa
0f3938dc:  [<0805cb10>] um_timer+0xf/0x94
0f3938f8:  [<0808acc3>] handle_IRQ_event+0x2a/0x5e
0f393920:  [<0808ad51>] __do_IRQ+0x5a/0x99
0f393938:  [<08059c87>] do_IRQ+0x22/0x2e
0f393944:  [<0805cab4>] timer_irq+0xff/0x12d
0f393968:  [<0805cdcc>] timer_handler+0x46/0x4e
0f393980:  [<0806ca4b>] sig_handler_common_skas+0xab/0xc6
0f3939a8:  [<08069571>] real_alarm_handler+0x32/0x48
0f3939c0:  [<0806985b>] alarm_handler+0x3d/0x49
0f3939cc:  [<ffffe420>] _etext+0xf7e6d406/0x0
0f393cc0:  [<0806c2fc>] userspace+0x233/0x23f
0f393d04:  [<0805e486>] fork_handler+0x82/0x89
0f393d1c:  [<ffffe420>] _etext+0xf7e6d406/0x0



 done
Generation complete.
**************************************************************
stex@umldev{~}$ uname -a
Linux umldev 2.6.16 #1 Fri Apr 7 19:51:16 CEST 2006 i686 GNU/Linux

Any suggestion?

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRFtJ4YlnkxrVLfgpAQKkKQQAifVTBnSokTjh7QvB4/hK/lw6BGLuJBxb
ohpiWQgG4Org2pF+kWgKHE9aychyfPZKvgou1q5VCEv0+ADjrLjdb9VB54EjNn42
msC42EeKoE2WR6JXy6GPctpXjV44zh8hh0+EZMLxjAObaMPkh2ExqWBKAlePdmFH
Io5W4/NB9P4=
=zn+G
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
