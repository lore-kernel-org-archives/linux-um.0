Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7idz-0004U5-IX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 15:25:11 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D7idx-0004Mp-TL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 15:25:11 -0800
Message-ID: <422A3FB4.6030302@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6.11 + uml.sf.net patches panic (now fixed, replaced
	by CPU problem)
References: <42267C13.1060703@rimuhosting.com>
	<200503031853.j23IrNDS003496@ccure.user-mode-linux.org>
	<42286F4A.30506@fujitsu-siemens.com>
	<422879DE.6050405@fujitsu-siemens.com>
In-Reply-To: <422879DE.6050405@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sun, 06 Mar 2005 12:24:36 +1300
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>


Hi.  I just tried 2.6.11 + jeff's patches (which are now against 2.6.11 
and appear to include bodo's patch from below).

With this codebase I was able to startup tomcat without getting the 
kernel crash I reported previously.  Cool.

There were some problems though.  My feedback on this setup is below. 
The main showstopper is an issue where the guest UML sucks up all 
available CPU.  I've gone back to using 2.6.9-bs7 for the time being.

Regards, Peter
http://rimuhosting.com

bodo's fp-state would not apply (at least with patch -p 1).  All other 
patches went in OK.

Got this:
  HOSTCC  scripts/kallsyms
   HOSTCC  scripts/bin2c
   CC      init/main.o
In file included from include/asm/pgtable.h:28,
                  from include/linux/bootmem.h:7,
                  from init/main.c:30:
include/asm/pgtable-3level.h: In function `pfn_pmd':
include/asm/pgtable-3level.h:138: warning: implicit declaration of 
function `__pmd'
include/asm/pgtable-3level.h:138: incompatible types in return
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
make linux


Had to disable the 3level page table option inside the UML specific options.


Got:

   CC      arch/um/drivers/ubd_kern.o
   CC      arch/um/drivers/x11_kern.o
   CC      arch/um/drivers/x11_user.o
arch/um/drivers/x11_user.c:10:19: X11/X.h: No such file or directory
arch/um/drivers/x11_user.c:11:22: X11/Xlib.h: No such file or directory
arch/um/drivers/x11_user.c:12:23: X11/Xutil.h: No such file or directory
arch/um/drivers/x11_user.c:13:24: X11/keysym.h: No such file or directory
arch/um/drivers/x11_user.c:14:33: X11/extensions/XShm.h: No such file or 
directory
arch/um/drivers/x11_user.c:23: syntax error before "Display"
arch/um/drivers/x11_user.c:23: warning: no semicolon at end of struct or 
union
arch/um/drivers/x11_user.c:24: warning: type defaults to `int' in 
declaration of `root'
arch/um/drivers/x11_user.c:24: warning: type defaults to `int' in 
declaration of `win'

Disabled X11 Framebuffer driver


Got:

   CC      arch/um/drivers/random.o
   LD      arch/um/drivers/built-in.o
arch/um/os-Linux/Makefile:15: *** commands commence before first target. 
  Stop.
make: *** [arch/um/os-Linux] Error 2
make linux

In the Makefile I saw:

user-objs-$(CONFIG_TTY_LOG) += tty_log.o

USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o
         mem.o process.o sigio.o signal.o start_up.o syscall.o trap.o 
time.o \
         tt.o tty.o uaccess.o umid.o util.o

Changed that to
USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o \

(Excuse the email wrapping.  Basically the first USER_OBJS line is 
missing a trailing '\').

When I start it up the UML sits maxing out the CPU.  I think vanilla 
2.6.11 UML guests do that as well.

38 processes: 35 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
    total    2.6%    0.0%    0.0%  97.3%     0.0%    0.0%    0.0%
Mem:   255660k av,   48348k used,  207312k free,       0k shrd,    4320k 
buff


Checking for the skas3 patch in the host:
   - /proc/mm...found
   - PTRACE_FAULTINFO...found
   - PTRACE_LDT...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.11-rimu6 (root@host33.rimuhosting.com) (gcc version 
3.2.3 20030502 (Red Hat Linux 3.2.3-42)) #1 Sat Mar 5 22:07:34 UTC 2005
Built 1 zonelists
Kernel command line: con=null con0=fd:0,fd:1 eth0=tuntap,tap39 mem=256M 
ubd7=/dev/shm2/tmp/fc3.rimuhosting.com/swapfs.swp 
ubd0=/home/umlusers/fc3.rimuhosting.com/wbl3-3.backingfilenota.cow root=98:0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255488k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
NET: Registered protocol family 16




Bodo Stroesser wrote:
> Bodo Stroesser wrote:
> 
>> Jeff Dike wrote:
>>
>>> The write_ldt just above the segfault in both stacks looks suspicious.
>>
>>
>>
>> Yes. There seems to be a problem with this new stuff.
>>
>> Peter, could you please send a full call trace? I guess, the ones in your
>> mail are truncated, right?
>>
>>           Bodo
> 
> Meanwhile I found a problem in arch/um/sys-i386/ldt.c, which causes UML
> to panic, if LDT-entry number 8 is written, using modify_ldt-syscall.
> 
> This crash is very similar to the one Peter had, so I hope the appended
> oneliner will solve the problem.
> 
>        Bodo
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> ---
> 
> 
> diff -puN arch/um/sys-i386/ldt.c~fix-skas-ldt arch/um/sys-i386/ldt.c
> --- linux-2.6.11-rc3-mm2/arch/um/sys-i386/ldt.c~fix-skas-ldt	2005-03-04 15:51:04.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-root/arch/um/sys-i386/ldt.c	2005-03-04 15:51:27.000000000 +0100
> @@ -208,7 +208,7 @@ static int write_ldt(void __user * ptr, 
>  		goto out_unlock;
>  
>  	if(ldt_info.entry_number >= ldt->entry_count &&
> -	   ldt_info.entry_number > LDT_DIRECT_ENTRIES){
> +	   ldt_info.entry_number >= LDT_DIRECT_ENTRIES){
>  		for(i=ldt->entry_count/LDT_ENTRIES_PER_PAGE;
>  		    i*LDT_ENTRIES_PER_PAGE <= ldt_info.entry_number;
>  		    i++){
> _


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
