Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-user] 2.6 too, was Re: [uml-devel] Updated uml kernel
In-Reply-To: <cndqnr$hi0$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.58.0411161635500.3791@sparrow>
References: <Pine.LNX.4.58.0411151550340.4216@sparrow>
	<Pine.LNX.4.58.0411161234550.3791@sparrow> <cndqnr$hi0$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
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
Date: Tue, 16 Nov 2004 16:37:52 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, ML-uml-user <user-mode-linux-user@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good afternoon, Sven,

On Tue, 16 Nov 2004, [ISO-8859-1] Sven K=F6hler wrote:

> > 	I have both kernels running on some of the virtual machines on=20
> > Zaphod without any apparent problems so far.
>=20
> I envy you. For me, my own compiled UML-kernels crash from time to time=20
> after some compiling. Well, the last stable version for me was 2.6.6 as=20
> a guest.

	Just for grins, pull down the 2.6.10-rc2 I just compiled and see=20
if it runs any better.  The kernel config should be generic enough that it =

will at least boot.
	It was compiled on fedora core 1, with:
[root@sparrow init.d]# rpm -q gcc glibc
gcc-3.3.2-1
glibc-2.3.2-101.4
	Cheers,
	- Bill

---------------------------------------------------------------------------
	If it happens once, it's a bug.  If it happens twice, it's=20
a feature.  If it happens more than twice, it's a design philosophy.
(Courtesy of Slashdot)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
