Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8m19-0002Gd-Hj	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 14:45:43 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E8m17-0008Hu-6K
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 14:45:43 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk>
References: <20050826145749.03BFE24D661@zion.home.lan>
	<20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
	<200508262204.43683.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508262204.43683.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 1/2] Fixup symlink function pointers for hppfs
	[for 2.6.13]
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
Date: Fri, 26 Aug 2005 22:48:39 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 26, 2005 at 10:04:43PM +0200, Blaisorblade wrote:
> And beyond that what? I cannot even think what's the rest *. And "obvious" 
> doesn't hold with me.

vfsmount *mnt = do_kern_mount("proc", 0, "proc", NULL);

done at init time,

mntput(mnt);

at exit

and mntget(mnt) instead of your NULL in dentry_open().

Do not mess with get_fs_type() anywhere - the above will give you access
to procfs superblock just fine.

The real issue is what you are doing with procfs dentries there.  You do
*not* call ->d_revalidate().  And you do not evict these suckers when
procfs dentry goes away.  E.g. when process dies...

What the hell is going on with iget() calls, BTW?  Especially since all
of them get the same inumber...  Looks completely broken.

Why does is_pid() bother with checks for fs dentry belongs to?

copy_from_user() return value needs to be checked.

Use of file->f_pos is blatantly racy; don't do that.

->permission() is missing on hppfs; since procfs is not using generic one,
we have a problem.

read_proc() is a guaranteed fsckup if hppfs_open() is called with KERNEL_DS.

That's from the quick look through the current code...


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
