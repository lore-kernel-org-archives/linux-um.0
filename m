Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA5E8B383
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ipAR8Fz6rCIEqHC+jf7avJINpUheKc7NzcjSyRooHM=; b=Jof7Yru3M+xKCWHseXSk3yj6Hd
	Bdj2GnTq3ZlkVUJqS98c7mbGOYyuV9DA6a7lr8hWIRWlFb3EJo1oYnqBnkVFy2GedJY5enPLOjZqj
	GT5r+PffFnVRN2j2b2VjuHarDCUI0wa9/9gMM1L2sYJPYaUe8sySve/PxbAKLaCl7GjRXBKdLPCGd
	BGUdTRjYkhGvxYwK6GbdrPZefbmqwCfXCf413H+fI8TxzGgSWep9GE1OWfWNG23HZbYN2svYPHaSl
	ImravwWqUEJWRdEr5vz/OE+szZ5dgLlQZtpQ0ZZ+6PF9VR0NXmfO/Dm6hIhj889SeTpgHMks3KlTN
	kbmgF4qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdG-00000007mKA-3EsJ;
	Wed, 04 Feb 2026 02:28:42 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdB-00000007mFm-1TJt
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:40 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-823075fed75so221013b3a.1
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172116; x=1770776916; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ipAR8Fz6rCIEqHC+jf7avJINpUheKc7NzcjSyRooHM=;
        b=M8kSR5d2+0Ez8vqcoAXTUZ3w6DA578Ci3x5pTekjZUxOZ8qDKWKx2fO+KFfDYhvLN9
         gY3LtuVkrnz51S0f3O1PcdlmoKnYf9L/z1f3ttdp/Ml5v1et4vZwatO//1m/hs2r1I5t
         tZwcCDPcElY8vrza3v8tJPD/qiSzrNPVgieNgbJLJgutDlPxyUAVPEHMu6x62kkctDvS
         Q8FSlmCKOkcs0LDD52jAnmucBCfwqIeK0oVhrAgQMcL8cl+xZqG1eIu93Z3v7uuaGPHr
         AvalImZcfxjTDvHlgECyCQ24BAfb1edAh+EE5WSTncKZCRRJ27ttElFprIyKQHB0rc9b
         9Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172116; x=1770776916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ipAR8Fz6rCIEqHC+jf7avJINpUheKc7NzcjSyRooHM=;
        b=Bo+kEP/+7oZKF/ODt0irSMzWCIv9k0HLH3PPMIH88rbnLaZVbZhCQQzrEyAmaPhOUE
         dr+TmDuBLcne8M7m4gRKlIC3vHcXDnv8EkjYzvFVssr0ddP+zifEXvx1Tezz617cEPQ8
         Z62gWm04y0jHFucPiJdHH6EPBxlqez8dSeOSQ5jNCw2541MiSHBvd7INvpCcu2leVyc6
         YzA6+Q0W++Piibj2ieI13xWf1LxqCJCj9grfLJjz1gpfOIZwNzf2k0rIkTG9/3GWpCCF
         MWkMDw8EEjt6pj6xxxW9tc+Ik6pXFg5FbHD9l1sE4yb2wOSfI7J4IMagnshAECytPm/o
         sAOw==
X-Gm-Message-State: AOJu0YwcSjXfLxnSj3dlfNYeBZH86Ecf4k04Pi2D4NtNeXIQjO36/6lz
	Ktye6pv4kEgGzLAj+a6SdBtB8RCd1E7+eBfbB+gfnWdoEkxnGU5qXt2/AcwQxQvDBHw=
X-Gm-Gg: AZuq6aJNuvsPlpycT5fKzGsUClIpIzHuccMrttN+8Ao0n1EkryRtFwHuxLJ0hh5Imi+
	OHt2ocrIuK2Pxl78rnmerPvpBUEXkZouCyzaQskILYLZwFgMxhJJ+HeLXHq6YLc+rjPDxRuX4MY
	2xwBy9cybcYr3/k7LoRgo1n2JPhGBLMoL/e6K/IzStpbeg4I/07k/7lcsl+OYwv1pqPfvXHDTuP
	9E1kxjbQMrKXYlPMhBKh3SmBfubrksUbkWSZmYcJG6iWmZjvFuVef7MmSpOrc7x8qo0mTiIkxHF
	x15KoTwGSAe4/C7foMviigbn0POK21bXI0kwRrC+hzvRCBGUv3wHOjm4UszQnhb11ubrvuVx1Tr
	3ZmJuBzYJsL58yfP/P+Lj4amyaiFyNeqgTrfaneprEjI52AGPcHBr2jG3vF3DY9vOlB6+bisrMI
	QHo1whzakPHOwfEKvVNQnsGTTUa46j/fXE6r1zeVcfqpQoUBG/YH9vTAbifxG37uIA4hWiJtoVi
	dnMAtGRfqs72I84
X-Received: by 2002:a05:6a00:3927:b0:81f:be27:8d16 with SMTP id d2e1a72fcca58-8241c676169mr1501741b3a.21.1770172116190;
        Tue, 03 Feb 2026 18:28:36 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d47b875sm682709b3a.55.2026.02.03.18.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:34 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D1AE91200C47; Wed,  4 Feb 2026 11:28:33 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 12/13] um: nommu: add documentation of nommu UML
Date: Wed,  4 Feb 2026 11:28:10 +0900
Message-ID: <950680efa307cd1512ffb029c6d04abb0eed4deb.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182838_283288_0C6E9FAE 
X-CRM114-Status: GOOD (  24.07  )
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
 Documentation/virt/uml/nommu-uml.rst | 181 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..b359af1155bb
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UML has been built with CONFIG_MMU since day 0.  The patchset
+introduces the nommu mode on UML in a different angle in order to
+cover broader code to be executed over UML.
+
+.. contents:: :local:
+
+What is it for ?
+================
+
+- To exercises nommu code over UML (and over KUnit)
+- Reduce syscall latency triggered with the interactions of multiple
+  processes
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
+  works
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
+- alternate syscall entrypoint
+- alternate syscall hook with a different seccomp filter
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
+   ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n --kconfig_add CONFIG_KUNIT_UML_PCI=n
+
+To run a typical Linux distribution, we need nommu-aware userspace.
+We can use a stock version of Alpine Linux with nommu-built version of
+busybox and musl-libc, which are available as additional packages.
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
+We plan to upstream the apk packages for busybox and musl so that we
+can follow the proper procedure to set up the root filesystem.
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
+Since this port is a kernel of nommu architecture, the implementation
+inherits the characteristics of other nommu kernels (riscv, arm, etc),
+described below.
+
+- vfork(2) should be used instead of fork(2)
+- ELF loader only loads PIE (position independent executable) binaries
+- processes share the address space among others
+- mmap(2) offers a subset of functionalities (e.g., unsupported
+  MAP_FIXED)
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
+- introduction at FOSDEM 2026
+ - https://fosdem.org/2026/schedule/event/HWLQDV-nommu-uml-thehajime/
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d044a58cbfe..00912c1a70c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27195,6 +27195,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


