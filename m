Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7ZS-0000Zp-63	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:35:46 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EI7ZN-00080N-0N
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:35:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 12/12] HPPFS: fix nameidata handling
References: <20050918141009.31461.43507.stgit@zion.home.lan>
	<20050921035455.GY7992@ftp.linux.org.uk>
In-Reply-To: <20050921035455.GY7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211834.12345.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 18:34:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@ftp.linux.org.uk>, Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On Wednesday 21 September 2005 05:54, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:10:09PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > In follow_link, we call the underlying method with the same nameidata we
> > got - it will then call path_release() and then dput()/mntput() on hppfs
> > dentries / vfsmount rather than his own, which could be problematic (I'm
> > not really sure, however).

> Don't bother with that, procfs doesn't and will not care anyway.  It _is_
> legal to pass NULL as nd,
Where? At least not in proc_follow_link, I don't know for the rest. 

I'm now seeing lookup_one_len doing exactly that. But still, could these 
conventions be documented, as they're surely untrivial to guess?

> so you've actually introduced breakage here. 
> Just pass NULL and be done with that.

> > @@ -213,11 +240,20 @@ static struct dentry *hppfs_lookup(struc
> >  	} else {
> >  		up(&parent->d_inode->i_sem);
> >  		if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate) {
> > -			if (!proc_dentry->d_op->d_revalidate(proc_dentry, NULL) &&
> > +			sav_dentry = nd->dentry;
> > +			sav_mnt = nd->mnt;
> > +
> > +			nd->dentry = dget(proc_dentry);
> > +			nd->mnt = mntget(proc_submnt);
> > +			if (!proc_dentry->d_op->d_revalidate(proc_dentry, nd) &&
> >  					!d_invalidate(proc_dentry)) {
> >  				dput(proc_dentry);
> >  				proc_dentry = ERR_PTR(-ENOENT);
> >  			}
> > +			path_release(nd);
> > +
> > +			nd->dentry = sav_dentry;
> > +			nd->mnt = sav_mnt;
> >  		}
> >  	}

> Shouldn't be there at all (use lookup_one_len() instead of open-coding it)


> >  static struct inode_operations hppfs_file_iops = {
> > @@ -794,6 +846,9 @@ static int hppfs_readlink(struct dentry
> >
> >  static void* hppfs_follow_link(struct dentry *dentry, struct nameidata
> > *nd) {
> > +	struct dentry *sav_dentry;
> > +	struct vfsmount *sav_mnt;
> > +
[...]
> And this is absolutely bogus.  The whole point of ->follow_link() is to
> move where your nameidata points to.  So no, you do _not_ want to flip
> nameidata, you do not want to drop it and you certainly do not want
> to flip it back.  Just call the underlying one.
But wouldn't the callee expect that nd->dentry is the same thing which I pass?

Yes, nameidata has other fields too, but is ->dentry meant to be unused here?
Not surely.

And especially, how would proc_pid_follow_link()'s path_release() call handle 
that?

I've been suspicious that, indeed, recursive lookup holds a ref on each 
pathname component dentry, and that proc, in that case, knows it can do 
without.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
