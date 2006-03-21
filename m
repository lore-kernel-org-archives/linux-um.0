Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20060321142624.GA18505@SteX>
Reply-To: stefano.melchior@openlabs.it
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Subject: [uml-devel] memory option crashes the uml bootstrap phase
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
Date: Tue, 21 Mar 2006 15:26:25 +0100
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear all,
I may be wrong but I encountered a strange problem:

- I downloaded a root_fs from http://uml.nagafix.co.uk/ (debian)
- I user my own user-mode-linux pkg for debian (upcoming on debian
  unstable);
- I launched the following command:

ste$ linux ubd0=3DDebian-3.1-x86-root_fs con0=3Dfd:0 con=3Dpts eth0=3Dtunta=
p,,,10.0.1.99=20

and everything worked fine.

- while I added the mem=3D256M option at the command line, I obtained the
  following error:

Linux version 2.6.15 (root@landini) (gcc version 4.0.3 20060212 (prerelease=
) (Debian 4.0.2-9)) #2 Sat Feb 18 08:01:20 CET 2006
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:1
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: ubd0=3DDebian-3.1-x86-root_fs con0=3Dfd:0 con=3Dpts et=
h0=3Dtuntap,,,10.0.1.99 root=3D98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28408k available
Calibrating delay loop... 814.28 BogoMIPS (lpj=3D4071424)
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno
2)
Using 2.6 host AIO
[...]
VFS: Mounted root (ext3 filesystem) readonly.
BUG: soft lockup detected on CPU#0!

EIP: 0073:[<a01c5f81>] CPU: 0 Not tainted ESP: 007b:b7fd0fb8 EFLAGS:
00000246
    Not tainted
EAX: 00000000 EBX: 00005338 ECX: 00000013 EDX: 00005338
ESI: 00005334 EDI: 00000000 EBP: b7fd0fc4 DS: 007b ES: 007b
a03c7298:  [<a002c863>] show_regs+0x1a7/0x1b2
a03c72c8:  [<a004a9a2>] softlockup_tick+0x46/0x4b
a03c72dc:  [<a0039f99>] do_timer+0xa4/0xaa
a03c72ec:  [<a0017519>] um_timer+0xc/0x39
a03c72fc:  [<a004aa9b>] handle_IRQ_event+0x2a/0x5e
a03c7324:  [<a004ab27>] __do_IRQ+0x58/0x99
a03c733c:  [<a001396b>] do_IRQ+0x22/0x2e
a03c7348:  [<a00174ac>] timer_irq+0xff/0x12d
a03c736c:  [<a0017750>] timer_handler+0x64/0x6a
a03c7380:  [<a001ca96>] sig_handler_common_skas+0xa6/0xc1
a03c73a8:  [<a00279ae>] alarm_handler+0x3b/0x51
a03c73bc:  [<ffffe420>] _etext+0x5fde6a92/0x0
a03c76bc:  [<a0017e96>] flush_tlb_kernel_vm+0x24/0x28
a03c76cc:  [<a001815e>] segv+0x41/0x22c
a03c776c:  [<a0018611>] segv_handler+0xba/0xc5
a03c7794:  [<a001ca96>] sig_handler_common_skas+0xa6/0xc1
a03c77bc:  [<a002796f>] sig_handler+0x23/0x27
a03c77cc:  [<ffffe420>] _etext+0x5fde6a92/0x0
a03c7aec:  [<a00892c1>] load_elf_binary+0x8d1/0xb7e
a03c7b94:  [<a006d293>] search_binary_handler+0x5d/0x190
a03c7bb8:  [<a006d523>] do_execve+0x15d/0x1ec
a03c7bdc:  [<a0013686>] execve1+0x28/0x52
a03c7c00:  [<a00136c3>] um_execve+0x13/0x3f
a03c7c1c:  [<a001315e>] run_init_process+0x34/0x4f
a03c7c3c:  [<a0013262>] init+0xe9/0x113
a03c7c4c:  [<a002788c>] run_kernel_thread+0x2b/0x33
a03c7cf8:  [<a001c3d5>] new_thread_handler+0x81/0xab
a03c7d1c:  [<ffffe420>] _etext+0x5fde6a92/0x0

Any suggestion?

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRCANEIlnkxrVLfgpAQK/BQQAwmHXDhqK5tjYf3Xo3fmLSsi9ietE/3sh
WZwG0KKUt2snQOKoRXL1AzaRIu1zeeN+R3rw3vSesnX1YBgHord8nu6OktFKa/gY
DMIzrj/5CkC1eGI+5xUvhriZKsKPuoBzNAIHt5FPIh0r2eyJmQqjIcJm4ERLdbyo
zBOh16c+ZSM=
=42kZ
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
