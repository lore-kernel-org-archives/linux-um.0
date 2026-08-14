Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B644C5CFC1
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ts3OQ3CDgVCUAfMfHv4o220aVGh37gfNtGvw/u6SvTg=; b=bk8xJL/ur9XAQfVaD6ulk8Def6
	+oHpTppwTv5Ryh6PtanQi0/ePosY+JRGDGt3FoH5z72eTktsJfo1wR61Shex9RvU1OnHLdkIqrxdx
	QaBM/EAxDMqmSYjYWY/txBSKKf325HASSKhZXjeePdOeBy2temoGD+bkuHyCire6S/AhOEw4nMJLV
	6AadxY4XY8Xh2pao2s/djWeIhcqTnKDQ2L6QoN3/tf/gpKKJBCiJaf25eedb1/gW37EDVNYF0U4p+
	QhIk60YGuHwR2vB3RwGY8D2ex9iZJ+Qi+uIjbNcbDSWa8ijbtUGsHocQ94E3vZPh6tMAG7y4SLeAa
	8PR+7oHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wunSs-00000002Ii6-0iwu;
	Fri, 14 Aug 2026 08:40:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wunSr-00000002Ih4-08D9;
	Fri, 14 Aug 2026 08:40:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B59643988;
	Fri, 14 Aug 2026 08:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41881F000E9;
	Fri, 14 Aug 2026 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786696832;
	bh=ts3OQ3CDgVCUAfMfHv4o220aVGh37gfNtGvw/u6SvTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hM16Mf85mgC/Qtx63cwHwSlhdwmibQneXxkss9nozdQ9jCucf+ThUePxzU1MdY0uv
	 ImunJTjJjx4fNvym3BanCyDxSQ4YX5pl6xt/LW/x88OCf171Il5QH87Qs76TZTbgG4
	 DIl3DWBmf78B/Ntganv/j5Sg5BJ1afi7EkkfqYcfmq4SDwRw9OD6yA3FmarPvFppd0
	 rXd8xAdrUkpAbSubb9b/8BLlKFHVYEVICbM2RgRP1Mqn+VEEkilH8TIRdT0b9sNL15
	 YfTRkG/XDhh22yudn2vyBScQk1qAbeygitXVpRiWAY+ICbgI/u5EbUKTy9Hgoqzg9A
	 UOzTfV3mk1Xpw==
Date: Fri, 14 Aug 2026 09:40:22 +0100
From: Will Deacon <will@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the
 SYSCALL record
Message-ID: <an7Udt-luZfJO71U@willie-the-truck>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
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

On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
> 
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.
> 
> The audit testsuite runs successfully:
> 
>  # make test
>  make -C tests test
>  chmod +x */test
>  Running as   user    root
>         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>         on   system  Fedora
> 
>  amcast_joinpart/test ................. ok   
>  backlog_wait_time_actual_reset/test .. ok   
>  bpf/test ............................. ok   
>  coredump/test ........................ ok   
>  exec_execve/test ..................... ok   
>  exec_name/test ....................... ok     
>  fanotify/test ........................ ok   
>  field_compare/test ................... ok     
>  file_create/test ..................... ok   
>  file_delete/test ..................... ok   
>  file_permission/test ................. ok   
>  file_rename/test ..................... ok   
>  filter_device/test ................... ok     
>  filter_exclude/test .................. ok     
>  filter_exit/test ..................... ok   
>  filter_inode/test .................... ok   
>  filter_saddr_fam/test ................ ok   
>  filter_sessionid/test ................ ok   
>  io_uring/test ........................ ok   
>  login_tty/test ....................... ok   
>  lost_reset/test ...................... ok   
>  netfilter_pkt/test ................... ok     
>  signal/test .......................... ok   
>  syscalls_file/test ................... ok   
>  syscall_module/test .................. ok   
>  syscall_socketcall/test .............. ok   
>  time_change/test ..................... ok     
>  user_msg/test ........................ ok   
>  All tests successful.
>  Result: PASS
> 
> Ricardo Robaina (13):
>   audit: log all six syscall arguments in the SYSCALL record
>   alpha: pass all six syscall args to audit_syscall_entry()
>   arm: pass all six syscall args to audit_syscall_entry()
>   arm64: pass all six syscall args to audit_syscall_entry()
>   csky: pass all six syscall args to audit_syscall_entry()
>   microblaze: pass all six syscall args to audit_syscall_entry()
>   mips: pass all six syscall args to audit_syscall_entry()
>   openrisc: pass all six syscall args to audit_syscall_entry()
>   parisc: pass all six syscall args to audit_syscall_entry()
>   sh: pass all six syscall args to audit_syscall_entry()
>   sparc64: pass all six syscall args to audit_syscall_entry()
>   um: pass all six syscall args to audit_syscall_entry()
>   xtensa: pass all six syscall args to audit_syscall_entry()

Could audit make use of syscall_get_arguments() instead?

Will

