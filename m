Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM5i0-0000AT-Na for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:20:28 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM5hw-0001TR-NN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:20:28 -0700
Message-ID: <417D0D7C.8010307@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200410081912.i98JCFr20437@trolli.pdb.fsc.net>
	<200410130030.i9D0UF3P004368@ccure.user-mode-linux.org>
In-Reply-To: <200410130030.i9D0UF3P004368@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Implement vsyscall/sysenter, patch 1/4
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
Date: Mon, 25 Oct 2004 16:28:12 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
>>+	  (size <= (FIXADDR_USER_END - FIXADDR_USER_START)) && \
>>+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
>>+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END)))
> 
> 
> Don't the last two tests imply the truth of the first?
As you pointed out, the check is obsolete. But another check has
to be added, to avoid the possibility of wrong result because of
address wrapping.
The following fix should make it clean. Also, it defines some
address values to be unsigned long instead of long only.
And it exports the symbols vsyscall_ehdr and vsyscall_end by adding
EXPORT_SYMBOL() calls to user_syms.c

Bodo

---

diff -puNr a/arch/um/kernel/skas/include/uaccess.h b/arch/um/kernel/skas/include/uaccess.h
--- a/arch/um/kernel/skas/include/uaccess.h	2004-10-25 11:25:25.000000000 +0200
+++ b/arch/um/kernel/skas/include/uaccess.h	2004-10-25 13:39:16.216138051 +0200
@@ -14,9 +14,9 @@
  	 (((unsigned long) (addr) < TASK_SIZE) && \
  	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
  	 ((type == VERIFY_READ ) && \
-	  (size <= (FIXADDR_USER_END - FIXADDR_USER_START)) && \
  	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END)))
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
+	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))

  static inline int verify_area_skas(int type, const void * addr,
  				   unsigned long size)
diff -puNr a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
--- a/arch/um/os-Linux/elf_aux.c	2004-10-25 11:25:25.000000000 +0200
+++ b/arch/um/os-Linux/elf_aux.c	2004-10-25 13:22:53.454545125 +0200
@@ -20,10 +20,10 @@ typedef Elf64_auxv_t elf_auxv_t;
  char * elf_aux_platform;
  long elf_aux_hwcap;

-long vsyscall_ehdr;
-long vsyscall_end;
+unsigned long vsyscall_ehdr;
+unsigned long vsyscall_end;

-long __kernel_vsyscall;
+unsigned long __kernel_vsyscall;


  __init void scan_elf_aux( char **envp)
diff -puNr a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
--- a/arch/um/os-Linux/user_syms.c	2004-10-18 23:54:39.000000000 +0200
+++ b/arch/um/os-Linux/user_syms.c	2004-10-25 13:24:00.862405583 +0200
@@ -26,6 +26,9 @@ EXPORT_SYMBOL(printf);

  EXPORT_SYMBOL(strstr);

+EXPORT_SYMBOL(vsyscall_ehdr);
+EXPORT_SYMBOL(vsyscall_end);
+
  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
   * However, the modules will use the CRC defined *here*, no matter if it is
   * good; so the versions of these symbols will always match
diff -puNr a/include/asm-um/archparam-i386.h b/include/asm-um/archparam-i386.h
--- a/include/asm-um/archparam-i386.h	2004-10-25 11:25:25.000000000 +0200
+++ b/include/asm-um/archparam-i386.h	2004-10-25 13:24:58.975802006 +0200
@@ -58,9 +58,9 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
  } while(0);


-extern long vsyscall_ehdr;
-extern long vsyscall_end;
-extern long __kernel_vsyscall;
+extern unsigned long vsyscall_ehdr;
+extern unsigned long vsyscall_end;
+extern unsigned long __kernel_vsyscall;

  #define VSYSCALL_BASE vsyscall_ehdr
  #define VSYSCALL_END vsyscall_end



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
