Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHvZN-00070L-1g	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 20:46:53 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EHvZL-0005vf-NR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 20:46:53 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20050921034649.GX7992@ftp.linux.org.uk>
References: <20050918140951.31461.78736.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918140951.31461.78736.stgit@zion.home.lan>
Subject: [uml-devel] Re: [PATCH 04/12] HPPFS: fix access to ppos and
	file->f_pos
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
Date: Wed, 21 Sep 2005 04:46:49 +0100
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Sun, Sep 18, 2005 at 04:09:51PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
>  static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
>  			 loff_t *ppos, int is_user)
>  {
> @@ -228,17 +237,21 @@ static ssize_t read_proc(struct file *fi
>  	if (read == NULL)
>  		return -EINVAL;
>  
> +	WARN_ON(is_user != (ppos != NULL));

Eww....  Why not pass the right ppos in all cases?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
