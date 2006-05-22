Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiDwa-00014S-LB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 10:11:48 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FiDwa-000166-CO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 10:11:48 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FiDwY-0006nL-S8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 10:11:48 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Problem in compiling without optimisations
Message-ID: <20060522171213.GA5083@ccure.user-mode-linux.org>
References: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
	<5d8380130605220750u19867b14gb33a824ea65901fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8380130605220750u19867b14gb33a824ea65901fd@mail.gmail.com>
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
Date: Mon, 22 May 2006 13:12:13 -0400
To: Nikola Knezevic <laladelausanne@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, May 22, 2006 at 04:50:57PM +0200, Nikola Knezevic wrote:
> On 5/22/06, Nikola Knezevic <laladelausanne@gmail.com> wrote:
> >This is the culprit:
> >static inline void remap_stack(int fd, unsigned long offset)
> >{
> >        __asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
> >                          "movl %7, %%ebx ; movl %%eax, (%%ebx)"
> >                          : : "g" (STUB_MMAP_NR), "b" 
> >                          (UML_CONFIG_STUB_DATA),
> >                            "c" (UM_KERN_PAGE_SIZE),
> >                            "d" (PROT_READ | PROT_WRITE),
> >                            "S" (MAP_FIXED | MAP_SHARED), "D" (fd),
> >                            "a" (offset),
> >                            "i" (&((struct stub_data *)
> >UML_CONFIG_STUB_DATA)->err)
> >                          : "memory");
> >}
> 
> Well, after reading about asm constrains, solution was to change that
> "i" to "g". 

Checking my fuzzy recollection of asm constraints -
	"i" means immediate, i.e. a compile-time constant and "g" means
anything?  So, "i" breaks when gcc isn't trying hard enough to turn that
expression into a constant.

If so, it doesn't look worth changing.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
