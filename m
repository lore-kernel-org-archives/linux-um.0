Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A260C2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elHJYclT3cn65SE4oJPwzYsP1dHLBbICZB/RukRWt8M=; b=HYTGKBr96ZJMBNn6g/eb3QIpTp
	fbPriG6+KMnC8voIgT8yPGXz4mrhqNOovYJDsay+ZgLxV8WzQfeWDRfShnTgI0kN2WhTcJHC7E25/
	KHuyWhzgyEWOl82ouuezuQDeFZqgMnsz5CbwS6kj7iWPM2riWUDLnkEP2I43VQwvzmL+K9sLkY/oI
	rjEY+1PVBrCb31XPAXsOHbfJZP9gvh9zOjbZ2zY7MVFDrpJ7llLQPDY+xiYuXk7/a3IfEeUfhd45Q
	tq8SXqjZKAUZjqq1zd6axcQWmu4FZt3Q/QnQGAZERVGhH/Iz58SLRlRuxy0nEqJfIu14bi5oauNu0
	qHXJdvew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKC5w-00000003xGV-0b5z;
	Thu, 20 Jun 2024 07:20:32 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKC5q-00000003xEw-3R4x
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 07:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1718868020; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=elHJYclT3cn65SE4oJPwzYsP1dHLBbICZB/RukRWt8M=;
	b=yMTVX3Ck7zfR1YxwXvOBerMGol3Nh9GcF5I5vkObsznBHuu3y2SG62XFZZIIV52tvP9/XnwYy9Hqcl1nPsXe1xhKKg/UqNgBwHxSvbJ31AVPGMpA2HkVIqAg/Dlc9nCF+kKiGuxtV+tF98J3qiA5pI4DxdhyWM+n0MQaq/yWViw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021165;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.Y5zZ1Tk_1718868008;
Received: from 30.230.82.21(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Y5zZ1Tk_1718868008)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 15:20:15 +0800
Message-ID: <7345517a-b85d-4ac3-ba91-0f4a31c727bd@antgroup.com>
Date: Thu, 20 Jun 2024 15:20:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] um: use execveat on memfd to create userspace MMs
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240619153411.2596774-1-benjamin@sipsolutions.net>
 <20240619153411.2596774-4-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240619153411.2596774-4-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_002027_488098_C6A7CFB8 
X-CRM114-Status: GOOD (  35.39  )
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

On 6/19/24 11:34 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Using clone will not undo features that have been enabled by libc. An
> example of this already happening is rseq, which could cause the kernel
> to read/write memory of the userspace process. In the future the
> standard library might also use mseal by default to protect itself,
> which would also thwart our attempts at unmapping everything.
> 
> Solve all this by taking a step back and doing an execve into a tiny
> static binary that sets up the minimal environment required for the
> stub without using any standard library. That way we have a clean
> execution environment that is fully under the control of UML.
> 
> Note that this changes things a bit as the FDs are not anymore shared
> with the kernel. Instead, we explicitly share the FDs for the physical
> memory and all existing iomem regions. Doing this is fine, as iomem
> regions cannot be added at runtime.

This is pretty cool! :)

> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/include/shared/skas/stub-data.h |  11 ++
>  arch/um/os-Linux/skas/process.c         | 145 +++++++++++++++---------
>  arch/x86/um/.gitignore                  |   2 +
>  arch/x86/um/Makefile                    |  32 +++++-
>  arch/x86/um/stub_elf.c                  |  84 ++++++++++++++
>  arch/x86/um/stub_elf_embed.S            |  11 ++
>  6 files changed, 227 insertions(+), 58 deletions(-)
>  create mode 100644 arch/x86/um/.gitignore
>  create mode 100644 arch/x86/um/stub_elf.c
>  create mode 100644 arch/x86/um/stub_elf_embed.S
> 
> diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
> index 5e3ade3fb38b..83d210f59956 100644
> --- a/arch/um/include/shared/skas/stub-data.h
> +++ b/arch/um/include/shared/skas/stub-data.h
> @@ -8,6 +8,17 @@
>  #ifndef __STUB_DATA_H
>  #define __STUB_DATA_H
>  
> +struct stub_init_data {
> +	unsigned long stub_start;
> +
> +	int stub_code_fd;
> +	unsigned long stub_code_offset;
> +	int stub_data_fd;
> +	unsigned long stub_data_offset;
> +
> +	unsigned long segv_handler;
> +};
> +
>  struct stub_data {
>  	unsigned long offset;
>  	int fd;
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 41a288dcfc34..6cd82ca7a43d 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -23,6 +23,8 @@
>  #include <skas.h>
>  #include <sysdep/stub.h>
>  #include <linux/threads.h>
> +#include <fcntl.h>
> +#include <mem_user.h>
>  #include "../internal.h"
>  
>  int is_skas_winch(int pid, int fd, void *data)
> @@ -188,69 +190,100 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
>  
>  extern char __syscall_stub_start[];
>  
> -/**
> - * userspace_tramp() - userspace trampoline
> - * @stack:	pointer to the new userspace stack page
> - *
> - * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
> - * This function will run on a temporary stack page.
> - * It ptrace()'es itself, then
> - * Two pages are mapped into the userspace address space:
> - * - STUB_CODE (with EXEC), which contains the skas stub code
> - * - STUB_DATA (with R/W), which contains a data page that is used to transfer certain data between the UML userspace process and the UML kernel.
> - * Also for the userspace process a SIGSEGV handler is installed to catch pagefaults in the userspace process.
> - * And last the process stops itself to give control to the UML kernel for this userspace process.
> - *
> - * Return: Always zero, otherwise the current userspace process is ended with non null exit() call
> - */
> +int userspace_pid[NR_CPUS];

Nit: userspace_pid is already defined in this file.

> +
> +extern char stub_elf_start[];
> +extern char stub_elf_end[];
> +
> +int stub_exec_fd;

stub_exec_fd isn't used outside this file. Might be better to make it static.

> +
>  static int userspace_tramp(void *stack)
>  {
> -	struct sigaction sa;
> -	void *addr;
> -	int fd;
> +	char *const argv[] = { "uml-userspace", NULL };
> +	int pipe_fds[2];
>  	unsigned long long offset;
> -	unsigned long segv_handler = STUB_CODE +
> -				     (unsigned long) stub_segv_handler -
> -				     (unsigned long) __syscall_stub_start;
> -
> -	ptrace(PTRACE_TRACEME, 0, 0, 0);
> -
> -	signal(SIGTERM, SIG_DFL);
> -	signal(SIGWINCH, SIG_IGN);
> -
> -	fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
> -	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
> -		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
> -	if (addr == MAP_FAILED) {
> -		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
> -			STUB_CODE, errno);
> -		exit(1);
> +	struct stub_init_data init_data = {
> +		.stub_start = STUB_START,
> +		.segv_handler = STUB_CODE +
> +				(unsigned long) stub_segv_handler -
> +				(unsigned long) __syscall_stub_start,
> +	};
> +	struct iomem_region *iomem = iomem_regions;
> +	int ret;
> +
> +	init_data.stub_code_fd = phys_mapping(uml_to_phys(__syscall_stub_start),
> +					      &offset);
> +	init_data.stub_code_offset = MMAP_OFFSET(offset);
> +
> +	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
> +	init_data.stub_data_offset = MMAP_OFFSET(offset);
> +
> +	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
> +	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
> +
> +	fcntl(init_data.stub_data_fd, F_SETFD, 0);
> +	while (iomem) {
> +		fcntl(init_data.stub_data_fd, F_SETFD, 0);

Typo: this is supposed to be iomem->fd.

> +		iomem = iomem->next;
>  	}
>  
> -	fd = phys_mapping(uml_to_phys(stack), &offset);
> -	addr = mmap((void *) STUB_DATA,
> -		    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
> -		    MAP_FIXED | MAP_SHARED, fd, offset);
> -	if (addr == MAP_FAILED) {
> -		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
> -			STUB_DATA, errno);
> -		exit(1);
> +	/* Create a pipe for init_data (no CLOEXEC) and dup2 to STDIN */
> +	if (pipe2(pipe_fds, 0))
> +		exit(2);
> +
> +	close(0);
> +	if (dup2(pipe_fds[0], 0) < 0) {
> +		close(pipe_fds[0]);
> +		close(pipe_fds[1]);
> +		exit(3);
>  	}
> +	close(pipe_fds[0]);
> +
> +	/* Write init_data and close write side */
> +	ret = write(pipe_fds[1], &init_data, sizeof(init_data));
> +	close(pipe_fds[1]);
> +
> +	if (ret != sizeof(init_data))
> +		exit(4);
> +
> +	execveat(stub_exec_fd, "", argv, NULL, AT_EMPTY_PATH);
>  
> -	set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
> -	sigemptyset(&sa.sa_mask);
> -	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
> -	sa.sa_sigaction = (void *) segv_handler;
> -	sa.sa_restorer = NULL;
> -	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> -		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
> -			__func__, errno);
> -		exit(1);
> +	close(0);
> +
> +	exit(4);

Might be better to bump the exit code.

> +}
> +
[...]
> diff --git a/arch/x86/um/stub_elf.c b/arch/x86/um/stub_elf.c
> new file mode 100644
> index 000000000000..b634740a6a15
> --- /dev/null
> +++ b/arch/x86/um/stub_elf.c
> @@ -0,0 +1,84 @@
> +#include <sys/ptrace.h>
> +#include <sys/prctl.h>
> +#include <asm/unistd.h>
> +#include <sysdep/stub.h>
> +#include <stub-data.h>
> +
> +void _start(void);
> +
> +static void real_init(void)
> +{
> +	struct stub_init_data init_data;
> +	unsigned long res;
> +	struct {
> +		void  *ss_sp;
> +		int    ss_flags;
> +		size_t ss_size;
> +	} stack;
> +	struct {
> +		void *sa_handler_;
> +		unsigned long sa_flags;
> +		void *sa_restorer;
> +		unsigned long sa_mask;
> +	} sa = {};
> +
> +	/* set a nice name */
> +	stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");
> +
> +	/* read information from STDIN and close it */
> +	stub_syscall3(__NR_read, 0,
> +		      (unsigned long)&init_data, sizeof(init_data));

Might be better to check the number of bytes read.

Regards,
Tiwei

