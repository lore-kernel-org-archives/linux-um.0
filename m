Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2ADCCFA1A
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=; b=KJnMpoOZ5oXwK1z+9y4PS8Eanp
	XwJt1UGobGWSAQxR4xP1EvOsX2x+jmZOF29xR1J4J0Zq1we+TW7WELznY9cq8UiFe+odyyxQIvmyg
	MS8IPLkBiyt1b01PHMy7RYRFWrMt3l+WU7w3qwfwiXoQHw3NEwvNA6ictwbtFXFDpdfUspJ7J0GZ5
	cMGP8tQUj5boHtj6OoyugZxB/ZygR83ZqpdeVL7FzEqhtWejy59h87zEdNeODINsVwtp8olU0YLkW
	e9Y5aOWqcMFQVfU1m2OcT84V+ukbxO3JXu9LD81PiwAAP3b+ezMqUBiumFmrE+2Tz39jpRJwIIZVl
	3u0ZQPVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxr-00000002j8I-0Pbr;
	Sat, 08 Nov 2025 08:06:27 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxo-00000002j5X-1gWT
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:25 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1267597b3a.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589183; x=1763193983; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=g7ONk9nL1UXLgKvk6Ep6aRL2uUA1yJBGqoAranzMnwCnClP2NZc05wpedsPNkUEXhQ
         upCEFvuXTxLBOD0vZRJwGVMbZZG16TOTJCw6URCoRir0aJxHELp8fzPOKfX3zCvtlcRL
         vbzwiluuprRex7lvdf/HFVqjmmKmtrn362PkAEndDJZMYD7YwkPZNNKm3kHxsStBG4ub
         oN6obZgh8NW/kkKqPNVFMciSXOq7ECwqcHzUZ8Ck/Xx75EXC7Fu55gRDWr8zRMbVma5w
         YNCBGUDjxrgu7C+9+g8h9rFZrg0enY8VgkH0huT1P6q1tSIWKj/SIbxGnbDhtfGyKVYl
         kzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589183; x=1763193983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=S6XCvRYDoZT/bB4R7GrGqG2QKwi+sxu9Ut+dCw0ZjSfSEkteI38Z+VfZLfi2Td2TYG
         qI3OaAFZMonkDqwm5JdeU034+bCXufslRqx078hO2V8don8tg9f+PzyYXT2vTxDYHrpy
         1ncy0eEBJnvvtdE3JRuT/8IQvJvtLNvnEp3pCJuaEk8yFeRfHKoRz8/+2Mj3UB9xLzNU
         2tz3NZZfb8vdSqPubyaa2/9xSUloPYCHQ3uoBKXi9LY0owmJh6DCccBvdgxgm+JEF5Oc
         s6Y3K/dHU1grV3/nyDWIFsZhVtAVlwEiJu92bcQMJD7RBdht2l1vPnHqcKH3qZaGbpso
         7JBA==
X-Gm-Message-State: AOJu0YxT0gePEUcB+dUb7JlpOTJB2pCQOKc2L+t8n64D5yYLSWWULuM5
	fffvrO+TYS4LmkTGFEkeMuUfS2qxxVf+whDZEClnxmWsjPAq7ahLR1JzH03OlA==
X-Gm-Gg: ASbGnctyPTCDkYvUw2KJIiKIi5HlJQ68RhLTE8eNJeHkXI/n0saT71lcviK6gb9p01P
	nh4h2X8bxfaxh9jb4x15lZBEng5CMdPs13XlrTedC4grhkl4en78ffA3GWBSVSix1dyM6ZHPRDa
	+dv6VWTmYkyjowa44w1a0pWl7lJApKzkAzEUNJegtQXtQ93MrNqHtNp8WlF0NE7Wp7VvsqSQ49b
	As+VgN1wyOrcgFI97tQggLPE3jseLaPW7SDGOO9TY+DZ/Nk3RLOoNXRD4/VRvQAMUajbC3LDWNY
	mzUDWBm4d5fGTga0SU08lL/DszUYY/ztrRpj/xMDXReCrhzxWN3tLRxfRWT/N2ou34fqxtf140P
	IcPuT+DVsHyxork6Ex+WyLL0U7jTvo6MajuNCjRCDATeBRymB5J8X0jq63Ak3DVWQS/ImBq1fhG
	pzOYRPD9NuRHms8NuAQcQndkAC/mFlyd2Xi7fPtxS0E7ZzS9sMJLNofXN4
X-Google-Smtp-Source: AGHT+IHPdEthRdTRwy4DjlAb9ugJodv/2lyawe799MFKgVDlI5BF9aTI1fKrT19wzsFKSQnRdicvzA==
X-Received: by 2002:a05:6a00:2d8b:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b22668fd88mr2351669b3a.16.1762589183437;
        Sat, 08 Nov 2025 00:06:23 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff74bfsm5237995b3a.27.2025.11.08.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:22 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2C76011388DD; Sat,  8 Nov 2025 17:06:21 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 12/13] um: nommu: add documentation of nommu UML
Date: Sat,  8 Nov 2025 17:05:47 +0900
Message-ID: <16940d31af89a3127acf29d23e10dcb9b7b9f4e3.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000624_447860_E6C49B90 
X-CRM114-Status: GOOD (  22.96  )
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
index 3da2c26a796b..2f227f56d04e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26764,6 +26764,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


