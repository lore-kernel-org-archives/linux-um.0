Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATTnM-0006MV-Kj
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:24:00 -0800
Received: from host81-134-133-54.in-addr.btopenworld.com ([81.134.133.54] helo=factotum.office.bytemark.co.uk)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ATTnL-0003DY-TU
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:24:00 -0800
From: Matthew Bloch <matthew@bytemark.co.uk>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host physical RAM
References: <200312081639.22888.matthew-list@bytemark.co.uk> <200312081901.hB8J1VAv028738@ccure.user-mode-linux.org>
In-Reply-To: <200312081901.hB8J1VAv028738@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312082223.54582.matthew@bytemark.co.uk>
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
Date: Mon, 8 Dec 2003 22:23:53 +0000
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 08 December 2003 19:01, Jeff Dike wrote:
> As far as I'm concerned, this is papering over the symptoms rather than
> fixing a real problem.
>
> If you're really not overselling memory, then the host should not be
> swapping. If it is, then that's the problem.

Hi Jeff, I don't think this is true.  The 2.4 kernel does appear to swap ou=
t=20
applications when (e.g.) a large file copy is underway, and the 2.6 kernel =

has been tweaked to get around this problem:

http://kerneltrap.org/node/view/1044

We've not had enough time to try 2.6 on a production server as a host kerne=
l,=20
but I'd be interested if you did know a way of tweaking a 2.4 host kernel t=
o=20
guarantee RAM-locked pages to user-mode kernels; Matt Ayres mentioned "some=
=20
interactivity and vm patches", could you elaborate on that please Matt?  Fo=
r=20
various reasons, we use a Redhat 2.4.20 kernel which I believe has had its =

memory management fiddled with.

I like the sound of the more dynamic memory arrangement and manager daemon =
for=20
UMLs, sounds like a good way to squeeze more customers onto a host machine.=
 =20
But if for the moment the only thing it should do is to keep the host from =

swapping, I know from a few our customers that mlocking has given more=20
predictable behaviour from guest kernels, especially if the host load spike=
s=20
for a few minutes.  That's my only argument as to why it should be included=
:=20
mlocked kernels behave more predictably in a hosting environment!  But=20
obviously I'm biased; if I can get the same effect without the patch on a 2=
.4=20
host kernel I'd agree it's moot.

- --=20
Matthew Bloch                             Bytemark Hosting
                                  tel. +44 (0) 8707 455026
                        http://www.bytemark-hosting.co.uk/
          Dedicated Linux hosts from 15ukp ($26) per month
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1Pn5T2rVDg8aLXQRAuMmAJ9BXfBodQcUX2AMPUfHdrKAtKTSMgCcCBc1
MI6K3OJQUdG1uqvzKq8MOMw=3D
=3DZip4
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
