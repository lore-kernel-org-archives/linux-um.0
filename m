Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bclfm-0002b9-2C for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 06:50:50 -0700
Received: from mail-01.iinet.net.au ([203.59.3.33] helo=mail.iinet.net.au)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Bclfl-0003Li-AD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 06:50:49 -0700
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] hostfs / current->fsuid
Message-ID: <20040622135044.GG25291@patrick.wattle.id.au>
References: <20040621034434.GC2735@thump.bur.st>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20040621034434.GC2735@thump.bur.st>
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
Date: Tue, 22 Jun 2004 21:50:45 +0800
To: Trent Lloyd <lathiat@bur.st>
Cc: user-mode-linux-devel@lists.sourceforge.net



--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Trent,

Since no-one else has answered yet, I'll have a shot...

On Mon, Jun 21, 2004 at 11:44:35AM +0800, Trent Lloyd wrote:

| I was looking into trying to modify hostfs so if UML ran as root it
| would keep the same permissions

I've no idea about modifying hostfs, but have you looked into using
NFS instead?  Sure, it's a security nightmare, but it can't be worse
than running UML as root!  Performance might suck though.

Cameron.



--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2Dk0l1rlvh2uVnMRAv8TAKCDe/BTKTbH5V8zBsZdDTxEH6vZjwCgjZ3H
CRN3is0BiWsoY01IZcn55dI=
=QsAh
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
