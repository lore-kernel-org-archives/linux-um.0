Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Chi7x-0002cC-72 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 21:36:37 -0800
Received: from pop5-1.us4.outblaze.com ([205.158.62.125])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Chi7w-00006G-H5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 21:36:37 -0800
Received: from inv.it.uc3m.es (oboe.it.uc3m.es [163.117.139.101])
	by nbd.it.uc3m.es (8.13.1/8.13.1/Debian-15) with ESMTP id
	iBO5aNXh018967 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Dec 2004 06:36:26 +0100
Received: (from ptb@localhost)
	by inv.it.uc3m.es (8.11.6/8.11.0) id iBO5aOG20540
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Dec 2004 06:36:24 +0100
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200412240536.iBO5aOG20540@inv.it.uc3m.es>
Reply-To: ptb@inv.it.uc3m.es
Subject: [uml-devel] kmalloc does not recover mem in 2.4.24
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
Date: Fri, 24 Dec 2004 06:36:24 +0100 (MET)
To: user-mode-linux-devel@lists.sourceforge.net

Howdy. I've been running 2.4.24-1um very happily for a good long time.
Since April, I believe. But I've just noticed that kmalloc does not seem
to recover memory. Here I've cooked up some demonstration code:

sh-2.03# free
             total       used       free     shared    buffers cached
Mem:         29524       4540      24984          0        140 2824
                         ^^^^^
-/+ buffers/cache:       1576      27948
Swap:            0          0          0

sh-2.03# insmod mem.o
tiny driver loaded


(this module uses kmalloc to allocate 1000 pages in its init function, 
and will release it in its exit function)

sh-2.03# free
             total       used       free     shared    buffers cached
Mem:         29524       8684      20840          0        140 2824
                         ^^^^^
-/+ buffers/cache:       5720      23804
Swap:            0          0          0

sh-2.03# rmmod mem
tiny driver unloaded

sh-2.03# free
             total       used       free     shared    buffers cached
Mem:         29524       8680      20844          0        140 2824
                         ^^^^^
-/+ buffers/cache:       5716      23808
Swap:            0          0          0


Same mem usage!  Nothing released.  I am running UML under kernel 2.6.3,
where it also shows timing anomalies - any sleep takes ages to complete.

Here's my test code:


#include <linux/major.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/init.h>
#include <linux/slab.h>

#include <linux/blkdev.h>
#include <linux/blk.h>

int linux_version_code = LINUX_VERSION_CODE;

#define MAX_TINY 1024

static char ** tiny_cache;
static int max_tiny = MAX_TINY;

static int __init
tiny_init (void)
{
        int i, err;

        tiny_cache = kmalloc(sizeof(char *) * max_tiny, GFP_KERNEL);
        for (i = 0; i < max_tiny; i++) {

                tiny_cache[i] = kmalloc(PAGE_SIZE, GFP_KERNEL);
                if (!tiny_cache[i])
                        goto error_out;
        }
        printk (KERN_INFO "tiny driver loaded\n");
        return 0;

error_out:

        printk (KERN_ERR "tiny driver failed to load\n");
        while (--i >= 0) {
                kfree(tiny_cache[i]);
        }
        kfree(tiny_cache);
        return -EINVAL;
}

static void __exit
tiny_cleanup (void)
{

        int i;

        for (i = 0; i < max_tiny; i++) {
                kfree (tiny_cache[i]);
        }
        kfree(tiny_cache);
        printk (KERN_INFO "tiny driver unloaded\n");
}

module_init (tiny_init);
module_exit (tiny_cleanup);



Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
