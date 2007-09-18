Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IXeeq-0001Ef-0u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 08:06:36 -0700
Received: from hu-out-0506.google.com ([72.14.214.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IXeen-0006nv-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 08:06:35 -0700
Received: by hu-out-0506.google.com with SMTP id 28so849559hub
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 Sep 2007 08:06:27 -0700 (PDT)
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Tue, 18 Sep 2007 17:06:18 +0200
References: <46DDAD83.4030004@cttc.es>
	<200709131909.01286.blaisorblade@yahoo.it>
	<46E9A824.3010808@cttc.es>
In-Reply-To: <46E9A824.3010808@cttc.es>
MIME-Version: 1.0
Message-Id: <200709181706.22905.p.giarrusso@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1342548314=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: David =?utf-8?q?Fern=C3=A1ndez?= <david@dit.upm.es>

--===============1342548314==
Content-Type: multipart/signed; boundary="nextPart7005074.tcL2Thid2Y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7005074.tcL2Thid2Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On gioved=EC 13 settembre 2007, Ferm=EDn Gal=E1n M=E1rquez wrote:
> Hi,
>
> After some more debugging I think I've solved the problem (at least :)
> An explanation follows.
>
> First, although apparently it seemed that the modules causing the
> problem were the ones related with networking (as David Fern=E1ndez said
> in his mail) that assumption was wrong. In fact, the modules causing the
> problem are the ones that print some message in the "kernel message
> buffer" (I don't know what is the right name, but I'm referring to the
> message log that appears when the dmesg command is used) when modprobe
> load them. For example, ip_tables prints something like "ip_tables: (C)
> 2000-2006 Netfilter Core Team".

> The solution to the problem is using con1 instead of con0, I mean:
>
> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp um=
id=3Drun
>
> instead of
>
> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp um=
id=3Drun

This was con0=3Dpts, I checked your other mail. Right?

> In that case you can 'iptables -L' works without problems.

> Why? When the module is loaded it prints its message not only in the
> internal kernel message buffer but also in con0 (this can be checked
> running simply "./linux ubd0=3D/tmp/root_fs_debug", without con=3D
> redirectors). When con0 is redirected to null (con0=3Dnull) there is no
> problem, but if con0 is redirected to a pts (con0=3Dpts) I guess that, in
> the moment of printing the message, some problem occurs with the output
> (as Jeff suggest in its mail) thus causing the vm hang.

> This explains also why putting the module in /etc/modules works. The
> loading of the list of modules in /etc/modules is performed before UML
> assign virtual console to pts devices (the sequence can be checked
> observing the booting log).

> I think that my solution is more a workaround that a definitive
> solution. Why when con0 is assigned to a pts modules can not (because of
> it hangs the vm) print its message but when it is assigned to null it
> works? Is there a bug in the UML kernel that need to be fixed? Or maybe
> the bug is in modprobe? I leave the question open for the experts in the
> UML internals... :)
The problem does not lie in modprobe nor iptables - it is the behaviour of =
the=20
system console wrt. the pts driver.

The only really strange thing is the 100% cpu usage - like if the operation=
=20
were retried in a loop. And, well, there is a loop there - CATCH_EINTR (whi=
ch=20
I added)!

Now, what's unexpected is getting EINTR on that operation. That's really=20
strange. However, I'll leave debugging to Jeff. If he cannot reproduce the=
=20
problem he'll ask you more, I guess.

> Regarding the tests suggested by Paolo:
> > Please try logging in via SSH and reproducing the problem and the
> > stacktrace, and also removing con=3Dnull - also have you double checked
> > con=3Dnull is ok (maybe it was con=3Dnone, I'm not sure). I'm not sure =
screen
> > is perfectly safe to use (it should be).
>
> Do you really need that I perform these test or considers the report
> above is enough? If it's really needed I can do them, but it would take
> me some time (and maybe now it isn't a good idea because of they won't
> provide additional useful information :)

No, I just needed a proof that the problem was indeed with the output on a=
=20
pts.

Thank you for you help
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade

--nextPart7005074.tcL2Thid2Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7+luqH9OHC+5NscRAg07AJoCBbhO4wdP2v1NuHlXSuIbAiBCjACfWiUL
F8eNSQWqbQ41rdrfycY5thU=
=IdG3
-----END PGP SIGNATURE-----

--nextPart7005074.tcL2Thid2Y--


--===============1342548314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1342548314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1342548314==--

