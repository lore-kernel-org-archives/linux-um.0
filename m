Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiB7s-00032r-RK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 07:11:16 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FiB7s-0002U1-1j for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 07:11:16 -0700
Received: from wx-out-0102.google.com ([66.249.82.207])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FiB7p-00034n-M9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 07:11:15 -0700
Received: by wx-out-0102.google.com with SMTP id s10so508238wxc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 May 2006 07:11:12 -0700 (PDT)
Message-ID: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
From: "Nikola Knezevic" <laladelausanne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Disposition: inline
Subject: [uml-devel] Problem in compiling without optimisations
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
Date: Mon, 22 May 2006 16:11:11 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,
When I change Makefile to have -O0 instead of -O2, this is what I get
after make ARCH=um:

  CC      arch/um/kernel/skas/clone.o
arch/um/include/sysdep/stub.h: In function 'remap_stack':
arch/um/include/sysdep/stub.h:90: warning: asm operand 7 probably
doesn't match constraints
arch/um/include/sysdep/stub.h:90: error: impossible constraint in 'asm'
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

This is the culprit:
static inline void remap_stack(int fd, unsigned long offset)
{
        __asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
                          "movl %7, %%ebx ; movl %%eax, (%%ebx)"
                          : : "g" (STUB_MMAP_NR), "b" (UML_CONFIG_STUB_DATA),
                            "c" (UM_KERN_PAGE_SIZE),
                            "d" (PROT_READ | PROT_WRITE),
                            "S" (MAP_FIXED | MAP_SHARED), "D" (fd),
                            "a" (offset),
                            "i" (&((struct stub_data *)
UML_CONFIG_STUB_DATA)->err)
                          : "memory");
}


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
