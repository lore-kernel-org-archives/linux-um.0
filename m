Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sgerwk@aol.com>) id 1cSjj7-0005IR-7N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2017 12:16:01 +0000
Received: from omr-a008e.mx.aol.com ([204.29.186.51])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cSjj6-0006cL-Bj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2017 12:16:01 +0000
Received: from mtaout-mab02.mx.aol.com (mtaout-mab02.mx.aol.com
	[172.26.249.82])
	by omr-a008e.mx.aol.com (Outbound Mail Relay) with ESMTP id
	0B89F3800083 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 15 Jan 2017 07:15:55 -0500 (EST)
Received: from [192.168.0.2]
	(host35-166-dynamic.171-212-r.retail.telecomitalia.it
	[212.171.166.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mtaout-mab02.mx.aol.com (MUA/Third Party Client Interface) with
	ESMTPSA id 49D5E38000081
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 15 Jan 2017 07:15:53 -0500 (EST)
Date: Sun, 15 Jan 2017 13:16:22 +0100 (CET)
From: sgerwk@aol.com
Message-ID: <alpine.LSU.2.11.1701151314470.4417@thinkbad.dis.uniroma1.it>
MIME-Version: 1.0
Subject: [uml-devel] uml does not work with initrd=file
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

Hi,

there seems to be a problem with usermode linux when started
with an initial ramdisk (argument initrd=file). Here is what
happens:

------------------------------------

Locating the bottom of the address space ... 0x1000
Locating the top of the address space ... Checking that ptrace can change system call numbers...0xc0000000
Core dump limits :
 	soft - 0
 	hard - NONE
OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Adding 8470528 bytes to physical memory to account for exec-shield gap
kmsg_dump:
<1>bootmem alloc of 140 bytes failed!
<0>Kernel panic - not syncing: Out of memory
<4>CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.0-um #3
<6>Stack:
<4> 081eb922 081eb922 0822d547 00000000 08222000 00000000 0817fe48 00000000
<4> 0822bf6c 080bd1a7 00000007 0829c600 081f113d 0822bfbc 082220fc 00000000
<4> 00000000 00000000 0805393d 081f113d 0000008c 0804c88e 0000008c 00000080
<6>Call Trace:
<6> [<0805cffb>] ? 
<4>show_stack+0x9d/0x157
<6> [<0817fe48>] ? 
<4>dump_stack+0x23/0x2b
<6> [<080bd1a7>] ? 
<4>panic+0x9e/0x1b4
<6> [<0805393d>] ? 
<4>__alloc_bootmem+0x3f/0x43
<6> [<0804c88e>] ? 
<4>read_initrd+0x6a/0x101
<6> [<08096fa5>] ? 
<4>kmsg_dump_register+0x37/0x65
<6> [<0805e8a9>] ? 
<4>uml_finishsetup+0x27/0x3b
<6>

---------------------------------


Function read_initrd() calls alloc_bootmem(), but at this point 
memory hasn't been initialized yet.

A quick solution is to move uml_postsetup() (the function
that calls read_initrd()) right after the memory has been
initialized. This may be wrong since uml_postsetup() may call
other functions besides read_initrd(), but worked for me:
the initial ramdisk is loaded and init run.


--- linux-4.9.0/arch/um/kernel/um_arch.c	2016-12-11 20:17:54.000000000 +0100
+++ linux-4.9.0-um/arch/um/kernel/um_arch.c	2017-01-15 11:16:32.000000000 +0100
@@ -231,7 +231,7 @@
  	atomic_notifier_chain_register(&panic_notifier_list,
  				       &panic_exit_notifier);

-	uml_postsetup();
+	// uml_postsetup();

  	new_thread_handler();
  }
@@ -340,6 +340,7 @@
  {
  	stack_protections((unsigned long) &init_thread_info);
  	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
+	uml_postsetup();
  	mem_total_pages(physmem_size, iomem_size, highmem);

  	paging_init();

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

