Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VnawE-0003uK-6p
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 21:21:54 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VnawC-0001P6-6r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 21:21:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 02 Dec 2013 22:21:42 +0100
Message-ID: <7306830.yvMa5tydAA@sandpuppy>
In-Reply-To: <529B8893.1030703@gmx.de>
References: <5299F818.4070408@gmx.de> <1423288.L1vGMMJNcF@sandpuppy>
	<529B8893.1030703@gmx.de>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] does 3.12.2 breaks UML with "con=xterm" ?
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Am Sonntag, 1. Dezember 2013, 20:05:55 schrieb Toralf F=F6rster:
> On 12/01/2013 11:20 AM, Richard Weinberger wrote:
> > I meant xterm for all consoles but con0...
> > Such that you can trigger the crash but are still able to see the outpu=
t.
> =

> Not sure if the 2 attached files contains useful info, but here they are:
> =

> The back trace of a hanging linux process :
> $>sudo gdb /home/tfoerste/devel/linux/linux 27162 -n -batch -ex 'bt full'=
 >
> bt
> =

> and stdout, error and bt of the core file from round #18 of this command :
> =

> $> I=3D0; while [[ : ]]; do ((I=3DI+1)); echo; echo; echo $I; date; for i=
 in
> trinity.sh xterm linux port-helper start_uml.sh ; do pkill $i; done; rm -f
> /mnt/ramdisk/core; start_uml.sh -r ~/virtual/uml/trinity -l
> /home/tfoerste/devel/linux/linux -y 'con0=3Dfd:0,fd:1 con=3Dxterm'
> 1>/mnt/ramdisk/$I.out 2>/mnt/ramdisk/$I.err; [[ -f /mnt/ramdisk/core ]] &&
> gdb --core=3D/mnt/ramdisk/core /home/tfoerste/devel/linux/linux -n -batch=
 -ex
> 'bt full' > /mnt/ramdisk/$I.bt; sleep 10; done

What I can see is that UML panic()ed because PTRACE_SETREGS is failing with =

ESRCH. This means one of the UML SKAS0 helper threads got killed and is gon=
e.
This is very strange and makes me worry, because in this stage the helper i=
s =

in stopped state and cannot really die by an UML error. Looks like it got =

killed from outside.
Is your host setup 100% sane? :)

Thanks,
//richard

---------------------------------------------------------------------------=
---
Rapidly troubleshoot problems before they affect your business. Most IT =

organizations don't have a clear picture of how application performance =

affects their revenue. With AppDynamics, you get 100% visibility into your =

Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics P=
ro!
http://pubads.g.doubleclick.net/gampad/clk?id=3D84349351&iu=3D/4140/ostg.cl=
ktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

