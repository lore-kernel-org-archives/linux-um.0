Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqkyR-0001zb-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:14:04 -0700
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JqkyL-0005Bo-V4
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:14:01 -0700
Received: by wa-out-1112.google.com with SMTP id k22so10155686waf.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 01:13:57 -0700 (PDT)
Date: Tue, 29 Apr 2008 16:12:55 +0800 (CST)
In-Reply-To: <20080428153716.GC7334@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.1.00.0804291610070.2548@localhost.localdomain>
References: <20080425175609.GA11180@c2.user-mode-linux.org>
	<20080426.171755.99884416.xiyou.wangcong@gmail.com>
	<20080428153716.GC7334@c2.user-mode-linux.org>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH 7/19] UML - Move hppfs_kern.c to hppfs.c
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
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 28 Apr 2008, Jeff Dike wrote:

> On Sat, Apr 26, 2008 at 05:17:55PM +0800, WANG Cong wrote:
>> > +static struct inode *get_inode(struct super_block *, struct dentry *);
>> > +
>> > +struct hppfs_data {
>> > +	struct list_head list;
>> > +	char contents[PAGE_SIZE - sizeof(struct list_head)];
>> > +};
>> > +
>> > +struct hppfs_private {
>> > +	struct file *proc_file;
>> > +	int host_fd;
>> > +	loff_t len;
>> > +	struct hppfs_data *contents;
>> > +};
>> > +
>> > +struct hppfs_inode_info {
>> > +	struct dentry *proc_dentry;
>> > +	struct inode vfs_inode;
>> > +};
>> > +
>> > +static inline struct hppfs_inode_info *HPPFS_I(struct inode *inode)
>> > +{
>> > +	return container_of(inode, struct hppfs_inode_info, vfs_inode);
>> > +}
>> > +
>> > +#define HPPFS_SUPER_MAGIC 0xb00000ee
>> 
>> 
>> These can be put into a single header, e.g. hppfs.h.
>
> Why, when this one C file is the only user?

Just looks cleaner for me. ;-)

<snip>

>
> Oops, nice spotting.
>
> See what you think about the patch below...

<snip>

This patch looks OK for me. Thank you!

  Cong

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
