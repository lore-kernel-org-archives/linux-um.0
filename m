Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Av9jD-0004Dt-18 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 22:38:07 -0800
Received: from 203-79-92-50.cable.paradise.net.nz ([203.79.92.50]
	helo=bag.kiwa.co.nz)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Av9bk-0001a5-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 22:30:24 -0800
From: Nicholas Lee <nic-lists@plumtree.co.nz>
Subject: skas and vserver on 2.4.25 (Re: [uml-devel] new skas3 patch ready for
	2.4.25)
Message-ID: <20040223063021.GC31430@woodcut.kpac.co.nz>
References: <40338C1B.1070800@meisterwerk.net>
	<200402202125.58574.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402202125.58574.blaisorblade_spam@yahoo.it>
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
Date: Mon, 23 Feb 2004 19:30:21 +1300
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 20, 2004 at 09:25:57PM +0100, BlaisorBlade wrote:
> 
> Yes, it went away, so a new skas patch must be built. I have one (tested) at 
> http://www.user-mode-linux.org/~blaisorblade/

Using this patch against against 2.4.25 with evmns, libata and the
vserver patch, I get the following compilation error:-

nic@stateless:/usr/src/linux-2.4.25-vs1.3.7/mm$ gcc -D__KERNEL__ -I/usr/src/linux-2.4.25-vs1.3.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=proc_mm  -c -o proc_mm.o proc_mm.c
proc_mm.c: In function `open_proc_mm':
proc_mm.c:109: error: too few arguments to function `mm_alloc'


mm_alloc seems to come from:

<linux/sched.h>
...
extern struct mm_struct * mm_alloc(struct vx_info *);


vx_info is defined in <linux/vserver/context.h>


Looks like vserver has redefined:-

-extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct * mm_alloc(struct vx_info *);


I don't know the kernel well enough to add the appropiate call to:

static int open_proc_mm(struct inode *inode, struct file *file)
{
        struct mm_struct *mm = mm_alloc();

I'm guessing it might be something like 

               mm_alloc(current->vx_info);



-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            

                         Quixotic Eccentricity


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
