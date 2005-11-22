Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeyNR-0006vG-MH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 09:25:49 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EeyNN-0005a3-IC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 09:25:49 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.15-rc1-mm2 on x86_64 build broken / 2.6.15-rc2 ok
References: <1132596931.19269.66.camel@ant.internal>
In-Reply-To: <1132596931.19269.66.camel@ant.internal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511222044.43418.blaisorblade@yahoo.it>
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
Date: Tue, 22 Nov 2005 20:44:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Monday 21 November 2005 19:15, Antoine Martin wrote:
> FYI, on a 64-bit host:
>
> make ARCH=um defconfig
> make ARCH=um vmlinux

> arch/um/kernel-offsets.s arch/um/sys-x86_64/kernel-offsets.c
> In file included from arch/um/include/um_mmu.h:17,
>                  from include/asm/mmu.h:9,
>                  from include/linux/sched.h:23,
>                  from arch/um/sys-x86_64/kernel-offsets.c:3:
> /usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include/mmu-skas.h:11
>:21: asm/ldt.h: No such file or directory
A dummy implementation (ldt-x86_64.h) was later added.

> And although 2.6.15-rc1-mm2 builds fine on x86 hosts, I get this when
> cross-compiling it:
> make ARCH=um SUBARCH=i386 vmlinux
>   CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/include/sysdep/stub.h:41: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:62: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:51: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:84: error: can't find a register in class
> `BREG' while reloading `asm'
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2
>
> Same error that was mentioned before, this one is gcc getting it wrong I
> seem to remember.

I can make it work actually in an easy way, but that's a bit less efficient 
code. However fast broken code is useless, so I'll do that _for now_ - but I 
want to understand what's going on with your GCC. Will mail you after a bit 
more investigation (re-reading your mails too).


> Also with patches.tar from sourceforge (dated 18/11/2005), I had to
> remove the zero length files as suggested by Rob.
> x86 build fails with the same gcc problem as above and the amd64 build
> fails (from reading previous posts, I guess this is because ldt isn't
> done for x86_64):
>   CC      arch/um/kernel/exec_kern.o
> arch/um/kernel/exec_kern.c: In function `flush_thread':
> arch/um/kernel/exec_kern.c:28: error: structure has no member named
> `tls_array'
> arch/um/kernel/exec_kern.c:28: error: structure has no member named
> `tls_array'
> make[1]: *** [arch/um/kernel/exec_kern.o] Error 1
> make: *** [arch/um/kernel] Error 2

Ok, that's my TLS patches indeed - I haven't even started working on them for 
x86_64.

> Last, 2.6.15-rc2 has the same gcc problems for x86, and amd64 fails
> with:

>   CC      arch/um/sys-x86_64/sysrq.o
>   SYMLINK arch/um/sys-x86_64/thunk.S
>   AS      arch/um/sys-x86_64/thunk.o
>   AR      arch/um/sys-x86_64/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../x86_64-pc-linux-gnu/bin/
>ld: init/built-in.o: relocation R_X86_64_32 against `a local symbol' can not
> be used when making a shared object; recompile with -fPIC init/built-in.o:
> could not read symbols: Bad value
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1

> Which can be worked around by enabling TT mode (or just static link?)

Probably the latter (static link)... However I must try compiling it, but no 
time now.

> I haven't tried to add -fPIC (not sure where it would go)

> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
