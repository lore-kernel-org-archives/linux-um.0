Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIvj1-00056R-CK
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 14:49:16 +0000
Received: by mail-pj1-x1043.google.com with SMTP id jz1so6431062pjb.0
 for <linux-um@lists.infradead.org>; Mon, 30 Mar 2020 07:49:15 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 21/25] um lkl: add documentation
Date: Mon, 30 Mar 2020 23:45:53 +0900
Message-Id: <b5752382991a21a338d098276eb1d3e764fdf937.1585579244.git.thehajime@gmail.com>
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Conrad Meyer <cem@FreeBSD.org>, Octavian Purdila <tavi.purdila@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, Akira Moroo <retrage01@gmail.com>, Thomas Liebetraut <thomas@tommie-lie.de>, Patrick Collins <pscollins@google.com>, linux-kernel-library@freelists.org, Chenyang Zhong <zhongcy95@gmail.com>, Yuan Liu <liuyuan@google.com>, Gustavo Bittencourt <gbitten@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

A document describing brief introduction of LKL, why it is needed, and
how it is used is added.  The document is located under uml/ directory.

Cc: Chenyang Zhong <zhongcy95@gmail.com>
Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Gustavo Bittencourt <gbitten@gmail.com>
Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Motomu Utsumi <motomuman@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 Documentation/virt/uml/lkl.txt | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/virt/uml/lkl.txt

diff --git a/Documentation/virt/uml/lkl.txt b/Documentation/virt/uml/lkl.txt
new file mode 100644
index 000000000000..f6d581092331
--- /dev/null
+++ b/Documentation/virt/uml/lkl.txt
@@ -0,0 +1,64 @@
+
+Introduction
+============
+
+LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code as
+extensively as possible with minimal effort and reduced maintenance overhead.
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
+LKL is implemented as one of the mode of UML (arch/um). It uses host operations
+defined by the application or a host library (tools/lkl/lib).
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
+    $ make -C tools/lkl
+
+will build LKL as a object file, it will install it in tools/lkl/lib together
+with the headers files in tools/lkl/include then will build the host library,
+tests and a few of application examples:
+
+* tests/boot - a simple applications that uses LKL and exercises the basic LKL
+  APIs
+
+* tests/net-test - a simple applications that uses network feature of LKL and
+  exercises the basic network-related APIs
+
+* fs2tar - a tool that converts a filesystem image to a tar archive
+
+* cptofs/cpfromfs - a tool that copies files to/from a filesystem image
+
+* lklfuse - a tool that can mount a filesystem image in userspace,
+  without root privileges, using FUSE
+
+
+Building LKL on Ubuntu
+-----------------------
+
+    $ sudo apt-get install libfuse-dev libarchive-dev xfsprogs
+
+    # Optional, if you would like to be able to run tests
+    $ sudo apt-get install btrfs-tools
+    $ pip install yamlish junit_xml
+
+    $ make -C tools/lkl
+
+    # To check that everything works:
+    $ cd tools/lkl
+    $ make run-tests
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

