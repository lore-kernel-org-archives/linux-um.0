Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV6Iu-00016j-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:01:24 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IV6Iq-00015z-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:01:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 11 Sep 2007 16:00:58 +0200
References: <46E016D8.4000803@theshore.net>
	<20070910161400.GF14112@c2.user-mode-linux.org>
	<46E5CE03.6000009@theshore.net>
In-Reply-To: <46E5CE03.6000009@theshore.net>
MIME-Version: 1.0
Message-Id: <200709111601.03376.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0035540076=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

--===============0035540076==
Content-Type: multipart/signed; boundary="nextPart11241731.GUtgPMAfGI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart11241731.GUtgPMAfGI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On marted=EC 11 settembre 2007, Christopher S. Aker wrote:
> Jeff Dike wrote:
> > On Thu, Sep 06, 2007 at 11:03:52AM -0400, Christopher S. Aker wrote:
> >> 2.6.22.6-um
> >>
> >> init_new_context_skas - new_mm failed, errno =3D -24
> >> init_new_context_skas - new_mm failed, errno =3D -24
> >> init_new_context_skas - new_mm failed, errno =3D -24
> >> Kernel panic - not syncing: switch_mm_skas - PTRACE_SWITCH_MM failed,
> >> errno =3D 9
> >>
> >> Is this cause by a still-too-low max_map_count value?
> >
> > Could be - what was the host's max_map_count?
> >
> > 				Jeff

errno =3D 24 means EMFILE (too many open files).

And I read, in mm/mmap.c: do_mmap_pgoff():

        /* Too many mappings? */
        if (mm->map_count > sysctl_max_map_count)
                return -ENOMEM;

While open_proc_mm only returns 0 or -ENOMEM.

So I'm 99% sure that you have indeed too many open files. There is a=20
differnence between EMFILE and ENFILE - I vaguely remember that the 2nd is=
=20
about ulimit while the first is about the total number of fd's. (man proc=20
should says how to increase it - it is under /proc/sys).

> root@atlanta20:~# cat /proc/sys/vm/max_map_count
> 500000
> root@atlanta20:~# free -g
>               total       used       free     shared    buffers     cached
> Mem:            23          8         15          0          0          7
> -/+ buffers/cache:          0         23
> Swap:            1          0          1

Btw, note this:
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
SourceForge has not implemented AdSense at all, it seems...
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart11241731.GUtgPMAfGI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG5p+fqH9OHC+5NscRArOaAKCCzFMvpX8rNQJLyZhVSERcnqQ64ACdHxug
ONRuH5Sf95Ec5tcCyEU2VKM=
=zOhb
-----END PGP SIGNATURE-----

--nextPart11241731.GUtgPMAfGI--


--===============0035540076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0035540076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0035540076==--

