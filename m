Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BE7h0-0000rt-EC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 07:18:14 -0700
Received: from albatross.ericsson.se ([193.180.251.49])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BE7gy-0002eD-OK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 07:18:12 -0700
Received: from esealmw140.al.sw.ericsson.se ([153.88.254.121])
	by albatross.ericsson.se (8.12.10/8.12.10/WIREfire-1.8b) with ESMTP id
	i3FEI7WR008246 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Apr 2004 16:18:07 +0200 (MEST)
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Message-Id: <200404151417.i3FEHr623628@duna48.eth.ericsson.se>
Subject: [uml-devel] Kernel panic: fix_range fixing wrong address space
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
Date: Thu, 15 Apr 2004 16:17:53 +0200 (MEST)
To: user-mode-linux-devel@lists.sourceforge.net

I get this error on 2.6.4 + latest uml patch.  The cause seems to be
when call_usermodehelper() function is called twice in quick
succession.  Timing seems to play the major role here, doing
schedule() between them doesn't help.  I've tried under 2.4 and 2.6
hosts, and the problem appears in both cases.  The same module runs
perfectly under native linux, so it seems to be a UML bug.

Here's a minimal kernel module that can be used to reproduce this
problem:

insmod umlbug.ko

echo > /proc/fs/umlbug
(wait a little)
echo > /proc/fs/umlbug

 -- no problem 

echo > /proc/fs/umlbug; echo > /proc/fs/umlbug

 -- Bang!

Any ideas?

Thanks,
Miklos
============================================================
#include <linux/module.h>
#include <linux/init.h>
#include <linux/proc_fs.h>

static int trigger_write(struct file *file, const char __user *buffer,
			 unsigned long count, void *data)
{
	char *argv[] = { "/bin/true", NULL };
	char *envp[] = { NULL };
	call_usermodehelper(argv[0], argv, envp, 1);
	return count;
}

static int __init init_umlbug(void)
{
	struct proc_dir_entry *e;
	e = create_proc_entry("umlbug", S_IFREG | 0200, proc_root_fs);
	if (e) {
		e->owner = THIS_MODULE;
		e->write_proc = trigger_write;
	}
	return 0;
}

static void __exit exit_umlbug(void)
{
	remove_proc_entry("umlbug", proc_root_fs);
}

module_init(init_umlbug)
module_exit(exit_umlbug)
MODULE_LICENSE("GPL");
============================================================


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
