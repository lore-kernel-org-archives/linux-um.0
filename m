Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqV6Y-0005rN-DN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:17:22 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JqV6F-0003Ig-T8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:17:07 -0700
Date: Mon, 28 Apr 2008 11:16:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080428151604.GB7334@c2.user-mode-linux.org>
References: <20080425175608.GA11182@c2.user-mode-linux.org>
	<20080426.163132.194697674.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080426.163132.194697674.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH 6/19] UML - hppfs fixes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 26, 2008 at 04:31:32PM +0800, WANG Cong wrote:
> > -		copy_to_user(buf, &data->contents[off], count);
> > -		*ppos += count;
> > +		rem = copy_to_user(buf, &data->contents[off], count);
> > +		*ppos += count - rem;
> > +		if (rem > 0)
> > +			return -EFAULT;
> 
> 
> Could you please explain why check 'rem' after using it here?

Because I'm an idiot.  Will fix.

> >  static int hppfs_open(struct inode *inode, struct file *file)
> >  {
> >  	struct hppfs_private *data;
> > -	struct dentry *proc_dentry;
> >  	struct vfsmount *proc_mnt;
> > +	struct dentry *proc_dentry;
> 
> And what does this kind of change mean?

It means I culdn't make up my mind.  I first got rid of the dentrys,
then put them back, but in a different place.

     	      	    Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
