Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLvxd-0004ZB-2p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 21:28:13 -0700
Received: from zproxy.gmail.com ([64.233.162.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DLvxV-00059x-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 21:28:13 -0700
Received: by zproxy.gmail.com with SMTP id 40so1819976nzk
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Apr 2005 21:27:58 -0700 (PDT)
Message-ID: <cbec11ac05041321274b7d5d46@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
In-Reply-To: <cbec11ac0504132125779afc07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <cbec11ac0504132125779afc07@mail.gmail.com>
Subject: [uml-devel] Re: Problems with UML on Debian Sarge 64 host
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
Date: Thu, 14 Apr 2005 16:27:58 +1200
Content-Transfer-Encoding: quoted-printable
To: UML Developer <user-mode-linux-devel@lists.sourceforge.net>

Forgot to say that I have tested with 2.6.11.4 and -bs3, also
2.6.12-rc2. Also attempted 2.6.12-rc2 with development patch but this
won't compile at present as per earlier message.

On 14/04/05, Ian McDonald <imcdnzl@gmail.com> wrote:
> Hi there,
>=20
> In my continuing saga (which some are becoming familiar with) to get
> UML 2.6.x working at all I have been given access to another machine
> to develop on and my old machine is going to disappear.
>=20
> This machine is Debian Sarge with gcc 3.3.5 on an AMD64 with 32 bit
> userspace although 64 bit compiles can also occur.
>=20
> I am doing all my UML builds with ARCH=3Dum SUBARCH=3Di386 at this point =
in time.
>=20
> The problem is that my bootup dies very early on and this is the total ou=
tput:
> Checking for /proc/mm...not found
> Checking PROT_EXEC mmap in /tmp...OK
> tracing thread pid =3D 20981
> OP_FORK failed to attach pid
>=20
> I suspect that this is something to do with my mixed 32/64 bit
> environment but I am not sure... Can anybody shed some light on this?
>=20
> BTW I have also written a patch which I think is worth submitting into
> the kernel tree as it gives better debugging of error messages in
> arch/um/kernel/tt/tracer.c for where my process is dying.
>=20
> When I run with my patch it shows that it is dying on the
> PTRACE_ATTACH with an error EPERM but I can run other processes etc
> like gdb which attach to processes.
>=20
> Any help would be greatly appreciated.
>=20
> Ian
>=20
>=20
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
