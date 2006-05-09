Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdOPx-000490-DL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 02:22:09 -0700
Received: from mtagate4.de.ibm.com ([195.212.29.153])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FdOPv-0007Tt-NC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 02:22:09 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.6/8.13.6) with ESMTP id k499Lv0v090828
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 9 May 2006 09:21:57 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k499NFaY144132 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 9 May 2006 11:23:15 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k499Lurv010419 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 9 May 2006 11:21:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
Subject: [uml-devel] Re: [PROBLEM] UML is killed by SIGALRM
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
Date: Tue, 9 May 2006 11:21:54 +0200
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

> UML in Linus' head doesn't start on my machine whereas 2.6.17-rc3 works 
> fine:
> 
> penberg@haji ~/src/linux/2.6 $ ./linux
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Alarm clock

No idea what might cause this. Guess there are no messages on the console?

> I did a git bisect which found the offending commit:
> 
>     [IPV4]: inet_init() -> fs_initcall
> 
>     Convert inet_init to an fs_initcall to make sure its called before any
>     device driver's initcall.

Could you try the patch below? It will move inet_init a bit down the chain of
the initcall list. Even though I doubt it will help...
---

 arch/i386/kernel/vmlinux.lds.S |    1 +
 include/asm-um/common.lds.S    |    1 +
 include/linux/init.h           |    6 ++++--
 net/ipv4/af_inet.c             |    2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 8831303..001e04b 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -111,6 +111,7 @@ SECTIONS
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff --git a/include/asm-um/common.lds.S b/include/asm-um/common.lds.S
index 1010153..02d2353 100644
--- a/include/asm-um/common.lds.S
+++ b/include/asm-um/common.lds.S
@@ -49,6 +49,7 @@ #include <asm-generic/vmlinux.lds.h>
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
 
diff --git a/include/linux/init.h b/include/linux/init.h
index 93dcbe1..8699dd5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -95,8 +95,9 @@ #define postcore_initcall(fn)		__define_
 #define arch_initcall(fn)		__define_initcall("3",fn)
 #define subsys_initcall(fn)		__define_initcall("4",fn)
 #define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+#define net_initcall(fn)		__define_initcall("6",fn)
+#define device_initcall(fn)		__define_initcall("7",fn)
+#define late_initcall(fn)		__define_initcall("8",fn)
 
 #define __initcall(fn) device_initcall(fn)
 
@@ -178,6 +179,7 @@ #define core_initcall(fn)		module_init(f
 #define postcore_initcall(fn)		module_init(fn)
 #define arch_initcall(fn)		module_init(fn)
 #define subsys_initcall(fn)		module_init(fn)
+#define net_initcall(fn)		module_init(fn)
 #define fs_initcall(fn)			module_init(fn)
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0a27745..9803a57 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1257,7 +1257,7 @@ out_unregister_udp_proto:
 	goto out;
 }
 
-fs_initcall(inet_init);
+net_initcall(inet_init);
 
 /* ------------------------------------------------------------------------ */
 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
