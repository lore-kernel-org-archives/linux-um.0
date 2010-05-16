Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1ODeV5-0001cf-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 May 2010 14:07:27 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ODeV3-0008NV-Q8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 May 2010 14:07:27 +0000
Message-ID: <4BEFFC13.4010106@web.de>
Date: Sun, 16 May 2010 16:07:15 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <alpine.LFD.2.00.1005101719500.21053@localhost>
	<4BE845D9.40400@web.de>
	<AANLkTilMZQ12zv8VvUMa0yTnwGTT7ZhiEKfzwUPgiQjF@mail.gmail.com>
	<4BEFF020.5080901@web.de>
In-Reply-To: <4BEFF020.5080901@web.de>
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
Content-Type: multipart/mixed; boundary="===============6181383870911473063=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo Giarrusso <p.giarrusso@gmail.com>
Cc: Lukas Czerner <lczerner@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6181383870911473063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F4994E58DF36B860D9DD775"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F4994E58DF36B860D9DD775
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Paolo Giarrusso wrote:
>> On Mon, May 10, 2010 at 19:43, Jan Kiszka <jan.kiszka@web.de> wrote:
>>> Lukas Czerner wrote:
>>>> Hi,
>>>>
>>>> I have got an error when booting uml with Linked list manipulation
>>>> debugging turned on. The crash occurs in the exact moment when the
>>>> consoles are showing up - it just blinks and crush. Here is the
>>>> backtrace:
>>>>
>>>>
>>>> #0  0x0000003cb8233e14 in abort () from /lib64/libc.so.6
>>>> #1  0x00000000600220b2 in os_dump_core () at arch/um/os-Linux/util.c=
:119
>>>> #2  0x00000000600147c1 in panic_exit (self=3D<value optimized out>, =
unused1=3D<value optimized out>,
>>>>     unused2=3D<value optimized out>) at arch/um/kernel/um_arch.c:233=

>>>> #3  0x0000000060045996 in notifier_call_chain (nl=3D<value optimized=
 out>, val=3D0, v=3D0x602ffb40,
>>>> nr_to_call=3D-2, nr_calls=3D<value optimized out>) at kernel/notifie=
r.c:93
>>>> #4  0x00000000600459e4 in __atomic_notifier_call_chain (nh=3D<value =
optimized out>,
>>>> val=3D<value optimized out>, v=3D<value optimized out>) at kernel/no=
tifier.c:182
>>>> #5  atomic_notifier_call_chain (nh=3D<value optimized out>, val=3D<v=
alue optimized out>,
>>>> v=3D<value optimized out>) at kernel/notifier.c:191
>>>> #6  0x00000000601a56d0 in panic (fmt=3D0x601f3050 "Kernel mode fault=
 at addr 0x%lx, ip 0x%lx")
>>>> at kernel/panic.c:115
>>>> #7  0x00000000600145df in segv (fi=3D..., ip=3D1611852984, is_user=3D=
0, regs=3D0x6024fa10)
>>>> at arch/um/kernel/trap.c:201
>>>> #8  0x000000006001463e in segv_handler (sig=3D<value optimized out>,=
 regs=3D<value optimized out>)
>>>> at arch/um/kernel/trap.c:147
>>>> #9  0x00000000600211a4 in sig_handler_common (sig=3D11, sc=3D0x6024f=
be8) at arch/um/os-Linux/signal.c:49
>>>> #10 0x00000000600212ea in sig_handler (sig=3D<value optimized out>, =
sc=3D<value optimized out>)
>>>> at arch/um/os-Linux/signal.c:226
>>>> #11 0x000000006002151c in handle_signal (sig=3D<value optimized out>=
, sc=3D0x6024fbe8)
>>>>     at arch/um/os-Linux/signal.c:158
>>>> #12 0x0000000060022e9c in hard_handler (sig=3D<value optimized out>)=

>>>> at arch/um/os-Linux/sys-x86_64/signal.c:15
>>>> #13 <signal handler called>
>>>> #14 0x000000006012ecb8 in list_del (entry=3D0x807bcf00) at lib/list_=
debug.c:46
>>>> #15 0x0000000060016724 in free_winch (winch=3D0x807bcf00, free_irq_o=
k=3D0) at arch/um/drivers/line.c:731
>>>> #16 0x0000000060016ad7 in winch_interrupt (irq=3D<value optimized ou=
t>, data=3D0x807bcf00)
>>>> at arch/um/drivers/line.c:760
>>>> #17 0x0000000060055b45 in __free_irq (irq=3D10, dev_id=3D0x807bcf00)=
 at kernel/irq/manage.c:937
>>>> #18 0x0000000060055bc0 in free_irq (irq=3D10, dev_id=3D0x807bcf00) a=
t kernel/irq/manage.c:986
>>>> #19 0x0000000060016765 in free_winch (winch=3D0x807bcf00, free_irq_o=
k=3D1) at arch/um/drivers/line.c:740
>>>> #20 0x0000000060017211 in unregister_winch (tty=3D0x8072a800, filp=3D=
<value optimized out>)
>>>> at arch/um/drivers/line.c:836
>>>> #21 line_close (tty=3D0x8072a800, filp=3D<value optimized out>) at a=
rch/um/drivers/line.c:477
>>>> #22 0x00000000601335d9 in tty_release (inode=3D0x7eff4190, filp=3D0x=
7fc9abc0) at drivers/char/tty_io.c:1580
>>>> #23 0x000000006007e6a8 in __fput (file=3D0x7fc9abc0) at fs/file_tabl=
e.c:254
>>>> #24 0x000000006007e79c in fput (file=3D<value optimized out>) at fs/=
file_table.c:200
>>>> #25 0x000000006007b995 in filp_close (filp=3D0x7fc9abc0, id=3D0x7fc7=
20c0) at fs/open.c:1124
>>>> #26 0x000000006007ba4a in sys_close (fd=3D3) at fs/open.c:1153
>>>> #27 0x0000000060014c7c in handle_syscall (r=3D0x7e1ba418) at arch/um=
/kernel/skas/syscall.c:35
>>>> #28 0x0000000060023e7f in handle_trap (regs=3D0x7e1ba418) at arch/um=
/os-Linux/skas/process.c:201
>>>> #29 userspace (regs=3D0x7e1ba418) at arch/um/os-Linux/skas/process.c=
:417
>>>> #30 0x000000006001265b in fork_handler () at arch/um/kernel/process.=
c:181
>>>>
>>>>
>>>> Apparently, the winch is not in the list when the free_winch is
>>>> invoked. Kernel version 2.6.34-rc7
>>>>
>>> You might be lucky: Does the patch below make a difference? It may be=

>>> untested as it's part on my half-finished uml cleanup/review queue.
>> Hi, I'm not sure it may help, since the spurious call is from inside
>> the IRQ handler. In the worst case, the above call may cause a
>> deadlock. I suggest a better fix idea below.
>>
>> Here's the help from DEBUG_SHIRQ:
>> 	  Enable this to generate a spurious interrupt as soon as a shared
>> 	  interrupt handler is registered, and just before one is deregistere=
d.
>> 	  Drivers ought to be able to handle interrupts coming in at those
>> 	  points; some don't and need to be caught.
>>
>> The problem is that free_winch calls free_irq at the end, after
>> destroying everything, which is wrong: first you disable the
>> interrupt, then you destroy resources needed to handle it. SHIRQ is
>> catching a real bug here. In fact, the IRQ handler is noticing that it=

>> can't read from the FD (because it was just closed) and trying to free=

>> again the IRQ (which is bad). You must move the call to free_irq at
>> the beginning. There's a number of apparent "race" in UML which is
>> really solved by state machines, like this: when closing, you are in a=

>> state when other routines (like IRQs) must not wait (what you get by
>> locking), but must be disabled.
>> Actually, the cleanup seems to start at line_close which already
>> destroyed some resources, but winch_interrupt seems safe against that
>> (it tests if winch->tty is NULL). Not really maybe, because the
>> testing is not atomic (so there might be races, but it seems not so
>> likely). But moving the call to unregister_winch to the beginning of
>> line_close might be a good idea (after all, you don't really need to
>> listen for SIGWINCH when you start closing a window). The calls before=

>> line_close are from the generic kernel, so they can't be changed: if
>> they free any resources, the interrupt handler must be ready to
>> operate without them, whatever that means. But it's just calling
>> tty_fasync(on=3D0), I think to disable async notifications.
>=20
> Right, there was more broken. Besides the locking fix, this should do
> the trick by avoiding the recursive free_winch call:
>=20
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index d85fcb9..fa66eb4 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -731,8 +731,10 @@ static void free_winch(struct winch *winch, int fr=
ee_irq_ok)
> =20
>  	if (winch->pid !=3D -1)
>  		os_kill_process(winch->pid, 1);
> -	if (winch->fd !=3D -1)
> +	if (winch->fd !=3D -1) {
>  		os_close_file(winch->fd);
> +		winch->fd =3D -1;
> +	}
>  	if (winch->stack !=3D 0)
>  		free_stack(winch->stack, 0);
>  	if (free_irq_ok)
>=20
> (note: untested)

Well, thought about it again, this is the result:

------->

uml: Fix winch cleanup races

Calling free_winch from within the IRQ handler is broken for many
reasons: It can leave the IRQ line registered and it races with
parallel cleanup by unregister_winch and winch_cleanup.

Resolve this via a per-winch spinlock that protects pid and fd of the
winch structure.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/drivers/line.c |   50 ++++++++++++++++++++++++++++++++++++------=
-----
 1 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 7f8f649..4b9d177 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -723,20 +723,30 @@ struct winch {
 	int pid;
 	struct tty_struct *tty;
 	unsigned long stack;
+	spinlock_t lock;
 };
=20
-static void free_winch(struct winch *winch, int free_irq_ok)
+static void free_winch(struct winch *winch)
 {
-	list_del(&winch->list);
+	spin_lock_irq(&winch->lock);
=20
-	if (winch->pid !=3D -1)
+	if (winch->pid !=3D -1) {
 		os_kill_process(winch->pid, 1);
-	if (winch->fd !=3D -1)
+		winch->pid =3D -1;
+	}
+	if (winch->fd !=3D -1) {
 		os_close_file(winch->fd);
+		winch->fd =3D -1;
+	}
+
+	spin_unlock_irq(&winch->lock);
+
 	if (winch->stack !=3D 0)
 		free_stack(winch->stack, 0);
-	if (free_irq_ok)
-		um_free_irq(WINCH_IRQ, winch);
+
+	um_free_irq(WINCH_IRQ, winch);
+
+	list_del(&winch->list);
 	kfree(winch);
 }
=20
@@ -748,6 +758,8 @@ static irqreturn_t winch_interrupt(int irq, void *dat=
a)
 	int err;
 	char c;
=20
+	spin_lock(&winch->lock);
+
 	if (winch->fd !=3D -1) {
 		err =3D generic_read(winch->fd, &c, NULL);
 		if (err < 0) {
@@ -756,10 +768,17 @@ static irqreturn_t winch_interrupt(int irq, void *d=
ata)
 				       "read failed, errno =3D %d\n", -err);
 				printk(KERN_ERR "fd %d is losing SIGWINCH "
 				       "support\n", winch->tty_fd);
-				free_winch(winch, 0);
-				return IRQ_HANDLED;
+
+				if (winch->pid !=3D -1) {
+					os_kill_process(winch->pid, 1);
+					winch->pid =3D -1;
+				}
+				os_close_file(winch->fd);
+				winch->fd =3D -1;
+
+				goto unlock_out;
 			}
-			goto out;
+			goto reactivate_out;
 		}
 	}
 	tty =3D winch->tty;
@@ -771,9 +790,14 @@ static irqreturn_t winch_interrupt(int irq, void *da=
ta)
 			kill_pgrp(tty->pgrp, SIGWINCH, 1);
 		}
 	}
- out:
+
+reactivate_out:
 	if (winch->fd !=3D -1)
 		reactivate_fd(winch->fd, WINCH_IRQ);
+
+unlock_out:
+	spin_unlock(&winch->lock);
+
 	return IRQ_HANDLED;
 }
=20
@@ -795,6 +819,8 @@ void register_winch_irq(int fd, int tty_fd, int pid, =
struct tty_struct *tty,
 				   .tty 	=3D tty,
 				   .stack	=3D stack });
=20
+	spin_lock_init(&winch->lock);
+
 	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			   IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			   "winch", winch) < 0) {
@@ -828,7 +854,7 @@ static void unregister_winch(struct tty_struct *tty)
 	list_for_each(ele, &winch_handlers) {
 		winch =3D list_entry(ele, struct winch, list);
 		if (winch->tty =3D=3D tty) {
-			free_winch(winch, 1);
+			free_winch(winch);
 			break;
 		}
 	}
@@ -844,7 +870,7 @@ static void winch_cleanup(void)
=20
 	list_for_each_safe(ele, next, &winch_handlers) {
 		winch =3D list_entry(ele, struct winch, list);
-		free_winch(winch, 1);
+		free_winch(winch);
 	}
=20
 	spin_unlock(&winch_handler_lock);



--------------enig6F4994E58DF36B860D9DD775
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvv/BcACgkQitSsb3rl5xR1IACgrPJtgIobSTuLSn07cENgFWdf
0mgAn2DoICTlt2jGBPpVGNTsxwhnkoC2
=wRkk
-----END PGP SIGNATURE-----

--------------enig6F4994E58DF36B860D9DD775--


--===============6181383870911473063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--===============6181383870911473063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6181383870911473063==--


