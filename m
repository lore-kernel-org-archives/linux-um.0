Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ClQlm-0003uO-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Jan 2005 03:53:06 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1ClQlg-0004OZ-MG for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Jan 2005 03:53:06 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200412301520.48951.Armin.Warda@gmx.de>
	<20050103101316.GA23717@bytesex>
In-Reply-To: <20050103101316.GA23717@bytesex>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11772313.DAgCVleDkF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501031249.26675.Armin.Warda@gmx.de>
Subject: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
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
Date: Mon, 3 Jan 2005 12:49:21 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

--nextPart11772313.DAgCVleDkF
Content-Type: multipart/mixed;
  boundary="Boundary-01=_CFT2BPB0FReArFk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_CFT2BPB0FReArFk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi Gerd,

On Monday 03 January 2005 11:13, Gerd Knorr wrote:
> > (Is 2.6.8-24.10 a 2.6.8 with back-ported fixes from 2.6.10 ?)
>
> Yep, there is a batch of fixes backported to fix the breakouts ...

Is there any chance, that the bugfixfor the=20
"/tmp-fills-irreversibly-and-cannot-be-unmounted" problem,=20
that seems to be fixed starting with 2.6.10-rc3-bk10 (and was
positively tested by me in the final 2.6.10) is being backported=20
to a SuSE 2.6.8-XX.YY host kernel, too?

=2E..and a happy new year!

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--Boundary-01=_CFT2BPB0FReArFk
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: "Christopher S. Aker" <caker@theshore.net>: Re:
	[uml-devel] unable to unmount tmpfs problem lives on
Content-Disposition: inline

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-uberspam1.sourceforge.net (66.35.250.206) by
	mail.epost.de (7.2.033.1)
	id 41C0EEDA00021BEC; Fri, 17 Dec 2004 04:08:04 +0100
Received: from projects.sourceforge.net (sc8-sf-list1-b.sourceforge.net
	[10.3.1.7]) by sc8-sf-uberspam1.sourceforge.net (Postfix) with ESMTP
	id CF6931D0D19; Thu, 16 Dec 2004 19:08:01 -0800 (PST)
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf8Se-00011A-NS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 19:07:20 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cf8Se-0004il-63 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 19:07:20 -0800
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id iBH37Jt6027294;
	Thu, 16 Dec 2004 22:07:19 -0500
Message-ID: <000d01c4e3e5$a2ccc040$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: "uml-devel" <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Paolo Giarrusso" <blaisorblade_personal@yahoo.it>
References: <000601c4e3cc$119a1280$0201a8c0@hawk>
	<200412170115.15731.blaisorblade_personal@yahoo.it>
	<001e01c4e3ce$c873fff0$0201a8c0@hawk>
	<200412170130.13717.blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] unable to unmount tmpfs problem lives on
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-Spam-Score: -4.6 (----)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	-4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.3 AWL                    AWL: Auto-whitelist adjustment
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
X-BeenThere: user-mode-linux-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
X-Original-Date: Thu, 16 Dec 2004 21:08:07 -0600
Date: Thu, 16 Dec 2004 21:08:07 -0600

A little more info...

My method for causing the problem every time (example works under 2.6.9-ck3 and
2.6.10-rc2-bk7)

# mount tmpfs tmp/ -t tmpfs
# TMPDIR=./tmp/ /kernels/non-fix-kill-patched-kernel rootfs=debian.fs
# uml_mconsole .uml/xxx/mconsole cad
# kill -KILL <pid1> <pid2>
# umount tmp/
umount: /root/tmp: device is busy

(cad is set to shutdown in the UML's inittab.  After sending CAD, it hangs, which
requires kill)

Under 2.6.10-rc3-bk10 this works fine --the tmpfs mount is unmounted without
problems.  Perhaps it's fixed in recent patches. :)

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--Boundary-01=_CFT2BPB0FReArFk
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: "Armin M. Warda" <Armin.Warda@epost.de>: [uml-devel] UML
	fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
Content-Disposition: inline

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-spam2.sourceforge.net (66.35.250.220) by mail.epost.de
	(7.2.033.1) id 41BEA36200000FB3; Tue, 14 Dec 2004 10:00:48 +0100
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=projects.sourceforge.net)
	by sc8-sf-spam2.sourceforge.net with esmtp (Exim 4.33)
	id 1Ce8XK-0007MC-0j; Tue, 14 Dec 2004 01:00:02 -0800
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ce8WZ-0003dt-91 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 00:59:15 -0800
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ce8WX-00026Y-56 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 00:59:15 -0800
Received: from [10.49.3.159] (212.214.189.26) by mail.epost.de (7.2.033.1)
	(authenticated as Armin.Warda)
	id 41BCF86800026F6D for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 09:59:10 +0100
From: "Armin M. Warda" <Armin.Warda@ePost.De>
Reply-To: Armin.Warda@gmx.De
Organization: At Home
To: user-mode-linux-devel@lists.sourceforge.net
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1392240.Y4xgQlmNSQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412140958.58402.Armin.Warda@ePost.De>
X-Spam-Score: -4.9 (----)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	-4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Subject: [uml-devel] UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
X-BeenThere: user-mode-linux-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
X-Original-Date: Tue, 14 Dec 2004 09:58:52 +0100
Date: Tue, 14 Dec 2004 09:58:52 +0100

--nextPart1392240.Y4xgQlmNSQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi,

running UML 2.6.9-bb4 on SuSE Professional 9.2 with host kernel SuSE=20
2.6.8-24.5 (with SKAS) I notice the strange effect, that /tmp keeps=20
filling irreversibly.

/tmp space is not only consumed as long as UMLs are running (as seen=20
with "lsof|grep deleted"), /tmp space is _not_released_ when the UMLs=20
are gone. When all UMLs are gone "lsof|grep deleted" returns nothing,=20
but "df /tmp" still shows the allocations. In this situation attempts=20
to umount (or remount ro) the /tmp fail, even in single user mode.

The only way to recover from such a /tmp full situation is to reboot=20
the host (then unmount of /tmp and the rootfs fail during shutdown,=20
which causes fscks at the reboot...)

I tried out different filesystem types for /tmp: reiserfs 3.6, ext3=20
and tmpfs, no difference.

Anybody seen such behaviour before?

I suppose this must be a bug of the _host_ kernel, not of the UML=20
kernel. Do you agree?

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1392240.Y4xgQlmNSQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBvqtSRyBj5Zbydm0RAvTNAJwJ6kea9AZXUVzqXX9ohmfsZAAzeQCgxgVD
RRiW/CA21Y3m1eiLOeCoIVo=
=vhO7
-----END PGP SIGNATURE-----

--nextPart1392240.Y4xgQlmNSQ--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--Boundary-01=_CFT2BPB0FReArFk--

--nextPart11772313.DAgCVleDkF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB2TFGRyBj5Zbydm0RAgNIAKDi9C0A3lHHZFN4Q6053oZmH5gWPQCfXMQh
qHWtxi2nmXd9nqOo64n1iTo=
=ItJ1
-----END PGP SIGNATURE-----

--nextPart11772313.DAgCVleDkF--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
