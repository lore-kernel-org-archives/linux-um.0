Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5kmg-0000Ek-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:59:22 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I5kma-0001Lj-Vx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:59:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 3 Jul 2007 17:47:18 +0200
References: <9604cc9f0706291214y92b1d49w198c59a5563acded@mail.gmail.com>
In-Reply-To: <9604cc9f0706291214y92b1d49w198c59a5563acded@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200707031747.19179.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Deadlock when calling securityfs_create_dir
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0501513405=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: kototama kototama <kototamo@gmail.com>

--===============0501513405==
Content-Type: multipart/signed; boundary="nextPart4481313.aFnGhm3CXs";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4481313.aFnGhm3CXs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On venerd=EC 29 giugno 2007, kototama kototama wrote:
> Hello,
>
> After mounting securityfs like this:
>
> uml# mount securityfs -t securityfs /sys/kernel/security
>
> I load a module which performs these operations:
>
>
> static void securityfs_init(void)
> {
>         struct dentry *de;
>
>
>         printk(KERN_ALERT "securityfs_init\n");
>         de =3D securityfs_create_dir("berlinfw2", NULL);
>         if(!de) {
>                 printk(KERN_ALERT "Can't create security directory\n");
>         }
> }
>
>
> Then I've got a deadlock, interruption uml, and showing the stackstrace
> gives that:
>
> #0  hard_handler (sig=3D11) at arch/um/os-Linux/sys-i386/signal.c:11
> #1  <signal handler called>
> #2  0x081b76da in mutex_lock (lock=3D0x40162068) at
> include/asm/arch/atomic.h:189
> #3  0x0812dfbb in create_by_name (name=3D0xa81b09c "<1>securityfs_init\n",
> mode=3D16877, parent=3D0x95a3f1c,
>     dentry=3D0x95a3ec8) at security/inode.c:173
> #4  0x0812e0e0 in securityfs_create_file (name=3D0xa81b09c
> "<1>securityfs_init\n", mode=3D16877, parent=3D0x95a3f1c,
>     data=3D0x0, fops=3D0x0) at security/inode.c:231
> #5  0x0812e160 in securityfs_create_dir (name=3D0xa81b09c
> "<1>securityfs_init\n", parent=3D0x95a3f1c)
>     at security/inode.c:272
> #6  0x0a81b04a in ?? ()
> #7  0x0a81b09c in ?? ()
> #8  0x095a3f1c in ?? ()
> #9  0x0809de76 in sys_init_module (umod=3D0x821aab4, len=3D1, uargs=3D0xa=
81b440
> "\001") at kernel/module.c:1991
>
> The module works fine on the host.

Hmm, it's possible, but this does not seem UML's fault either. Have you tri=
ed=20
to get a backtrace through uml_mconsole?

A note: the check for errors is wrong, you should also check IS_ERR(de).=20
Actually I also see this cannot cause a deadlock (nor can the NULL argument=
).

When CONFIG_SECURITY is disabled, this implementation from=20
include/linux/security.h is used:

static inline struct dentry *securityfs_create_dir(const char *name,
                                        struct dentry *parent)
{
        return ERR_PTR(-ENODEV);
}

Possibly you just disabled CONFIG_SECURITY on the host (well, the default=20
Ubuntu kernel has it enabled).

> The host kernel is=20
> 2.6.20-16-generic(ubuntu feisty fawn), the uml kernel is compiled from
> ubuntu sources.
>
> It seems there is a memory problem in the frame #5, the argument of the
> call is wrong!

Never fully trust gdb output, when running optimized binaries. It may help =
to=20
compile UML replacing -O2 with -O1 or even -O0 (in the latter case, it may=
=20
even not compile successfully).

If you add a breakpoint on securityfs_create_dir and singlestep to look at=
=20
what happens (which you should do), you'll probably see that a bit after th=
e=20
breakpoint gdb shows the correct value (it often does not at breakpoint's=20
time), and later the value will change when the space is reused.

Btw, breakpoints will work better if you attach to UML after boot rather th=
an=20
starting UML from inside gdb.

Bye
=2D-=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--nextPart4481313.aFnGhm3CXs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGim+HqH9OHC+5NscRAjkEAJ4gXEzlGp4WUKqrsQP7+XdbDOAozACfVo/q
IYKnCB9JlQGslCtAY3sbYJE=
=ORGe
-----END PGP SIGNATURE-----

--nextPart4481313.aFnGhm3CXs--


--===============0501513405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0501513405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0501513405==--

