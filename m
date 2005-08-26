Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8kVU-0006sb-CT	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:08:56 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8kVQ-0000CU-Oo
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:08:56 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050826145749.03BFE24D661@zion.home.lan>
	<20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508262204.43683.blaisorblade@yahoo.it>
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
Date: Fri, 26 Aug 2005 22:04:43 +0200
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Friday 26 August 2005 21:03, Al Viro wrote:
> On Fri, Aug 26, 2005 at 04:57:44PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > Update hppfs for the symlink functions prototype change.
> > Should be trivial, but please verify it's correct.

> > Yes, I know the code I leave there is still _bogus_, see next patch for
> > this.

About what it's doing, hppfs (HoneyPot Proc FS) is a wrapper for procfs, which 
must be able to hide part of the content for avoid an hacker inside UML 
realize he's hacking a virtual machine, and it's normally mounted on /proc, 
if used.

> Assuming that the next patch was "hppfs: fix symlink error path",
Yes.
> you've still left BS in there -
BullShit? Thanks for improving my acronym dictionary!
> >  	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);

> is obviously wrong; at the very least you need vfsmount in there.
And beyond that what? I cannot even think what's the rest *. And "obvious" 
doesn't hold with me.

I'm _not_ a VFS hacker, I don't go beyond Documentation/filesystems/vfs.txt, 
so I'd better leave fixing that to you.

At least what you don't mention. I'll fix vfsmount in these days (if you want 
to do it yourself, I've put together needed info below).

I had to check dentry_open prototype to realize you're referring to the NULL 
there and not to dget.

And the dentries you see are all descendants of the root one, taken in 
hppfs_fill_super() from 

       err = init_inode(root_inode, proc_sb->s_root);

I guess the current hack could be replaced with reading 
fs/proc/inode.c:proc_mnt... I wouldn't pass proc_mnt directly because we 
don't know we took _that_ mount inside hppfs_fill_super(), but I like 
replacing

list_entry(get_fs_type("proc")->fs_supers.next,...) 

with proc_mnt->mnt_sb (assuming it's always filled in - IIRC I already checked 
the initialization order).

* I've verified that there's no missing dput() in failure case as that's 
handled by dentry_open().
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
