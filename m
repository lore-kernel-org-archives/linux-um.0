Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATPEq-000472-Ed
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 09:32:04 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ATPEp-0000My-MA
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 09:32:03 -0800
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host
	physical RAM
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <200312081639.22888.matthew-list@bytemark.co.uk>
References: <200312081639.22888.matthew-list@bytemark.co.uk>
Content-Type: text/plain
Message-Id: <1070904717.31073.91.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Mon, 08 Dec 2003 12:31:58 -0500
To: Matthew Bloch <matthew-list@bytemark.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

What version/patches were you using on the host kernel?  Did you perform
any pre-compilation tweaks?  I had this behavior, but after adding some
interactivity and vm patches  I no longer see this under 2.4.

On Mon, 2003-12-08 at 11:39, Matthew Bloch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello all,
> 
> Michel Pollet <michel@pollet.net>, a customer of ours, contributed an earlier 
> version of this patch to improve the performance of his host on our network.  
> It worked so well, we've rolled it out to all our customers and really 
> improves the "snappiness" of our Virtual Machines, as well as being clearly 
> fairer for customers who pay by the MB for RAM.
> 
> Anyone else who's running lots of UMLs with interactive sessions may have 
> noticed the following symptoms which this patch cures:
> 
>    * irregular ping times to UMLs-- huge delay for the first ping, a few
>        normal, a couple of long delays etc.;
>    * long gaps in interactive response (having to "wake it up" with some
>        keypresses), especially after connecting for the first time in a few
>        hours.
> 
> Obviously with locked memory the host kernel cannot swap out your UML's 
> physical RAM to disc, which means you can't stuff more UMLs onto your machine 
> than you have physical RAM any more.  And your kernels need to be setuid root 
> now to do the memory locking, which is a concern.  But you don't have to 
> enable mlocking if you still want that situation.  However Linux does seem to 
> perform quite badly when its "real" RAM is swapped, so I think this is pretty 
> sensible and mlocking is certainly our policy now.  My experience with 2.4 as 
> a host kernel is that it will quite happily swap out pages from running 
> applications to use as disc cache; this is apparently alleviated with 2.6's 
> "swappiness" kernel parameter.
> 
> - From Michel's initial patch, I've abstracted the system calls to lock memory 
> and drop privs so that it fits in with the UML os_ functions, and added a 
> command-line option to switch it on, e.g.
> 
>    ./linux mem=64MB mlock ubd2=xyz
> 
> I hope that it's obvious enough to warrant inclusion in the next release of 
> the UML patch; my only thought was whether instead of putting 
> setuid-requiring code into the kernel, mem= should accept a file descriptor 
> as an argument and have the memory mapping optionally done by an external 
> process.  This strikes me as a bit weird from most angles, but obviously it 
> allows isolation of code which needs root privileges, and would probably be 
> very little work to add to the filemap patch for this purpose.
> 
> Regarding testing, Michel's original patch is running on our customers' VMs.  
> My version is only running on a single one of our VMs, but has correctly 
> locked the memory as Michel's version did.
> 
> Any comments would be appreciated!
> 
> cheers,
> 
> - --
> Matthew Bloch                             Bytemark Hosting
>                                   tel. +44 (0) 8707 455026
>                         http://www.bytemark-hosting.co.uk/
>           Dedicated Linux hosts from 15ukp ($26) per month
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQE/1KkyT2rVDg8aLXQRAnTmAJ9NLC2gyWAMFAVPlL2NT5n8qjvxzgCeJMgm
> ANgK3O86koD2N1fUaTGFQFc=
> =6BY0
> -----END PGP SIGNATURE-----
> 
> ______________________________________________________________________
> diff -urN linux-2.4.22-uml6/arch/um/include/os.h linux-2.4.22-uml6-physmem-clean/arch/um/include/os.h
> --- linux-2.4.22-uml6/arch/um/include/os.h	2003-12-05 21:24:49.000000000 +0000
> +++ linux-2.4.22-uml6-physmem-clean/arch/um/include/os.h	2003-12-06 14:02:46.000000000 +0000
> @@ -165,6 +165,8 @@
>  			     int r, int w, int x);
>  extern int os_unmap_memory(void *addr, int len);
>  extern void os_flush_stdout(void);
> +extern int os_lock_memory(void *addr, unsigned long len);
> +extern void os_drop_privileges(void);
>  
>  #endif
>  
> diff -urN linux-2.4.22-uml6/arch/um/kernel/physmem.c linux-2.4.22-uml6-physmem-clean/arch/um/kernel/physmem.c
> --- linux-2.4.22-uml6/arch/um/kernel/physmem.c	2003-12-05 21:24:49.000000000 +0000
> +++ linux-2.4.22-uml6-physmem-clean/arch/um/kernel/physmem.c	2003-12-06 14:02:46.000000000 +0000
> @@ -122,6 +122,7 @@
>  unsigned long high_physmem;
>  
>  extern unsigned long physmem_size;
> +extern unsigned long physmem_lock;
>  
>  void *to_virt(unsigned long phys)
>  {
> @@ -225,6 +226,18 @@
>  		exit(1);
>  	}
>  
> +	if (physmem_lock) {
> +		int err;
> +		
> +		err = os_lock_memory((void*) uml_reserved, len - offset);
> +		if (err)
> +		{
> +			os_print_error(err, "Couldn't mlock memory");
> +			exit(1);
> +		}
> +		os_drop_privileges();
> +	}
> +
>  	bootmap_size = init_bootmem(pfn, pfn + delta);
>  	free_bootmem(__pa(reserve_end) + bootmap_size,
>  		     len - bootmap_size - reserve);
> @@ -276,6 +289,19 @@
>  "	Example: mem=64M\n\n"
>  );
>  
> +static int __init uml_mlock_setup(char *line, int *add)
> +{
> +	physmem_lock = 1;
> +	return 0;
> +}
> +__uml_setup("mlock", uml_mlock_setup,
> +"mlock\n"
> +"    This option requests that the user-mode kernel's memory be locked\n"
> +"    into the host kernel's RAM so that it cannot be swapped out.\n"
> +"    This option requires that the user-mode kernel is run with root\n"
> +"    privileges, which it drops after the mapping has been done.\n"
> +);
> +
>  unsigned long find_iomem(char *driver, unsigned long *len_out)
>  {
>  	struct iomem_region *region = iomem_regions;
> diff -urN linux-2.4.22-uml6/arch/um/kernel/um_arch.c linux-2.4.22-uml6-physmem-clean/arch/um/kernel/um_arch.c
> --- linux-2.4.22-uml6/arch/um/kernel/um_arch.c	2003-12-05 21:24:49.000000000 +0000
> +++ linux-2.4.22-uml6-physmem-clean/arch/um/kernel/um_arch.c	2003-12-06 14:02:49.000000000 +0000
> @@ -129,6 +129,7 @@
>  /* Set in early boot */
>  static int have_root __initdata = 0;
>  long physmem_size = 32 * 1024 * 1024;
> +long physmem_lock = 0;
>  
>  void set_cmdline(char *cmd)
>  {
> diff -urN linux-2.4.22-uml6/arch/um/os-Linux/process.c linux-2.4.22-uml6-physmem-clean/arch/um/os-Linux/process.c
> --- linux-2.4.22-uml6/arch/um/os-Linux/process.c	2003-12-05 21:24:49.000000000 +0000
> +++ linux-2.4.22-uml6-physmem-clean/arch/um/os-Linux/process.c	2003-12-06 14:02:53.000000000 +0000
> @@ -135,6 +135,29 @@
>          return(0);
>  }
>  
> +int os_lock_memory(void *addr, unsigned long len)
> +{
> +	/* Michel mentioned that a single call to mlock doesn't work;
> +	 * this seemed the safest alternative.
> +	 */
> +	while (len > 0) {
> +		size_t next_len	= len < getpagesize() ? len : getpagesize();
> +		int err 	= mlock(addr, next_len);
> +		
> +		if (err) return(-err);
> +		
> +		addr += next_len;
> +		len  -= next_len;
> +	}
> +	
> +	return(0);
> +}
> +
> +void os_drop_privileges()
> +{
> +	setuid(getuid());
> +}
> +
>  /*
>   * Overrides for Emacs so that we follow Linus's tabbing style.
>   * Emacs will notice this stuff at the end of the file and automatically
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
