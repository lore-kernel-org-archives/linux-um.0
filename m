Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqAB-0002v1-M6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:00:47 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.25] helo=mwinf0601.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqA8-0008KG-AL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:00:44 -0700
Subject: Re: [uml-devel] [PATCH] host context switch reduction
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
Content-Type: multipart/mixed; boundary="=-TS8aHYSZU1j4dAJravpv"
Message-Id: <1084831251.1230.4.camel@chartreuse>
Mime-Version: 1.0
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
Date: Tue, 18 May 2004 00:00:52 +0200
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net



--=-TS8aHYSZU1j4dAJravpv
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	i4HMABIm007765

Hi,

find hereunder the measurements I sent to Jeff.

If someone think this patch is really useful for 2.6 I can make the
port.

Regards,
Laurent
Please CC: me, as I'm not in the mailing list.

Le lun 17/05/2004 =E0 22:08, roland a =E9crit :
> hi !
> has this / will this be ported to 2.6 ?
> have there been made further performance comparisons ?
> regards
> roland
>=20
>=20
> >Well, we just looked at the context switches. We started 3 UMLs which
> >were doing a make world for xfree. Without patches the number of
> >context switches per second was around 60k, with the patch it was arou=
nd
> >40k - so it's noticeable, at least from the cs.
> >Sven
>=20
> ----- Original Message -----=20
> From: "Jeff Dike" <jdike@addtoit.com>
> To: <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Sunday, February 29, 2004 6:35 AM
> Subject: [uml-devel] [PATCH] host context switch reduction
>=20
>=20
> > The patches below are from Laurent Vivier who didn't make them public=
.  They
> > add a new feature to ptrace on the host which cuts down on the number=
 of
> > context switches needed for a UML system call, plus makes UML use it.
> >=20
> > There's some interest in this, so I'm putting it out as-is.  I haven'=
t played
> > with it.
> >=20
> > Laurent did some performance testing and found ~40% speedup on a getp=
id
> > loop, and a 3.5% speedup on a kernel build.
> >=20
> > Jeff
> >=20
> >=20

--=-TS8aHYSZU1j4dAJravpv
Content-Disposition: attachment; filename=measure-getpid.txt
Content-Type: text/plain; name=measure-getpid.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>

int main(int argc, char** argv)
{
        int i;
	int loop = atol(argv[1]);

        for (i = 0; i < loop; i++)
        {
                getpid();
        }
}

NATIF:

time ./getpid 10000000

real    0m7.920s
user    0m3.990s
sys     0m3.940s

UML with sysemu

real    3m55.052s
user    0m5.962s
sys     0m46.385s

real    3m56.964s
user    0m5.846s
sys     0m42.635s

real    3m54.179s
user    0m5.981s
sys     0m47.154s

UML w/o sysemu

real    6m16.956s
user    0m5.250s
sys     0m58.462s


real    6m17.126s
user    0m4.846s
sys     1m1.731s


real    6m16.461s
user    0m5.077s
sys     0m59.365s

---------------------------------------

original UML:

time make dep > /dev/null

real    4m51.669s
user    0m37.462s
sys     0m51.846s

time make bzImage modules > /dev/null

real    13m35.457s
user    4m18.885s
sys     1m40.481s

UML with sysemu:

time make dep > /dev/null

real    3m52.486s
user    0m37.981s
sys     0m50.808s

time make bzImage modules > /dev/null

real    13m5.980s
user    4m18.096s
sys     1m40.115s


--=-TS8aHYSZU1j4dAJravpv--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
