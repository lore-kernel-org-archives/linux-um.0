Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IdMhf-00089D-Nt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Oct 2007 02:09:07 -0700
Received: from nz-out-0506.google.com ([64.233.162.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IdMhd-0002pY-Sw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Oct 2007 02:09:07 -0700
Received: by nz-out-0506.google.com with SMTP id f1so252476nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Oct 2007 02:09:02 -0700 (PDT)
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 4 Oct 2007 14:38:51 +0530
MIME-Version: 1.0
Message-Id: <200710041438.57150.rrs@researchut.com>
Subject: [uml-devel] SKAS as a module
Reply-To: Ritesh Raj Sarraf <rrs@researchut.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1213839535=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1213839535==
Content-Type: multipart/signed; boundary="nextPart2233540.ASHPs7uxC8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2233540.ASHPs7uxC8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm not sure if this has been asked here before.

Performance of UML improves a lot when used with SKAS. But SKAS is not in t=
he=20
standard kernels shipped by most distributions. Probably because it isn't=20
included upstream.

Is there a possibility of turning the patch to be used as a kernel module ?
If yes, I guess distributors will be able to ship it separately. And users=
=20
will be able to use it with their standard kernels shipped by the=20
distributors.


Please CC me. I'm not subscribed to the list.

Ritesh
=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--nextPart2233540.ASHPs7uxC8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBK2p4Rhi6gTxMLwRArRTAKChWruIQD6wfzPPH+1BDo23d7/p6gCeKeQJ
n+e+boux392HJ24MCf1qHeA=
=9AFF
-----END PGP SIGNATURE-----

--nextPart2233540.ASHPs7uxC8--


--===============1213839535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1213839535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1213839535==--

