Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l23Fz-0002WA-5K
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 02:30:03 +0000
Received: by mail-pj1-x1030.google.com with SMTP id m5so1179349pjv.5
 for <linux-um@lists.infradead.org>; Tue, 19 Jan 2021 18:30:02 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v8 20/20] um: lkl: add documentation
Date: Wed, 20 Jan 2021 11:27:25 +0900
Message-Id: <043677211bb5562397c511911e7861c3e217611b.1611103406.git.thehajime@gmail.com>
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, thehajime@gmail.com, retrage01@gmail.com

A document describing brief introduction of LKL, why it is needed, and
how it is used is added.  The document is located under uml/ directory.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/virt/uml/lkl.txt | 48 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                    | 10 +++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/virt/uml/lkl.txt

diff --git a/Documentation/virt/uml/lkl.txt b/Documentation/virt/uml/lkl.txt
new file mode 100644
index 000000000000..4942b7f093c5
--- /dev/null
+++ b/Documentation/virt/uml/lkl.txt
@@ -0,0 +1,48 @@
+
+Introduction
+============
+
+Library mode of UML, a.k.a. LKL (Linux Kernel Library), is aiming to allow
+reusing the Linux kernel code as extensively as possible with minimal effort and
+reduced maintenance overhead.
+
+Examples of how LKL can be used are: creating userspace applications (running on
+Linux and other operating systems) that can read or write Linux filesystems or
+can use the Linux networking stack, creating kernel drivers for other operating
+systems that can read Linux filesystems, bootloaders support for reading/writing
+Linux filesystems, etc.
+
+With LKL, the kernel code is compiled into an object file that can be directly
+linked by applications. The API offered by LKL is based on the Linux system call
+interface.
+
+LKL is implemented as one of the mode of UML (arch/um), and it internally uses
+sub-architecture (SUBARCH) of UML (SUBARCH=lkl). It uses host operations
+defined by the application or a host library (tools/um).
+
+
+Supported hosts
+===============
+
+The supported host for now is Linux (x86 architecture) userspace applications.
+
+
+Building LKL the host library and LKL applications
+==================================================
+
+    $ make ARCH=um SUBARCH=lkl defconfig
+    $ make ARCH=um SUBARCH=lkl
+
+will build LKL as a object file, it will install it in tools/um together with
+the headers files in tools/um/include then will build the host library, tests
+and a few of application examples:
+
+* tools/testing/selftests/um/boot.c - a simple applications that uses LKL and
+  exercises the basic LKL APIs
+
+* tools/testing/selftests/um/disk.c - a simple applications that tests LKL and
+  exercises the basic filesystem-related LKL APIs
+
+Those tests can run with the following kselftest command:
+
+    $ make ARCH=um SUBARCH=lkl TARGETS="um" kselftest
diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..8587a9715020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18613,6 +18613,16 @@ F:	arch/um/
 F:	arch/x86/um/
 F:	fs/hostfs/
 
+USER-MODE LINUX (UML) LIBRARY MODE
+M:	Octavian Purdila <tavi.purdila@gmail.com>
+M:	Hajime Tazaki <thehajime@gmail.com>
+L:	linux-um@lists.infradead.org
+S:	Maintained
+T:	https://github.com/lkl/linux
+F:	arch/um/lkl/
+F:	tools/testing/selftests/um/
+F:	tools/um/
+
 USERSPACE COPYIN/COPYOUT (UIOVEC)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 S:	Maintained
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

