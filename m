Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpHA-0002Y1-Bu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:52 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DDpH6-0007tQ-Gp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
In-Reply-To: <200503201417.59739.rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u+GQCEiGg+0SBhl"
Message-Id: <200503222019.10709.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 20:19:10 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

--Boundary-00=_u+GQCEiGg+0SBhl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 20 March 2005 20:17, Rob Landley wrote:
> If I open a device like /dev/loop0 or /dev/console from a hostfs mount,
> I'll get the UML device, not the host device, right?
Obviously right.
> So why are the permissions checks on hostfs devices done relative to the
> _host_ user?
What is the result from ls -l <that device>? Does it look readable for root?

I'm not sure, however you could try the attached patch (there is also some 
whitespace cleanup, sorry), and if that does not work, then again I've not 
understood your scenario and you might answer the other questions in the 
email (I've first wrote the generic questions, then understood what is 
probably going on).

Ok, I'm now seeing that UML uses access() (inside access_file()) to check 
permissions.

See hostfs_permission -> access_file -> access. hostfs_permission (not 
access_file) should skip the "access_file" call in case its type is 
OS_TYPE_CHARDEV / OS_TYPE_BLOCKDEV / OS_TYPE_FIFO / OS_TYPE_SOCK.

Look at init_inode() about how to see the file's type, but even better look at 
the cached information, i.e. inode->i_mode and the S_* access macro (look at 
init_special_inode about this).

> If /dev/console doesn't belong to the current user, the 
> system can't even open the initial console, despite the fact the output
> does NOT go to TTY1 if I'm running it an xterm.
/dev/console and /dev/tty1 are entirely different. If you open a getty 
on /dev/console, Ctrl-C won't work there.

1) Which version of UML are you using? If you are using the incrementals, they 
contain the hostfs rewrite which has all these problems... (with that, you 
can't even do a stat on a device you don't own, wrongly).
2) Which command line? I recall you run with hostfs as root fs, but I'm not 
really sure of this.
3) When you have hostfs as your root fs, there is some special code to handle 
this which may be reconsidered. I.e., when you have a file on the host owned 
by the user running UML, that is seen as owned by root inside UML. Actually 
it's not related to your current problem, but if ever you notice any bugs, 
please let us know.

> Similarly, if /dev/loop0 is chmod 600 and I run UML as a normal user and
> try to do a mount -o loop, it says it can't find a loop device.

> Yet if I 
> run UML as root, it doesn't allocate one of the parent's loop devices, UML
> does it internally...

> I'm told there's a major rewrite of hostfs underway.  Is it worth me trying
> to patch the existing hostfs code, or should I go try to track down the new
> stuff and try it out?

Well, the "rewrite" (currently in the incrementals) is waiting for more urgent 
work since a lot of time (it was started by the 2.4.24-2um release), and it 
has a lot of problems right now. We are going to keep the old hostfs 
available for a lot...

So you'd better go debugging the current code, IMHO (and even simply testing 
the patch); we will subsequently port those changes to the new code.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_u+GQCEiGg+0SBhl
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-fix-hostfs-special-perm-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-hostfs-special-perm-handling.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Rob Landley <rob@landley.net>
When opening devices nodes on hostfs, it does not make sense to call
access(), since we are not going to open the file on the host.

If the device node is owned by root, the root user in UML should succeed in
opening it, even if UML won't be able to open the file.

As reported by Rob Landley, UML currently does not follow this, so here's an
(untested) fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling	2005-03-22 20:10:07.000000000 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-03-22 20:12:45.000000000 +0100
@@ -806,15 +806,21 @@ int hostfs_permission(struct inode *ino,
 	char *name;
 	int r = 0, w = 0, x = 0, err;
 
-	if(desired & MAY_READ) r = 1;
-	if(desired & MAY_WRITE) w = 1;
-	if(desired & MAY_EXEC) x = 1;
+	if (desired & MAY_READ) r = 1;
+	if (desired & MAY_WRITE) w = 1;
+	if (desired & MAY_EXEC) x = 1;
 	name = inode_name(ino, 0);
-	if(name == NULL) return(-ENOMEM);
-	err = access_file(name, r, w, x);
+	if (name == NULL) return(-ENOMEM);
+
+	if (S_ISCHR(ino->i_mode) || S_ISBLK(ino->i_mode) ||
+			S_ISFIFO(ino->i_mode) || S_ISSOCK(ino->i_mode))
+		err = 0;
+	else
+		err = access_file(name, r, w, x);
 	kfree(name);
-	if(!err) err = generic_permission(ino, desired, NULL);
-	return(err);
+	if(!err)
+		err = generic_permission(ino, desired, NULL);
+	return err;
 }
 
 int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
_

--Boundary-00=_u+GQCEiGg+0SBhl--




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
