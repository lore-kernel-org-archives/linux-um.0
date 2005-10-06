Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENb5V-0005If-4P	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:07:29 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ENb5U-0005Ks-Gy
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:07:29 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 11/12] HPPFS: add dentry_ops->d_revalidate
References: <20050918141006.31461.23599.stgit@zion.home.lan>
	<20050921034416.GW7992@ftp.linux.org.uk>
In-Reply-To: <20050921034416.GW7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510062007.32365.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 6 Oct 2005 20:07:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>

On Wednesday 21 September 2005 05:44, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:10:07PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > +static int hppfs_d_revalidate(struct dentry * dentry, struct nameidata *
> > nd) +{
> > +	int (*d_revalidate)(struct dentry *, struct nameidata *);
> > +	struct dentry *proc_dentry;
> > +
> > +	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
> > +	if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate)
> > +		d_revalidate = proc_dentry->d_op->d_revalidate;
> > +	else
> > +		return 1; /* "Still valid" code */
> > +
> > +	return (*d_revalidate)(proc_dentry, nd);
> > +}
>
> Ahem...  Guess what that will do with negative dentry?
Was missing the very first line (dentry->d_inode). I just saw you already 
suggested returning 0 for them, which I'm gonna do anyway.

But, actually, procfs returns ENOENT (or EINVAL) rather than creating negative 
dentries (at least, I've examined most of procfs lookup funcs, hope I haven't 
missed any)...

And actually, after realizing the procfs trick, I see that we, too should miss 
negative dentries, because on the "uncached" path when we get an error like 
that we propagate that, and on the "cached" one obviously we can't find them 
in dcache.
Right?

I'll do the check for negative dentries anyway because depending on procfs 
details is not on my TODO list.

Yes, we could, but given the unmaintainance level of HPPFS, nobody would ever 
fix it when needed, and that's not recommended.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
