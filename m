Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrdj-0001hR-Td
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 16:40:11 -0800
Received: from [82.65.9.115] (helo=yellowpig.yi.org ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrdj-0006Tc-CA
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 16:40:11 -0800
Message-ID: <20031221004003.GR25221@seventeen>
References: <20031219143655.GA7944@pari.math.u-bordeaux.fr> <20031219161144.GB18100@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219161144.GB18100@alcor.net>
From: Bill Allombert <allomber@math.u-bordeaux.fr>
Subject: [uml-devel] Re: Bug#224502: FATAL: cannot determine library version
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 Dec 2003 01:40:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net, 224502@bugs.debian.org

On Fri, Dec 19, 2003 at 08:11:44AM -0800, Matt Zimmerman wrote:
> On Fri, Dec 19, 2003 at 03:36:55PM +0100, Bill Allombert wrote:
> 
> > I have upgraded from 2.4.22-5um-1 to 2.4.22-7um-1 and now 
> > user-mode-linux fail to start with 
> > 
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > VFS: Mounted root (ext2 filesystem) readonly.
> > FATAL: cannot determine library version
> 
> Strange.  I think this error message comes from ld.so.

You are right.  From the source , this message com from
 sysdeps/unix/sysv/linux/dl-osinfo.h in the following macro:

#define DL_SYSDEP_OSCHECK(FATAL) \
  do {                                                                        \
    /* Test whether the kernel is new enough.  This test is only              \
       performed if the library is not compiled to run on all                 \
       kernels.  */                                                           \

The UML filesystem is woody.

I tried to build a new filesystem with rootstrap+slirp but the new uml
package fail:
I: Retrieving diff
I: Validating diff
/tmp/target/var/lib/apt/lists/debootstrap.invalid_dists_woody_main_binary-i386_Packages: Function not implemented
Traceback (most recent call last):
  File "/usr/lib/rootstrap/builder", line 66, in ?
    dispatch(module, modulevars)
  File "/usr/lib/rootstrap/builder", line 44, in dispatch
    raise "rootstrap: Module '%s' failed, status: %d" % (module,status)
rootstrap: Module 'debian' failed, status: 1
Kernel panic: Attempted to kill init!

While the old one perform normally.

Cheers,
-- 
Bill. <ballombe@debian.org>

Imagine a large red swirl here. 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
