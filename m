Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrxM-0002KS-Jx
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 17:00:28 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrxM-0001zx-9r
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 17:00:28 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: Bug#224502: FATAL: cannot determine library version
Message-ID: <20031221010021.GG9354@alcor.net>
References: <20031219143655.GA7944@pari.math.u-bordeaux.fr> <20031219161144.GB18100@alcor.net> <20031221004003.GR25221@seventeen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221004003.GR25221@seventeen>
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
Date: Sat, 20 Dec 2003 17:00:21 -0800
To: Bill Allombert <allomber@math.u-bordeaux.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224502@bugs.debian.org

On Sun, Dec 21, 2003 at 01:40:03AM +0100, Bill Allombert wrote:

> On Fri, Dec 19, 2003 at 08:11:44AM -0800, Matt Zimmerman wrote:
> > On Fri, Dec 19, 2003 at 03:36:55PM +0100, Bill Allombert wrote:
> > 
> > > I have upgraded from 2.4.22-5um-1 to 2.4.22-7um-1 and now 
> > > user-mode-linux fail to start with 
> > > 
> > > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > > VFS: Mounted root (ext2 filesystem) readonly.
> > > FATAL: cannot determine library version
> > 
> > Strange.  I think this error message comes from ld.so.
> 
> You are right.  From the source , this message com from
>  sysdeps/unix/sysv/linux/dl-osinfo.h in the following macro:
> 
> #define DL_SYSDEP_OSCHECK(FATAL) \
>   do {                                                                        \
>     /* Test whether the kernel is new enough.  This test is only              \
>        performed if the library is not compiled to run on all                 \
>        kernels.  */                                                           \
> 
> The UML filesystem is woody.

This is probably another symptom of the same bug; something is returning
-ENOSYS _sometimes_.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
