Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbwG6-0002sL-DH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Dec 2003 22:24:38 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AbwG6-0001Tg-1g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Dec 2003 22:24:38 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i016OSiC018791
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Jan 2004 00:24:28 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
In-Reply-To: <200312301906.29735.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0401011410410.27885@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200312301906.29735.blaisorblade_spam@yahoo.it>
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
Date: Thu, 1 Jan 2004 14:14:54 +0800 (SGT)
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 30 Dec 2003, BlaisorBlade wrote:

> Alle 17:32, luned=EC 29 dicembre 2003, Jeff Chua ha scritto:
> > uml-patch-2.4.22-5 works fine, but newer patches fail during boot
> >
> > Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode fa=
ult
> > at addr 0x48965000, ip 0x400e51a4
>
> What is your host distro? From some other problems I guessed you have a
> Debian. Would you confirm this, please? It's the 3rd/4th time I'm asking =
you
> this.


It's neither. I supposed it's closer to redhat.


  Linux 2.4.24-pre3
  binutils-2.14.90.0.7
  gcc version 2.95.3 20010315 (release)
  glibc-2.2.5-34.src.rpm

  LVM version:     2.00.08 (2003-11-14)
  Library version: 1.00.07-ioctl (2003-11-21)
  Driver version:  4.0.5


> If this is true, see this thread started on 20/12/2003 by Matt Zimmerman:
>
> 2.4.22-[67] problems
>
> And, if you can, test that under different Debian versions as he did (i.e=
. it
> seems that this happens only if UML is compiled under a certain environme=
nt
> and not another).
>
> The actual error is very different from the one you report. But since the=
 two
> errors seem being about memory corruption (invalid pointer or race
> conditions), it's very likely that the problem is the same. I also think =
this
> because LVM code is probably correct!

Without loading LVM, the problem would not happen.


Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
