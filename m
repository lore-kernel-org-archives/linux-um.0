Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVEQN-0005Jy-Ur for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Nov 2004 11:28:03 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CVEQL-0005Q3-Kv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Nov 2004 11:28:03 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-user] 2.6 too, was Re: [uml-devel] Updated uml kernel
References: <Pine.LNX.4.58.0411151550340.4216@sparrow>
	<cndqnr$hi0$1@sea.gmane.org>
	<Pine.LNX.4.58.0411161635500.3791@sparrow>
In-Reply-To: <Pine.LNX.4.58.0411161635500.3791@sparrow>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200411192029.40364.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Nov 2004 20:29:39 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, ML-uml-user <user-mode-linux-user@lists.sourceforge.net>

On Tuesday 16 November 2004 22:37, William Stearns wrote:
> Good afternoon, Sven,

> On Tue, 16 Nov 2004, [ISO-8859-1] Sven K=F6hler wrote:
> > >  I have both kernels running on some of the virtual machines on
> > > Zaphod without any apparent problems so far.

> > I envy you. For me, my own compiled UML-kernels crash from time to time
> > after some compiling. Well, the last stable version for me was 2.6.6 as
> > a guest.

>  Just for grins, pull down the 2.6.10-rc2 I just compiled and see
> if it runs any better.

> The kernel config should be generic enough that it=20
> will at least boot.

Please notice that without "make defconfig ARCH=3Dum" as first step, kbuild=
=20
could not pick the generic config, but one host dependant one=20
(from /boot/config-*, for instance).

>  It was compiled on fedora core 1, with:
> [root@sparrow init.d]# rpm -q gcc glibc
> gcc-3.3.2-1
> glibc-2.3.2-101.4

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
