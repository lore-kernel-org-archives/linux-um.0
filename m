Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A943C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=; b=y2NCbz9ZK2o1EATVA/ku4gq6Jz
	6eW4Uf9WOWD93LhWoei1jk2c+bo9OREeslQT2fqcJnBK25vXRtH+wIM8laFWmP3NTwdFctFdrUeIB
	DT5dTCa78Y7ZnpPIi/uItYxHZerI1B+Da9/djIV/JDYO6c2syMsu8kcCjzevHnTxoPmui1R9UT0wq
	l26QJhgW6DT5Ah2UbOxkHTB9nnAfGrqGbh/hSH4zWp0gNOlE8dzteFJN8B//O9HlLnfJeOnEx6r+n
	C9LjmEA9UxcFZmtxC2tWNNtFElCDqe3RQ8XrSyPXrN/MxhZRaocaqU0ifqGRSVs3MJ/WZN2QYlzTC
	jrP0dmxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3iB-0000000BgqS-0mnZ;
	Thu, 19 Jun 2025 01:05:03 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i9-0000000Bgon-1N8W
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:05:02 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-234f17910d8so2940555ad.3
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295100; x=1750899900; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=;
        b=AKMY/ulkMWm9lMc9ZRfr6eHdsM04ktgZDL+up8XBbD9GcefMfnWb8x13vV/+N65J6q
         wZuhofReWFRpDqFSPYULcfF6iGxlndKKPBkl9lKfThfLEaBeG2aWqjhwgN4RVqQfTLhD
         R2QL7UY72cB/xm42qP4IhIAnzIwg+O/o0bGLKK6VmeKhceWq+2Mj+GC9PL7PqoGaLSG/
         B3QYfsYPYTo27hgue+rQj9zwyouz/yOCbXApmMOKUYvdpTQSTjpjL7jVMen/gasIlIel
         rZqmH+wBKLACeqDkzIkbMJJ6KzP/SQXTCUhSMAKdLurjuQmaQ6juuMwFFEYsJaim4meE
         tz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295100; x=1750899900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=;
        b=R5ytjxU8WKrpC38vvNaJwf5jhEKuqGnyQted+GBRXSCVNEpJGGpdSCBfpS1aotja+h
         ovU4lRPcL4ZwTdtMjqp/WwVcSJTjnNLa8uYZElVTnver400Jh1jf+R+DHF5AwL4op5ro
         SpvraROr9P3uAdj7l1Y86phk3cwaiQMsEb8XQiJPnbs6xRt1FnWBCM8WEY1wPYlTNmdm
         xcvbM7cOFyWPd7+kmuSuDsaletRJW4q4PbTYSxsvSDxW8eh8QkeTWcroa4xVUoWLo0dw
         480OA86ixA2oPOcdyUPO0hYROgYJ1sUla8M+C9JE6tCZU5MbRYiOvgqjL8Fp+Hw7kItw
         YqiA==
X-Gm-Message-State: AOJu0YwhLYK6Ts1VQhrtyMInOXYHIueN+8KEaCbTVSI42rohT7g6AUUn
	3tsOoUXR0ZGFbSbhMeh42rChMx7RB9m+Edt0aWyQmgRAIQz1qMUxhHO5
X-Gm-Gg: ASbGncvUWkqm0PVlrpAlCX2PPOBbyh89ofERHCDSADxWPyPISV+sbVwaZ1PHAWGhDO3
	pF/EdvuNTt2GOwdMz0syhldm/D6hJYmCCBK2Xo3qrDz1L5NaRiWjxs7UQm6n4INxczvULgg67kO
	l+RT2ib5pLKeneODUh6Za8JpqJDc1SgoOC+8TS/SJ6RnMQq++LkecRKNmNDBvAeOy0GwV2Slf8j
	TquPreB6Xz7jygjCD7VJ2fPo2NiClFpP/cKHGtzPjFLghkvOiYRWsvCeYHkyNH9frQp/tXA6/TA
	E0RkFZDZWcAMuotP6rBsfe6vAXtvxJRq6tIqzOETmyuyvClngIXZpNUm32sb5TbgAwL1JLdzdTw
	eK+rXbqF6fBTjtlmANTkX2ExxSuptUoBD
X-Google-Smtp-Source: AGHT+IHEfEf0xDbJiz2jaCicc177c2yJr3e0LtxHwGoglzOoG3x2iUoBfgOElxhGTXsOdLYdWMv4lA==
X-Received: by 2002:a17:903:2ace:b0:234:9068:ed99 with SMTP id d9443c01a7336-2366b14d37amr314881505ad.24.1750295100386;
        Wed, 18 Jun 2025 18:05:00 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0cffe6sm107190415ad.245.2025.06.18.18.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:59 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6DB93ED6540; Thu, 19 Jun 2025 10:04:57 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/13] um: nommu: add documentation of nommu UML
Date: Thu, 19 Jun 2025 10:04:16 +0900
Message-ID: <220f0cc76f3dca8e6958c107e77976f255e096e1.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180501_382437_0A815F20 
X-CRM114-Status: GOOD (  23.63  )
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
index 000000000000..1a988253bef8
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
+lmbench and (self-crafted) getpid benchmark (with v6.15-rc0 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  select-10    ,0.5224,28.3882,27.2839,3.0046
+  select-100   ,1.5641,30.3775,28.8091,3.8546
+  select-1000  ,11.6922,38.2021,32.5367,12.2568
+  syscall      ,0.1635,27.8278,24.8049,2.6957
+  read         ,0.3063,29.0073,23.5953,2.8127
+  write        ,0.2531,29.6342,26.3339,2.7932
+  stat         ,1.8827,41.2546,34.6495,3.3199
+  open/close   ,3.2548,67.5806,62.4781,6.4189
+  fork+sh      ,1108.8000,5618.0000,3604.6667,456.0476
+  fork+execve  ,519.1579,2242.8000,1425.7500,138.1316
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  getpid , 162 , 27049 , 24444 , 2696
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
index ac8ccc837bab..822efc04bbe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25753,6 +25753,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


