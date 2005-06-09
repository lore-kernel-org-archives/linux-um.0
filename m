Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgOqU-0006Kf-9S	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 08:21:26 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DgOqQ-0000AO-3O	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 08:21:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
References: <1118280325.10107.124.camel@localhost>
In-Reply-To: <1118280325.10107.124.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart372782041.apLsc9pp30";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506091724.50908.blaisorblade@yahoo.it>
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
Date: Thu, 9 Jun 2005 17:24:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

--nextPart372782041.apLsc9pp30
Content-Type: multipart/mixed;
  boundary="Boundary-01=_68FqCPr/8LzHWDd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_68FqCPr/8LzHWDd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 June 2005 03:25, antoine wrote:
> I noticed a new set of patches were out, so I gave it usual bashing.
> Maybe this will be useful to someone else:
> 1) as before fp-state does not apply.
> 2) os-main gave me a reject on arch/um/kernel/main.c
> fixed by simply removing the file.
>
> Built ok (no tweaks needed this time!).
> Runs ok, but it is still loosing memory fast.
>
> Then I tried adding some more experimental features...
> Attached is a stacktrace I encountered (pcap related):
It happens only when inside the chroot, right?
> Seems like the pcap patch
? You applied it on your own, or have I merged it somewhere without noticin=
g?=20
See my signature about that.
> is causing some problems when running in a=20
> chroot which does not have the libraries required by pcap (nss?)
Yes, it's related to the compilation-time warning somebody (either you or N=
ix)=20
got...
> Some processes were still running when I got back to the shell.
Well, it was segfaulting on exit, so it's a bit normal. Well, it shouldn't=
=20
segfault in that case but simply handle the error gracefully.
> Btw, how do I figure out which libs I need to copy to the chroot?
Hmm, look at /etc/nsswitch.conf (to copy inside) and /lib/libnss_* (to copy=
=20
too, you can limit what you copy by looking at the configuration).
> But apart from that slight problem, when running outside the chroot it
> works exactly as expected.

> I vote for including it in the next release=20
> with appropriate warnings about runtime libraries issues.

> Now, if someone could have a look at hppfs I could resurect my
> honeypots.
I've not the time, however test the attached patches. The first one fixes t=
he=20
basical bugs; the second one could be needed to fix a fd leak... but I don'=
t=20
think it's needed at all, so test with only the first and let me know if th=
e=20
2nd is needed, or if there are any problems (in that case, a ready-to-use=20
hppfs configuration + explaination would be happily accepted, I've really=20
little time now).

I had marked it as CONFIG_BROKEN because it was giving some bad compilation=
=20
warnings, which showed its almost non-existant usage (because those warning=
s=20
showed that it would not work *absolutely*).

Actually I'm now seeing that they were caused by this patch:

http://linux.bkbits.net:8080/linux-2.5/cset%40412b86aaOElFX7HLh6UrLu-E1hQJS=
A?nav=3Dindex.html|
src/.|src/fs|src/fs/hppfs|related/fs/hppfs/hppfs_kern.c

which forgots some cleanups... so I guess it worked before and will work wi=
th=20
this mini-patch.

  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      fs/hppfs/hppfs_kern.o
fs/hppfs/hppfs_kern.c: In function `hppfs_open':
fs/hppfs/hppfs_kern.c:495: warning: passing arg 3 of `hppfs_get_data' from=
=20
incompatible pointer type
fs/hppfs/hppfs_kern.c: In function `hppfs_llseek':
fs/hppfs/hppfs_kern.c:546: warning: initialization from incompatible pointe=
r=20
type
fs/hppfs/hppfs_kern.c: In function `hppfs_readdir':
fs/hppfs/hppfs_kern.c:589: warning: initialization from incompatible pointe=
r=20
type

> Also, is anyone interested in some SELinux policies for UML?
I guess yes, it would be very useful.... but against which distro policy ar=
e=20
they prepared? Fedora, I guess, correct?

IIRC, in fact, policies "link" together, for instance your one below refers=
 to=20
tmp_t...

Also, I guess this policy needs some security label settings on files, righ=
t?

Would you put it on the Wiki, please? Thanks

> They need a=20
> little bit of tidying up but seem to work. See below (I extracted the
> generic part - unfortunately some parts are specific to my setup).

Wow! Is this the "assembler-like language" that lwn.net mentioned?

> Antoine

> type um_t, domain, privowner;
> type um_kernel_t, domain, privowner;

> type um_admin_t, file_type, sysadmfile;
> type um_exec_t, file_type, exec_type;
> type um_kernel_exec_t, file_type, sysadmfile, exec_type;
> type um_home_t, file_type;
> type um_fs_t, file_type;
This should be restricted somewhere to UML root_fs's, right (or maybe that =
is=20
done with Security labels...)?
> type um_tmp_t, file_type, tmpfile;
"tmpfile" is already assigned to files in /tmp...
> type um_proc_t, file_type;
> type um_tundev_t, device_type, dev_fs;

> file_type_auto_trans(um_t, tmp_t, um_tmp_t)
> file_type_auto_trans(um_kernel_t, tmp_t, um_tmp_t)

> domain_auto_trans(initrc_t, um_exec_t, um_t)
> domain_auto_trans(sysadm_t, um_exec_t, um_t)
> domain_auto_trans(um_t, um_kernel_exec_t, um_kernel_t)

> # network
> allow um_kernel_t netif_t:netif { tcp_recv tcp_send };
> allow um_kernel_t node_t:node { tcp_recv tcp_send };
> allow um_kernel_t port_t:socket { recv_msg send_msg };
> # sockets
> allow um_kernel_t self:packet_socket create;
> allow um_kernel_t self:unix_dgram_socket { bind create ioctl };
> allow um_kernel_t self:unix_stream_socket { create ioctl read write };
> # process
> allow um_kernel_t self:process { execmem fork ptrace sigchld sigkill sign=
al
> sigstop }; # devices
> allow um_kernel_t device_t:dir search;
> allow um_kernel_t null_device_t:chr_file { ioctl read write };
> allow um_kernel_t um_tundev_t:chr_file { ioctl read write };
> allow um_kernel_t random_device_t:chr_file read;

> # files
> allow um_kernel_t um_tmp_t:file execute;
Allow execution of temporary files? Guess this is needed to avoid /tmp bein=
g=20
like noexec, but does this allow to exec a random process on the host being=
=20
put inside tmp?
> allow um_kernel_t um_fs_t:file { getattr lock read write };
> allow um_kernel_t um_fs_t:lnk_file read;
> # proc
> allow um_kernel_t um_proc_t:file read;
> allow um_kernel_t um_proc_t:dir search;
> # home
> allow um_kernel_t um_home_t:dir { add_name create getattr read remove_name
> rmdir write search}; allow um_kernel_t um_home_t:file { create getattr lo=
ck
> read unlink write }; allow um_kernel_t um_home_t:sock_file { create unlink
> };
> # all other dirs:
> allow um_kernel_t um_admin_t:dir search;

=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-01=_68FqCPr/8LzHWDd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-hppfs-fd-leak.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uml-hppfs-fd-leak.patch"


Don't think it's needed...
We also delete hppfs_delete_inode since it just implements the default
behaviour.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
=2D--

 clean-linux-2.6.11-paolo/fs/hppfs/hppfs_kern.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs-fd-leak fs/hppfs/hppfs_kern.c
=2D-- clean-linux-2.6.11/fs/hppfs/hppfs_kern.c~uml-hppfs-fd-leak	2005-06-09=
 16:54:56.000000000 +0200
+++ clean-linux-2.6.11-paolo/fs/hppfs/hppfs_kern.c	2005-06-09 17:01:09.0000=
00000 +0200
@@ -640,11 +640,6 @@ static struct inode *hppfs_alloc_inode(s
 	return(&hi->vfs_inode);
 }
=20
=2Dvoid hppfs_delete_inode(struct inode *ino)
=2D{
=2D	clear_inode(ino);
=2D}
=2D
 static void hppfs_destroy_inode(struct inode *inode)
 {
 	kfree(HPPFS_I(inode));
@@ -652,9 +647,9 @@ static void hppfs_destroy_inode(struct i
=20
 static struct super_operations hppfs_sbops =3D {
 	.alloc_inode	=3D hppfs_alloc_inode,
+	.drop_inode	=3D generic_delete_inode,
 	.destroy_inode	=3D hppfs_destroy_inode,
 	.read_inode	=3D hppfs_read_inode,
=2D	.delete_inode	=3D hppfs_delete_inode,
 	.statfs		=3D hppfs_statfs,
 };
=20
_

--Boundary-01=_68FqCPr/8LzHWDd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-hppfs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uml-hppfs.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
=2D--

 clean-linux-2.6.11-paolo/arch/um/Kconfig       |    6 +++---
 clean-linux-2.6.11-paolo/fs/hppfs/hppfs_kern.c |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/um/Kconfig~uml-hppfs arch/um/Kconfig
=2D-- clean-linux-2.6.11/arch/um/Kconfig~uml-hppfs	2005-06-09 16:37:42.0000=
00000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/Kconfig	2005-06-09 16:38:22.000000000 =
+0200
@@ -122,7 +122,6 @@ config HOSTFS
=20
 config HPPFS
 	tristate "HoneyPot ProcFS (EXPERIMENTAL)"
=2D	depends on BROKEN
 	help
 	hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
 	entries to be overridden, removed, or fabricated from the host.
@@ -135,8 +134,9 @@ config HPPFS
 	You only need this if you are setting up a UML honeypot.  Otherwise,
 	it is safe to say 'N' here.
=20
=2D	If you are actively using it, please ask for it to be fixed. In this
=2D	moment, it does not work on 2.6 (it works somehow on 2.4).
+	If you are actively using it, please report any problems, since it's
+	getting fixed. In this moment, it does not work on 2.6 (it works somehow
+	on 2.4).
=20
 config MCONSOLE
 	bool "Management console"
diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs fs/hppfs/hppfs_kern.c
=2D-- clean-linux-2.6.11/fs/hppfs/hppfs_kern.c~uml-hppfs	2005-06-09 16:37:4=
2.000000000 +0200
+++ clean-linux-2.6.11-paolo/fs/hppfs/hppfs_kern.c	2005-06-09 16:54:20.0000=
00000 +0200
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -491,7 +492,7 @@ static int hppfs_open(struct inode *inod
 		fd =3D open_host_sock(host_file, &filter);
 		if(fd > 0){
 			data->contents =3D hppfs_get_data(fd, filter,
=2D							&data->proc_file,
+							data->proc_file,
 							file, &data->len);
 			if(!IS_ERR(data->contents))
 				data->host_fd =3D fd;
@@ -543,7 +544,7 @@ static int hppfs_dir_open(struct inode *
 static loff_t hppfs_llseek(struct file *file, loff_t off, int where)
 {
 	struct hppfs_private *data =3D file->private_data;
=2D	struct file *proc_file =3D &data->proc_file;
+	struct file *proc_file =3D data->proc_file;
 	loff_t (*llseek)(struct file *, loff_t, int);
 	loff_t ret;
=20
@@ -586,7 +587,7 @@ static int hppfs_filldir(void *d, const=20
 static int hppfs_readdir(struct file *file, void *ent, filldir_t filldir)
 {
 	struct hppfs_private *data =3D file->private_data;
=2D	struct file *proc_file =3D &data->proc_file;
+	struct file *proc_file =3D data->proc_file;
 	int (*readdir)(struct file *, void *, filldir_t);
 	struct hppfs_dirent dirent =3D ((struct hppfs_dirent)
 		                      { .vfs_dirent  	=3D ent,
_

--Boundary-01=_68FqCPr/8LzHWDd--

--nextPart372782041.apLsc9pp30
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqF9CqH9OHC+5NscRArWaAJ4+9k68DX9tbdYnnPHJKPgvM5LtOACfdwkQ
ELxEJCzDT0gdpGOqpsco7xM=
=QI78
-----END PGP SIGNATURE-----

--nextPart372782041.apLsc9pp30--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
