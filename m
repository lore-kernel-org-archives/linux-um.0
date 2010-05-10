Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1OBX1V-0005Th-DR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2010 17:44:09 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OBX1U-0004t3-7l for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2010 17:44:09 +0000
Message-ID: <4BE845D9.40400@web.de>
Date: Mon, 10 May 2010 19:43:53 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <alpine.LFD.2.00.1005101719500.21053@localhost>
In-Reply-To: <alpine.LFD.2.00.1005101719500.21053@localhost>
Subject: Re: [uml-devel] uml: Error with Linked list debugging on
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0422398545406812358=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Lukas Czerner <lczerner@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0422398545406812358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06758F5F7E6F14A3088CCADB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06758F5F7E6F14A3088CCADB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Lukas Czerner wrote:
> Hi,
>=20
> I have got an error when booting uml with Linked list manipulation
> debugging turned on. The crash occurs in the exact moment when the
> consoles are showing up - it just blinks and crush. Here is the
> backtrace:
>=20
>=20
> #0  0x0000003cb8233e14 in abort () from /lib64/libc.so.6
> #1  0x00000000600220b2 in os_dump_core () at arch/um/os-Linux/util.c:11=
9
> #2  0x00000000600147c1 in panic_exit (self=3D<value optimized out>, unu=
sed1=3D<value optimized out>,=20
>     unused2=3D<value optimized out>) at arch/um/kernel/um_arch.c:233
> #3  0x0000000060045996 in notifier_call_chain (nl=3D<value optimized ou=
t>, val=3D0, v=3D0x602ffb40,=20
> nr_to_call=3D-2, nr_calls=3D<value optimized out>) at kernel/notifier.c=
:93
> #4  0x00000000600459e4 in __atomic_notifier_call_chain (nh=3D<value opt=
imized out>,=20
> val=3D<value optimized out>, v=3D<value optimized out>) at kernel/notif=
ier.c:182
> #5  atomic_notifier_call_chain (nh=3D<value optimized out>, val=3D<valu=
e optimized out>,=20
> v=3D<value optimized out>) at kernel/notifier.c:191
> #6  0x00000000601a56d0 in panic (fmt=3D0x601f3050 "Kernel mode fault at=
 addr 0x%lx, ip 0x%lx")
> at kernel/panic.c:115
> #7  0x00000000600145df in segv (fi=3D..., ip=3D1611852984, is_user=3D0,=
 regs=3D0x6024fa10)
> at arch/um/kernel/trap.c:201
> #8  0x000000006001463e in segv_handler (sig=3D<value optimized out>, re=
gs=3D<value optimized out>)
> at arch/um/kernel/trap.c:147
> #9  0x00000000600211a4 in sig_handler_common (sig=3D11, sc=3D0x6024fbe8=
) at arch/um/os-Linux/signal.c:49
> #10 0x00000000600212ea in sig_handler (sig=3D<value optimized out>, sc=3D=
<value optimized out>)
> at arch/um/os-Linux/signal.c:226
> #11 0x000000006002151c in handle_signal (sig=3D<value optimized out>, s=
c=3D0x6024fbe8)
>     at arch/um/os-Linux/signal.c:158
> #12 0x0000000060022e9c in hard_handler (sig=3D<value optimized out>)
> at arch/um/os-Linux/sys-x86_64/signal.c:15
> #13 <signal handler called>
> #14 0x000000006012ecb8 in list_del (entry=3D0x807bcf00) at lib/list_deb=
ug.c:46
> #15 0x0000000060016724 in free_winch (winch=3D0x807bcf00, free_irq_ok=3D=
0) at arch/um/drivers/line.c:731
> #16 0x0000000060016ad7 in winch_interrupt (irq=3D<value optimized out>,=
 data=3D0x807bcf00)
> at arch/um/drivers/line.c:760
> #17 0x0000000060055b45 in __free_irq (irq=3D10, dev_id=3D0x807bcf00) at=
 kernel/irq/manage.c:937
> #18 0x0000000060055bc0 in free_irq (irq=3D10, dev_id=3D0x807bcf00) at k=
ernel/irq/manage.c:986
> #19 0x0000000060016765 in free_winch (winch=3D0x807bcf00, free_irq_ok=3D=
1) at arch/um/drivers/line.c:740
> #20 0x0000000060017211 in unregister_winch (tty=3D0x8072a800, filp=3D<v=
alue optimized out>)
> at arch/um/drivers/line.c:836
> #21 line_close (tty=3D0x8072a800, filp=3D<value optimized out>) at arch=
/um/drivers/line.c:477
> #22 0x00000000601335d9 in tty_release (inode=3D0x7eff4190, filp=3D0x7fc=
9abc0) at drivers/char/tty_io.c:1580
> #23 0x000000006007e6a8 in __fput (file=3D0x7fc9abc0) at fs/file_table.c=
:254
> #24 0x000000006007e79c in fput (file=3D<value optimized out>) at fs/fil=
e_table.c:200
> #25 0x000000006007b995 in filp_close (filp=3D0x7fc9abc0, id=3D0x7fc720c=
0) at fs/open.c:1124
> #26 0x000000006007ba4a in sys_close (fd=3D3) at fs/open.c:1153
> #27 0x0000000060014c7c in handle_syscall (r=3D0x7e1ba418) at arch/um/ke=
rnel/skas/syscall.c:35
> #28 0x0000000060023e7f in handle_trap (regs=3D0x7e1ba418) at arch/um/os=
-Linux/skas/process.c:201
> #29 userspace (regs=3D0x7e1ba418) at arch/um/os-Linux/skas/process.c:41=
7
> #30 0x000000006001265b in fork_handler () at arch/um/kernel/process.c:1=
81
>=20
>=20
> Apparently, the winch is not in the list when the free_winch is
> invoked. Kernel version 2.6.34-rc7
>=20

You might be lucky: Does the patch below make a difference? It may be
untested as it's part on my half-finished uml cleanup/review queue.

Jan

------

uml: Fix locking around winch_handlers

Manipulation of the winch_handlers list has to be protected by
winch_handler_lock. So we have to add this lock to winch_interrupt which
called free_winch without lock protection and make the other lock sites
IRQ-safe.

---
 arch/um/drivers/line.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 7f8f649..dbeaa83 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -756,7 +756,9 @@ static irqreturn_t winch_interrupt(int irq, void *dat=
a)
 				       "read failed, errno =3D %d\n", -err);
 				printk(KERN_ERR "fd %d is losing SIGWINCH "
 				       "support\n", winch->tty_fd);
+				spin_lock(&winch_handler_lock);
 				free_winch(winch, 0);
+				spin_unlock(&winch_handler_lock);
 				return IRQ_HANDLED;
 			}
 			goto out;
@@ -803,9 +805,9 @@ void register_winch_irq(int fd, int tty_fd, int pid, =
struct tty_struct *tty,
 		goto out_free;
 	}
=20
-	spin_lock(&winch_handler_lock);
+	spin_lock_irq(&winch_handler_lock);
 	list_add(&winch->list, &winch_handlers);
-	spin_unlock(&winch_handler_lock);
+	spin_unlock_irq(&winch_handler_lock);
=20
 	return;
=20
@@ -823,7 +825,7 @@ static void unregister_winch(struct tty_struct *tty)
 	struct list_head *ele;
 	struct winch *winch;
=20
-	spin_lock(&winch_handler_lock);
+	spin_lock_irq(&winch_handler_lock);
=20
 	list_for_each(ele, &winch_handlers) {
 		winch =3D list_entry(ele, struct winch, list);
@@ -832,7 +834,7 @@ static void unregister_winch(struct tty_struct *tty)
 			break;
 		}
 	}
-	spin_unlock(&winch_handler_lock);
+	spin_unlock_irq(&winch_handler_lock);
 }
=20
 static void winch_cleanup(void)
@@ -840,14 +842,14 @@ static void winch_cleanup(void)
 	struct list_head *ele, *next;
 	struct winch *winch;
=20
-	spin_lock(&winch_handler_lock);
+	spin_lock_irq(&winch_handler_lock);
=20
 	list_for_each_safe(ele, next, &winch_handlers) {
 		winch =3D list_entry(ele, struct winch, list);
 		free_winch(winch, 1);
 	}
=20
-	spin_unlock(&winch_handler_lock);
+	spin_unlock_irq(&winch_handler_lock);
 }
 __uml_exitcall(winch_cleanup);
=20



--------------enig06758F5F7E6F14A3088CCADB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvoRd4ACgkQitSsb3rl5xSQXwCeP9YAnycRO2K+HC+JkOfBbjDS
w9wAoLSyzvTKwcpbhLog8v1dqh8U+NIw
=BD/i
-----END PGP SIGNATURE-----

--------------enig06758F5F7E6F14A3088CCADB--


--===============0422398545406812358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--===============0422398545406812358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0422398545406812358==--


