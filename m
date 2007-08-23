Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOE5V-0007fP-3P for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 07:55:09 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IOE5U-0005BU-JT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 07:55:09 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 23 Aug 2007 16:54:59 +0200
References: <20070817194342.GA8759@c2.user-mode-linux.org>
	<alpine.LFD.0.999.0708181924020.29105@enigma.security.iitk.ac.in>
In-Reply-To: <alpine.LFD.0.999.0708181924020.29105@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Message-Id: <200708231655.00034.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 6/6] UML - Fix hostfs style
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0790916717=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Joe Perches <joe@perches.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Satyam Sharma <satyam@infradead.org>

--===============0790916717==
Content-Type: multipart/signed; boundary="nextPart1313318.Pyyd6JArXv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1313318.Pyyd6JArXv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On sabato 18 agosto 2007, Satyam Sharma wrote:
> On Fri, 17 Aug 2007, Jeff Dike wrote:
> > Style fixes in hostfs.

> > @@ -328,17 +326,17 @@ int hostfs_readdir(struct file *file, vo
> > [...]
> > -		if(error) break;
> > +		if (error) break;
>
> 		if (error)
> 			break;
>
> > @@ -522,28 +523,28 @@ static int init_inode(struct inode *inod
> > [...]
> >  	else type =3D OS_TYPE_DIR;
>
> I wonder what's the generally accepted / followed coding style for this,
> actually. Personally I'd prefer:
>
> 	else
> 		type =3D OS_TYPE_DIR;

I strongly agree with this style; beyond style itself, one strong reason is=
=20
that joining statements hinder singlestepping through function code (it's=20
easy to run gdb on UML, and anyway kgdb exists).

Bye
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1313318.Pyyd6JArXv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGzZ/EqH9OHC+5NscRAu9LAJ9Kfap/sqi4QUvuyIhtj+DEnDHGdgCfbcq9
eBLRrE2+pLPdltvMN+fcbec=
=SRqk
-----END PGP SIGNATURE-----

--nextPart1313318.Pyyd6JArXv--


--===============0790916717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0790916717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0790916717==--

