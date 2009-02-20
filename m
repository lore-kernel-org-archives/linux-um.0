Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <webmaster@villagersonline.com>) id 1LaVUc-00023v-Gn
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2009 13:32:38 +0000
Received: from fed1rmmtao101.cox.net ([68.230.241.45])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LaVUb-0007Cw-4C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2009 13:32:38 +0000
Received: from fed1rmimpo03.cox.net ([70.169.32.75]) by fed1rmmtao101.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20090220133235.KPWB2948.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Feb 2009 08:32:35 -0500
Message-ID: <499E5F6A.9010204@villagersonline.com>
Date: Fri, 20 Feb 2009 00:44:42 -0700
From: Russell Lewis <webmaster@villagersonline.com>
MIME-Version: 1.0
References: <499AAC60.2050504@villagersonline.com>
In-Reply-To: <499AAC60.2050504@villagersonline.com>
Subject: Re: [uml-devel] Update: Nesting, and other Qs
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Some googling found a patch which seems to have worked around the 
"status = 256" problem.  (I'm hoping that the patch is correct):
    
http://groups.google.com/group/linux.kernel/browse_thread/thread/bacb6633e87708d9

However, now I'm seeing the "enclosing" UML instance crash when I try to 
run nested.  The error is:
    EXT3-fs: mounted filesystem with ordered data mode.
    VFS: Mounted root (ext3 filesystem) readonly.
    Eeek! page_mapcount(page) went negative! (-1)
      page pfn = 14f
      page->flags = 400
      page->count = 1
      page->mapping = 00000000
      vma->vm_ops = 0x8205524
      vma->vm_ops->fault = special_mapping_fault+0x0/0x44
    Kernel panic - not syncing: Kernel mode signal 4
    Terminated

I've been googling on this, and the closest I've come (not sure it if is 
related) was from last September.  Sounded like Jeff understood the 
problem, and was working on a patch:
    
http://groups.google.com/group/linux.debian.bugs.dist/browse_thread/thread/729c58a780e680e5

Please, can somebody at least tell me if this path is worth pursuing?  
Are other people using nesting and having it work???  I'd prefer to use 
UML, but I don't want to waste my time pursuing something that it's 
ready to use.

Thanks!
    Russ

Russell Lewis wrote:
> Welcome, all.  I played with UML a few years back (before it was in the 
> mainline), and now plan to use it again for some academic research.  I'm 
> sure you guys will be hearing from me over the next couple of semesters. :)
>
> 3 early questions:
>
> - Is nesting currently working?  Do we still need to set NESTING=x, or 
> is it autodetected somehow?
>
> (I tried to nest, and it doesn't segfault, but it terminates immediately 
> with "Checking syscall emulation patch for ptrace...check_sysemu : 
> expecting SIGTRAP, got status = 256"
>
> - Is there a recommended "best" level to work from?  I am currently 
> using linux-2.6.28, which seems to work except or the "sigprocmask" problem.
>
> - Looks to me like the website is way out of date.  Is there a good, 
> current page or wiki where I can look things up?  I've google'd a lot, 
> but everything seems a couple of years old.
>
> Thanks!
>
> Russ Lewis
>
> ------------------------------------------------------------------------------
> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> -Strategies to boost innovation and cut costs with open source participation
> -Receive a $600 discount off the registration fee with the source code: SFAD
> http://p.sf.net/sfu/XcvMzF8H
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>   


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

