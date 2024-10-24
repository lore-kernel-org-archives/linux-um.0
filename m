Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221B1CE8E7A
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=524e70GR1gtFXLgn0SjdDU5Um2Vt0VlGXQCWotf79HE=; b=xTNh0ThuS11bbFYh+P7JY29izf
	BK4CtGOs/9tTpvcqBxPdOu15C+6A4k+blOeG11rgUKlzBCGnPnDC96KjUPdVKDlGhb32ti248cEkD
	kuezg1vVZzfpw8iigLIAjj6jM+5cuzwujnBGfTKYA1qkE8bfjiG7yLDnbIh1//9hYlQaWHm6Sxks8
	pluwGsNo+vTfjCQm/DRcDO0ro/EIfQ12W6eVPYYRfsI8NDcZxkKciHPhmCbN+M6Mmxcb2sA2zj49R
	o3zbNKHhdqRvL7lXAG1GJegt2mpIigHC5p43+OtvDHNDb5Ha9sdecx1cbcVUHsrYPMEHxLsE1qBEM
	Vg+UM9ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3yJ8-00000000atA-4ByD;
	Thu, 24 Oct 2024 13:55:23 +0000
Received: from out0-193.mail.aliyun.com ([140.205.0.193])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3yGq-00000000acL-0ZTF
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 13:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729777972; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=524e70GR1gtFXLgn0SjdDU5Um2Vt0VlGXQCWotf79HE=;
	b=YjLtEQNH8nMm423qBmPIPG/KANe80b/uzzG0FGCpNyWIhpo0uQiUrOdDZ4LZ15XMpiHq/Lk4Yefu/JzyWwSlk3vNwCnIoKztbXWEe2gWoinUVBRtRP27N+aXNMLbVLxrpRBumqANPGxgZ94TqzjT/TrNmUsL1KR6so8/G8soQxc=
Received: from 30.171.204.251(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZraP9TT_1729777959 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 21:52:48 +0800
Message-ID: <e6e0b12d-a5b4-41e7-bccc-a14626b4dde6@antgroup.com>
Date: Thu, 24 Oct 2024 21:52:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 9/9] um: pass FD for memory operations when needed
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20241023140827.136550-1-benjamin@sipsolutions.net>
 <20241023140827.136550-10-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20241023140827.136550-10-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_065300_712160_A3DD6DEB 
X-CRM114-Status: GOOD (  11.32  )
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

On 2024/10/23 22:08, Benjamin Berg wrote:
[...]
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index c663b67c3fd3..a29957e021f3 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -16,6 +16,7 @@
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include <sys/stat.h>
> +#include <sys/socket.h>
>  #include <asm/unistd.h>
>  #include <as-layout.h>
>  #include <init.h>
> @@ -153,7 +154,39 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
>  	int ret;
>  
>  	do {
> +		const char byte = 0;
> +		struct iovec iov = {
> +			.iov_base = (void *)&byte,
> +			.iov_len = sizeof(byte),
> +		};
> +		union {
> +			char data[CMSG_SPACE(sizeof(mm_idp->syscall_fd_map))];
> +			struct cmsghdr align;
> +		} ctrl;
> +		struct msghdr msgh = {
> +			.msg_iov = &iov,
> +			.msg_iovlen = 1,
> +		};
> +
>  		if (!running) {
> +			if (mm_idp->syscall_fd_num) {
> +				unsigned int fds_size =
> +					sizeof(int) * mm_idp->syscall_fd_num;
> +				struct cmsghdr *cmsg;
> +
> +				msgh.msg_control = ctrl.data;
> +				msgh.msg_controllen = CMSG_SPACE(fds_size);
> +				cmsg = CMSG_FIRSTHDR(&msgh);
> +				cmsg->cmsg_level = SOL_SOCKET;
> +				cmsg->cmsg_type = SCM_RIGHTS;
> +				cmsg->cmsg_len = CMSG_LEN(fds_size);
> +				memcpy(CMSG_DATA(cmsg), mm_idp->syscall_fd_map,
> +				       fds_size);

It looks the memcpy could trigger a crash when UML_SECCOMP is enabled:

Run /sbin/init as init process
*** buffer overflow detected ***: terminated

Thread 1 "linux" received signal SIGABRT, Aborted.
__pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353807680) at ./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353807680) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737353807680) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737353807680, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff7c42476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff7c287f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff7c89676 in __libc_message (action=action@entry=do_abort, fmt=fmt@entry=0x7ffff7ddb92e "*** %s ***: terminated\n") at ../sysdeps/posix/libc_fatal.c:155
#6  0x00007ffff7d3659a in __GI___fortify_fail (msg=msg@entry=0x7ffff7ddb8d4 "buffer overflow detected") at ./debug/fortify_fail.c:26
#7  0x00007ffff7d34f16 in __GI___chk_fail () at ./debug/chk_fail.c:28
#8  0x00000000600376ee in memcpy (__len=4, __src=<optimized out>, __dest=0xe0803e60) at /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
#9  wait_stub_done_seccomp (mm_idp=mm_idp@entry=0x608e69e0, running=<optimized out>, running@entry=0, wait_sigsys=wait_sigsys@entry=0) at arch/um/os-Linux/skas/process.c:183
#10 0x0000000060037cc6 in userspace (regs=0x60828788) at arch/um/os-Linux/skas/process.c:605
#11 0x00000000600228c1 in new_thread_handler () at arch/um/kernel/process.c:119

It can be fixed with changes like below on my machine:

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index f2d4c383c958..26d922443454 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -6,6 +6,8 @@
 #ifndef __MM_ID_H
 #define __MM_ID_H
 
+#include <linux/kconfig.h>
+
 #ifdef CONFIG_UML_SECCOMP
 #define STUB_MAX_FDS 4
 #else

Regards,
Tiwei

