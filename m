Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbOGA-0003VY-0R
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:06:26 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbOG9-0002EW-E7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:06:25 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312301906.29735.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Dec 2003 19:06:29 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 17:32, luned=EC 29 dicembre 2003, Jeff Chua ha scritto:
> uml-patch-2.4.22-5 works fine, but newer patches fail during boot
>
> Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode fault
> at addr 0x48965000, ip 0x400e51a4

What is your host distro? From some other problems I guessed you have a=20
Debian. Would you confirm this, please? It's the 3rd/4th time I'm asking yo=
u=20
this.

If this is true, see this thread started on 20/12/2003 by Matt Zimmerman:

2.4.22-[67] problems

And, if you can, test that under different Debian versions as he did (i.e. =
it=20
seems that this happens only if UML is compiled under a certain environment=
=20
and not another).

The actual error is very different from the one you report. But since the t=
wo=20
errors seem being about memory corruption (invalid pointer or race=20
conditions), it's very likely that the problem is the same. I also think th=
is=20
because LVM code is probably correct!

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
