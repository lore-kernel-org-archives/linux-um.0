Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba1cy-00021R-9Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 17:16:36 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ba1cx-0007QO-KZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 17:16:35 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [BUG] host fd leak when using hostfs
References: <c9oc52$a3$1@sea.gmane.org>
In-Reply-To: <c9oc52$a3$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LqezAIRHCOno2rk"
Message-Id: <200406142012.27496.blaisorblade_spam@yahoo.it>
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
Date: Mon, 14 Jun 2004 20:12:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_LqezAIRHCOno2rk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 01:27, venerd=EC 4 giugno 2004, Sven K=F6hler ha scritto:
> hi,
>
> i mounted the directory /usr/portage from my host into my UML-machine
> (also to /usr/portage). The directory is mounted read-only. After that,
> i did "emerge -upD world" which must have accessed many many files.
> emerge crashed with the exception "too many open files" and indeed, the
> processes inside the UML cannot open any file anymore.
>
> If i do an "lsof" on the host, i see that the kernel-process has still
> opened many many files from /usr/portage - too many files ;-)
>
> So this should be bug in hostfs, so that hostfs doesn't close files on
> the host if they are closed inside the UML. Is there a fix for that
> already?

Try the attached patch (for 2.6 only!), but please be very careful... there=
=20
could be subtle pitfall in the VFS making it have other problems. However=20
I've well understood what is the difference between 2.4 and 2.6 which makes=
=20
the difference.

What is your UML version? I got the same thing with 2.6.4 patch adapted ont=
o=20
2.6.6 (the 2.6.6-02 distributed on my page).

I was expecting it to happen only onto late 2.4 kernels, due to the=20
restructuring of hostfs. Instead I saw it onto a 2.6 kernel. I just tested=
=20
that 2.4.23-2 UML kernel, the last one I have at hand, works.

The fd closing is done here:

static struct super_operations hostfs_sbops =3D {
        .alloc_inode    =3D hostfs_alloc_inode,
        .destroy_inode  =3D hostfs_destroy_inode, //this closes the fd.
        .read_inode     =3D hostfs_read_inode,
        .statfs         =3D hostfs_statfs,
};

But .destroy_inode was meant by the VFS to be paired with .alloc_inode, i.e=
=2E=20
think about memory deallocation, basically. I've been able to see that is i=
n,=20
indeed, called when UML is closed regularly (sysrq h(alt), I mean).

Without this patch applied and the root_fs_tomsbrt, I did this test:

for i in `find /mnt/usr/bin`; do cat $i >/dev/null; done

with hostfs mounted on /mnt. I got this:

cat: error 24
init_new_context_skas - new_mm failed, errno =3D -24

(i.e. EMFILE, too many open files.)

And 1023 open file descriptors in /proc/UMLPID/fd (I have ulimit -n (max fd=
's)=20
1024).

While with the attached patch, I repeated the test onto my slack9.0 rootFs =
and=20
it worked very well!

This patch forces the call to delete_inode, i.e. inode with no associated f=
ds=20
are not cached, by setting drop_inode =3D generic_delete_inode (see=20
Documentation/filesystems/vfs.txt about setting of drop_inode, and about=20
force_delete(), the approach which was used by 2.4 to do the same thing): t=
he=20
relevant kernel code is the "iput()" function and sons, which can be called=
=20
by sys_close if the relevant reference counts go to 0.

Normally it uses generic_drop_inode() -> generic_forget_inode():=20
(inode->i_nlink is the number of hard links to that inode):

       if (!inode->i_nlink)
                generic_delete_inode(inode);
        else
                generic_forget_inode(inode);

, which can actually skip (I don't understand when) to call .delete_inode()=
=20
(which is the function which is actually called, check with "dmesg" inside=
=20
UML). On 2.4 this was done, just in a different way (through .put_inode =3D=
=20
force_delete(), which is mentioned in that doc). force_delete() had problem=
s=20
and went away; nobody put something to replace it.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729










--Boundary-00=_LqezAIRHCOno2rk
Content-Type: text/x-diff; charset="iso-8859-1";
	name="HostFs-2.6-fd_leak-working.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="HostFs-2.6-fd_leak-working.patch"

--- ./fs/hostfs/hostfs_kern.c.fix	2004-05-12 15:52:58.000000000 +0200
+++ ./fs/hostfs/hostfs_kern.c	2004-06-12 16:42:34.000000000 +0200
@@ -284,13 +284,25 @@
 	return(&hi->vfs_inode);
 }
 
+static void hostfs_delete_inode(struct inode *inode)
+{
+	if(HOSTFS_I(inode)->fd != -1) {
+		close_file(&HOSTFS_I(inode)->fd);
+		printk("Closing host fd in .delete_inode\n");
+		HOSTFS_I(inode)->fd = -1;
+	}
+	clear_inode(inode);
+}
+
 static void hostfs_destroy_inode(struct inode *inode)
 {
 	if(HOSTFS_I(inode)->host_filename) 
 		kfree(HOSTFS_I(inode)->host_filename);
 
-	if(HOSTFS_I(inode)->fd != -1) 
+	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
+		printk("Closing host fd in .destroy_inode\n");
+	}
 
 	kfree(HOSTFS_I(inode));
 }
@@ -302,6 +314,8 @@
 
 static struct super_operations hostfs_sbops = { 
 	.alloc_inode	= hostfs_alloc_inode,
+	.drop_inode	= generic_delete_inode,
+	.delete_inode   = hostfs_delete_inode,
 	.destroy_inode	= hostfs_destroy_inode,
 	.read_inode	= hostfs_read_inode,
 	.statfs		= hostfs_statfs,

--Boundary-00=_LqezAIRHCOno2rk--




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
