Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmEga-0000vj-P3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jan 2005 09:11:04 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CmEgW-0001EL-0c for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jan 2005 09:11:04 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<040e01c4f272$c44e35f0$0201a8c0@hawk>
	<20050105112813.GA14779@bytesex>
In-Reply-To: <20050105112813.GA14779@bytesex>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1250595.tRK1pi7o76";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501051522.52632.Armin.Warda@gmx.de>
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
Date: Wed, 5 Jan 2005 15:22:47 +0100
To: user-mode-linux-devel@lists.sourceforge.net

--nextPart1250595.tRK1pi7o76
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 January 2005 12:28, Gerd Knorr wrote:
> > > # mount tmpfs tmp/ -t tmpfs
> > > # TMPDIR=3D./tmp/ /kernels/non-fix-kill-patched-kernel
> > > rootfs=3Ddebian.fs # uml_mconsole .uml/xxx/mconsole cad
> > > # kill -KILL <pid1> <pid2>
>
> That doesn't kill all the processes, I additionally need 'kill
> -CONT' for one of them.

I remember that behaviour you describe from the uml-kernel that was=20
delivered on SuSE 9.2's Distribution media, um-host-kernel-2.6.8-24.*=20

But my 2.6.9-bb4 um-kernel does not show that problem, I think because=20
bb4 has that fix-kill patch inside.

> > > # umount tmp/
> > > umount: /root/tmp: device is busy
>
> Works for me, at least when no uml kernel process left over.=20
> Sure there are no uml processes hanging around any more=20
> at this point? =20

Yes, I am very sure: ps and lsof show no more uml processes, lsof=20
shows no processes using the /tmp any more, but still I cannot umount=20
it. (As I described in my original posting, see:=20
http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D110301482900866=
&w=3D2

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1250595.tRK1pi7o76
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB2/g8RyBj5Zbydm0RAhN1AJ49yOzfajeMPx+0drNTnP0PFmpvjgCfTjyT
FJ0zlo6LZVG94VoS7pSkBxw=
=Mddc
-----END PGP SIGNATURE-----

--nextPart1250595.tRK1pi7o76--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
