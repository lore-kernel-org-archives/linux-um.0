Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D715CAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=; b=h4A9rWJkNynp+NfKMug+oy1HuF
	MlZN7CE+O4byJAX6VmERa/uCsnkMokIsP4iHlC2q5s7fk9GXnBCNiiZEAegEk5lYO4i4NxN8atsMm
	4YYmdUDpjxNJpMPTyIeKv4FbJrTNzF41YApmGYK95dTZOH55H79UwMgVZkX3q6EGjaC8r3w4AaJC6
	OsrsM9ETE27dSZ8l+c6qX7PODKTxWJ3iROZanBLwm0dFrlADg6EawNIZ+yXruVQymnDqupOkl3iXJ
	eSktXJ1Yw/aMHdpyxR7nZTQzE9HngN3hxEarfraVwhueGE/IGe46R0ZjdQuJ9q9QiavcHPlJQ9B1c
	T2q8sbdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ew-0000000GZL6-1Lqy;
	Thu, 18 Sep 2025 07:39:38 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Et-0000000GZHY-0MLT
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:36 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so473667a91.0
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181174; x=1758785974; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=UVGISm/ZbUu7AT3JpVCyVnkNkjiTQuX4JIYyZn5o2ihiimFS/fJG4hdYEWFllbPslG
         EF0WJhiGzCNNVLEh4//fJTUCsK1mZUIS2Hyhttw88kr7sqqp1ElMeJISIFrTUq8XBpL/
         Dn8DUJ0fqG0KHBFxdsjVmrYdZdXqrxmUU1RjPbNvzz1KbO68O7lSBgOLXmqG/terfKHN
         23c8OuchHToI/puAuWrrI0uVonPwKVDWJLadKW4jmK2d/4SSKXHiWoFTakF8b00YrPOy
         7oViYrHwbi7XJ+IXQX29FopzMdEaj7n5kG+fQ0g3g6U8N/rFmIJB30/Y5upL7cOgjw9N
         JzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181174; x=1758785974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=OqQpXBPmG2mRRZ3/YkcssHsUlSSntY81Bu6J3mlftinzrQ/kQJVDV7+hBTYMix3djj
         1QjRX4+1mgQfH7Pc7s9Wfi5IJgynrXT0DgxSEi4agUbkFxXAJb6zFdFJqMzCZv9+t2FV
         YTAw89qsJEPb/G+kjaz1w0ckAzB1QwpBcQXzc9QaS357biCIkQUlT12/HeUERGDAYMEi
         e0DJLzkdIf5j2/ilIyxRqsyDRDL95yDGPPQnRqrJECbDUmCK+8kpy7gyjptn6/1VxplU
         ZdSeEoAkex3ZGGTbbZWCl6uowdOCVVeNRA7sNg6cwlkIKD8nAEFGJ1BOvdNoKbM2rjHr
         qU/w==
X-Gm-Message-State: AOJu0YzjQq/Yb8Sqa1xop0gS8W6qYbc5onlLtKAO2D7lqdTGExwPXZ7Q
	CSCQZCOmRbFaQyYSO2mXnysCAY92un1zVGOx2tlB6OVOUMRcFKx/gyyR
X-Gm-Gg: ASbGncvwOSXOfHx/guVtqAiurWj/6fuA4Nes3GYB5wSt27h+5iImqpbswhO/DmKKxGi
	EoLAT2P7WbyRfuyn3hbWgvs8aFFMlr8y8azY7+PWbOM87abDbM//UssjGLmOxxCkPdDKysoz6Gi
	8WPOkIerhTwRURXwXw3xVhX1Rsp87aoo0Cl0aBG+C7I7R7F8RSX2SBQ9WapLVY/4sG7LieKoZQ0
	XvUzyNYib1TLCDYg1DUyoCG13k0PHDDqfdGdDDvDsKz6u3ijm3lJ0LrTec0dC2hXapJ2ojKaU0r
	nj51cTqkjXEGTCzxs2Plo+l423zsS8WzNyynwjAlLTWWDE/rrdaVbTwgByg/mbPUvzTRebZ2Q69
	7i6DsfdaJWfOvjmzHa5z1LINWCMrXlSlVIrpGgbu41ukWkILSckZbLn6pT0uvRCBJGvAUJ8HYd6
	0kx83FarSZ7kI=
X-Google-Smtp-Source: AGHT+IHxkUslwpxevE9bI62FFSn+jT5ev+hfJBOVMTNtFsfSx8g7hj3BL9W278Q7NiAXFoCSS/Poyg==
X-Received: by 2002:a17:90b:1dc7:b0:32b:aee1:18d5 with SMTP id 98e67ed59e1d1-32ee3f76419mr6422504a91.29.1758181174135;
        Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273ec20sm4537412a91.16.2025.09.18.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:33 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AB4491062112; Thu, 18 Sep 2025 16:39:32 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 12/13] um: nommu: add documentation of nommu UML
Date: Thu, 18 Sep 2025 16:39:07 +0900
Message-ID: <375e45e659d289d5343d7852303e1c04d6077a4c.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003935_245108_2167AE8D 
X-CRM114-Status: GOOD (  23.70  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This commit adds an initial documentation for !MMU mode of UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/virt/uml/nommu-uml.rst | 180 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 181 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..f049bbc697d1
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UML has been built with CONFIG_MMU since day 0.  The patchset
+introduces the nommu mode on UML in a different angle from what Linux
+Kernel Library tried.
+
+.. contents:: :local:
+
+What is it for ?
+================
+
+- Alleviate syscall hook overhead implemented with ptrace(2)
+- To exercises nommu code over UML (and over KUnit)
+- Less dependency to host facilities
+
+
+How it works ?
+==============
+
+To illustrate how this feature works, the below shows how syscalls are
+called under nommu/UML environment.
+
+- boot kernel, install seccomp filter if ``syscall`` instructions are
+  called from userspace memory based on the address of instruction
+  pointer
+- (userspace starts)
+- calls ``vfork``/``execve`` syscalls
+- ``SIGSYS`` signal raised, handler calls syscall entry point ``__kernel_vsyscall``
+- call handler function in ``sys_call_table[]`` and follow how UML syscall
+  works.
+- return to userspace
+
+
+What are the differences from MMU-full UML ?
+============================================
+
+The current nommu implementation adds 3 different functions which
+MMU-full UML doesn't have:
+
+- kernel address space can directly be accessible from userspace
+  - so, ``uaccess()`` always returns 1
+  - generic implementation of memcpy/strcpy/futex is also used
+- alternate syscall entrypoint without ptrace
+- alternate syscall hook
+  - hook syscall by seccomp filter
+
+With those modifications, it allows us to use unmodified userspace
+binaries with nommu UML.
+
+
+History
+=======
+
+This feature was originally introduced by Ricardo Koller at Open
+Source Summit NA 2020, then integrated with the syscall translation
+functionality with the clean up to the original code.
+
+Building and run
+================
+
+::
+
+   make ARCH=um x86_64_nommu_defconfig
+   make ARCH=um
+
+will build UML with ``CONFIG_MMU=n`` applied.
+
+Kunit tests can run with the following command::
+
+   ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n
+
+To run a typical Linux distribution, we need nommu-aware userspace.
+We can use a stock version of Alpine Linux with nommu-built version of
+busybox and musl-libc.
+
+
+Preparing root filesystem
+=========================
+
+nommu UML requires to use a specific standard library which is aware
+of nommu kernel.  We have tested custom-build musl-libc and busybox,
+both of which have built-in support for nommu kernels.
+
+There are no available Linux distributions for nommu under x86_64
+architecture, so we need to prepare our own image for the root
+filesystem.  We use Alpine Linux as a base distribution and replace
+busybox and musl-libc on top of that.  The following are the step to
+prepare the filesystem for the quick start::
+
+     container_id=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
+     docker start $container_id
+     docker wait $container_id
+     docker export $container_id > alpine.tar
+     docker rm $container_id
+
+     mnt=$(mktemp -d)
+     dd if=/dev/zero of=alpine.ext4 bs=1 count=0 seek=1G
+     sudo chmod og+wr "alpine.ext4"
+     yes 2>/dev/null | mkfs.ext4 "alpine.ext4" || true
+     sudo mount "alpine.ext4" $mnt
+     sudo tar -xf alpine.tar -C $mnt
+     sudo umount $mnt
+
+This will create a file image, ``alpine.ext4``, which contains busybox
+and musl with nommu build on the Alpine Linux root filesystem.  The
+file can be specified to the argument ``ubd0=`` to the UML command line::
+
+  ./vmlinux ubd0=./alpine.ext4 rw mem=1024m loglevel=8 init=/sbin/init
+
+We plan to upstream apk packages for busybox and musl so that we can
+follow the proper procedure to set up the root filesystem.
+
+
+Quick start with docker
+=======================
+
+There is a docker image that you can quickly start with a simple step::
+
+  docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:3.20.3-um-nommu
+
+This will launch a UML instance with an pre-configured root filesystem.
+
+Benchmark
+=========
+
+The below shows an example of performance measurement conducted with
+lmbench and (self-crafted) getpid benchmark (with v6.17-rc5 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  select-10    ,0.5319,36.1214,24.2795,2.9174
+  select-100   ,1.6019,34.6049,28.8865,3.8080
+  select-1000  ,12.2588,43.6838,48.7438,12.7872
+  syscall      ,0.1644,35.0321,53.2119,2.5981
+  read         ,0.3055,31.5509,45.8538,2.7068
+  write        ,0.2512,31.3609,29.2636,2.6948
+  stat         ,1.8894,43.8477,49.6121,3.1908
+  open/close   ,3.2973,77.5123,68.9431,6.2575
+  fork+sh      ,1110.3000,7359.5000,4618.6667,439.4615
+  fork+execve  ,510.8182,2834.0000,2461.1667,139.7848
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  getpid , 161 , 34477 , 26242 , 2599
+
+(um-nommu(s) is with seccomp syscall hook, um-mmu(s) is SECCOMP mode,
+respectively)
+
+Limitations
+===========
+
+generic nommu limitations
+-------------------------
+Since this port is a kernel of nommu architecture so, the
+implementation inherits the characteristics of other nommu kernels
+(riscv, arm, etc), described below.
+
+- vfork(2) should be used instead of fork(2)
+- ELF loader only loads PIE (position independent executable) binaries
+- processes share the address space among others
+- mmap(2) offers a subset of functionalities (e.g., unsupported
+  MMAP_FIXED)
+
+Thus, we have limited options to userspace programs.  We have tested
+Alpine Linux with musl-libc, which has a support nommu kernel.
+
+supported architecture
+----------------------
+The current implementation of nommu UML only works on x86_64 SUBARCH.
+We have not tested with 32-bit environment.
+
+
+Further readings about NOMMU UML
+================================
+
+- NOMMU UML (original code by Ricardo Koller)
+ - https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..2bc267220b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26300,6 +26300,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


