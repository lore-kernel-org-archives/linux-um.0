Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMOwm-0000bA-5u for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 07:06:36 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMOwl-00054b-9f
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 07:06:36 -0700
Date: Sat, 18 Aug 2007 19:49:12 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
In-Reply-To: <20070817194342.GA8759@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.0.999.0708181924020.29105@enigma.security.iitk.ac.in>
References: <20070817194342.GA8759@c2.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 6/6] UML - Fix hostfs style
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
Cc: Andrew Morton <akpm@osdl.org>, Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>



On Fri, 17 Aug 2007, Jeff Dike wrote:

> Style fixes in hostfs.

> Index: linux-2.6.22/fs/hostfs/hostfs_kern.c
> [...]
> @@ -6,22 +6,15 @@
>   * 2003-02-10 Petr Baudis <pasky@ucw.cz>
>   */
>  
> -#include <linux/stddef.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/pagemap.h>
> -#include <linux/blkdev.h>
> -#include <linux/list.h>
>  #include <linux/statfs.h>
> -#include <linux/kdev_t.h>
>  #include <linux/swap.h> /* mark_page_accessed */
> -#include <asm/uaccess.h>
>  #include "hostfs.h"
> -#include "kern_util.h"
> -#include "kern.h"
>  #include "init.h"
> +#include "kern.h"

Not really a style fix :-)


> @@ -328,17 +326,17 @@ int hostfs_readdir(struct file *file, vo
> [...]
> -		if(error) break;
> +		if (error) break;

		if (error)
			break;


> @@ -522,28 +523,28 @@ static int init_inode(struct inode *inod
> [...]
>  	else type = OS_TYPE_DIR;

I wonder what's the generally accepted / followed coding style for this,
actually. Personally I'd prefer:

	else
		type = OS_TYPE_DIR;


>  	else inode->i_op = &hostfs_iops;

>  	else inode->i_fop = &hostfs_file_fops;

>  	else inode->i_mapping->a_ops = &hostfs_aops;

>  	else error = read_name(inode, name);

Ditto.


>  	else
>  		err = access_file(name, r, w, x);

Here we've used the (different, and preferred IMHO) style. You could
make this style common throughout this file.


> +	else if (err > 0) {

This is fine, by the way. "if", or even a "{" in the same line after
"else" is okay, but not a statement by itself.


> Index: linux-2.6.22/fs/hostfs/hostfs_user.c
> [...]
> -#include <unistd.h>
>  #include <stdio.h>
> -#include <fcntl.h>
> +#include <stddef.h>
> +#include <unistd.h>
>  #include <dirent.h>
>  #include <errno.h>
> -#include <utime.h>
> +#include <fcntl.h>
>  #include <string.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
> +#include <sys/types.h>
>  #include <sys/vfs.h>
>  #include "hostfs.h"
> -#include "kern_util.h"
> +#include "os.h"
>  #include "user.h"
> +#include <utime.h>

Not a style fix again ...


>  	else return OS_TYPE_FILE;

>  	else return 0;

>  	else panic("Impossible mode in open_file");

>  	else return fd;

For the "else return" cases, you could consider making the code such that
there's a single return at the end, and a "ret" that is set by the code
appropriately. You'll find counter-examples, sure, but often multiple
"return"s in a function are confusing from a style point of view.


Otherwise, I saw both the patches I was cc'ed on, and both look good
to me, thank you.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
