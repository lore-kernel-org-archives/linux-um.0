Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A3C0218C
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7D/0VglDc+sS+puHxMR1P5iA8UCVHzuI7x46XB7Bm0=; b=rLbe2dM07p2fFrscc35hQP3cj9
	bTyqvPu09p+HygSGF9GtYA/uhxuwznI2P3CcHoPCCqpd8Nfmp1Fx8WxKCx10+bp3zt6GP+hlNSKZp
	IaHsIywMZXx6n7ipburx+Kfs+Y7oJ++DgmrolqUVhJJh4icIa+hp74U9hdy4bee3e12jKpIcDcoOD
	IQEJ+z6gr8y0++afSYauAjsXYZg/F+6EGkszYzvSsDA8QKlvrt+/ByYkeQFLxPOIcSMCBiUYDzt+M
	Mbnv2SGscdC2BPFaO/yDsrOsnk+VnZHzWZ4F18UsywslPP31vrAslcEh6XjT1KeibW66YJJMTXQpA
	2f6HL9EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr4-00000004nVv-3vfF;
	Mon, 20 Jan 2025 06:01:46 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkq9-00000004nJW-0BNk
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:50 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21628b3fe7dso71593985ad.3
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352848; x=1737957648; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7D/0VglDc+sS+puHxMR1P5iA8UCVHzuI7x46XB7Bm0=;
        b=V8Gy/yovZbM0EX9Ohj/SJ+kgO0SQ7pXuxhdAW7s1dDI8QcUbfw6I0Zt8v/voy22fFP
         5XjSL7y+6eXCKUHYLf7DlqnrSOrxAOPKgvH/n10zVa1nn8ffv1IFFJ8r4Y89NZOQVYu6
         BWMMwRACY/KEfc77DbsJHBuiRFvVED0ibSp2QwxjMElJbIQxHcQQwgSmVN7BwEcahvYZ
         mgMiE6stPKhQ/MEb/C8siDdNE/etD0wT0mRp0S8ln32TczGDfD5hru+z4fqr3pizWSPp
         KygAkoODRYiWzI72bJnOpd3IsMyfPvMZ2jFxXqFic3LJJdviViNBJElwrcXjOYRpBoyD
         FOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352848; x=1737957648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7D/0VglDc+sS+puHxMR1P5iA8UCVHzuI7x46XB7Bm0=;
        b=Lv/MBhOIg0zNGQTsnSNNoJXBPm8wbpn2kPeuN9XqNNj8tLFQh3iC/JmTIxIPVbC60r
         muyW7DmT8JPv1CukPtV6sO/XorCxiBgMmpRIwma9w2j7QD/t0ecYKZByVzPii1/4VuiL
         xmt0c55bUxoqlH2CtMl11xJCB/tv9cjhYrEKB0xy687TVX41LzrHcS3gto2B1dI+b14e
         mypU4BoPCJmH+HlbS3MoC+7IO34rFAayMmHms9yhkjU0T08CUexZ7l/U45sdjKJHYOe1
         r21YkuESW9g/LMs7BGdiPesmbv0w0VW5Y72C38Pi1EmbPZDhr+pDWwHjXUs3LLG6zYgy
         rNaw==
X-Gm-Message-State: AOJu0YyN/u03T4QyRVetV+1zxtwylfjHVumn0dLabbO+bDche6yH2D88
	D9F5iPy6fzQR07rHbPjaPswUbzMx9l67feVOYA0jXK7yysM87DGL
X-Gm-Gg: ASbGncteYcSbwEAihSBlFS0try8c2yjif3jbvMV80gzUyx39NODN6D7DSYznKCbztbe
	niE7eSL9fRf57MJqLxcMO9HzcTzfMJxATQ4aO/tE3qZHyVXNerdM+olzTPnx+grQNxnhXZmxlIV
	hPrDQ21wtkMJF120/H/nJUHE2jcXsxG++61TCGmI51WAflvgiSmQLgD1zxV2kAKH9dTrPhpf4WV
	PRCL5u1CrHudJLNOiELoNCH8iw0FeWXhaBw6MY5iCBIn0cF9nrtILaVrNVgWUyNSuwIFf8TS1fx
	FTxcbx+4d/+IKbQ2n5om7mYHKr4yNjyM2Yrd3p29lA==
X-Google-Smtp-Source: AGHT+IEi92Jt1WoMBFkUKxD05WiNBtyft4S+zz4g3J3ta9gKvbkfXRPsgqVu27Qa9WkiM6DZSL37EQ==
X-Received: by 2002:a05:6a20:2450:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1eb215902e2mr20652391637.28.1737352848042;
        Sun, 19 Jan 2025 22:00:48 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc3232a4sm6034367a12.30.2025.01.19.22.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:46 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 03523E2753E; Mon, 20 Jan 2025 15:00:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 12/13] um: nommu: add documentation of nommu UML
Date: Mon, 20 Jan 2025 15:00:14 +0900
Message-ID: <96eb5943a780d3cc0b0fca66285d2d060a6d2db3.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220049_173734_CB6B44C9 
X-CRM114-Status: GOOD (  23.19  )
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
 Documentation/virt/uml/nommu-uml.rst | 177 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 178 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..2034ba4d397a
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,177 @@
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
+lmbench and (self-crafted) getpid benchmark (with v6.13-rc5 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-nommu(s)
+
+  select-10    ,0.5569,27.0149,2.9772
+  select-100   ,2.3964,26.9242,3.8947
+  select-1000  ,20.8101,39.6842,12.8161
+  syscall      ,0.1735,25.7706,2.6997
+  read         ,0.3488,25.7922,2.7923
+  write        ,0.2861,26.5560,2.7961
+  stat         ,1.9171,36.2893,3.2678
+  open/close   ,3.8475,62.2847,6.3909
+  fork+sh      ,1159.0000,5230.3333,409.1786
+  fork+execve  ,535.3000,2075.8333,135.4074
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-nommu(s)
+
+  getpid, 172 , 24979 , 2691
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
index 910305c11e8a..fc5473fd528b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24470,6 +24470,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


