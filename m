Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1B8C0218F
	for <linux-um@archiver.kernel.org>; Wed, 29 Jan 2025 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vlOChQEKTp5JX+pbfAOT77vMe8ez+6+Y0ab8kJl+7mw=; b=ON6ifWvZOlcsraii8maVZpXTnj
	XVazFAJZd0aKp/da+Ux7KxZMcjAFOS9jp+cu3BYUXMvJa4KkbIMLa8s1ROZpjSAdZUelGn95ZzSBT
	yhAsBNpSfYOP7O5zvoMJtasNbUoKvnJJ6pd2Br9X0JiW0HwchrEaI3bOHUVnfKQ7evxFRQB1b2yfv
	n/LLjyzyKZLjqWA+FxEaL3LrLb/6uIkPmiBksgT+kn2DmvlgrrjAwdD2GMyhP1/J7n/YBQXOKxJpN
	Wy96de+QFk+sem1LGYG6hs8x6c/TOvrzX9RuMpLv88ZasfRN6Ahx40G8fZZo1UyCiNTRK62DCuS6w
	FgBTaLmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDBT-00000007e1b-3v9h;
	Wed, 29 Jan 2025 18:53:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDBP-00000007dyF-0d16
	for linux-um@lists.infradead.org;
	Wed, 29 Jan 2025 18:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738176782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlOChQEKTp5JX+pbfAOT77vMe8ez+6+Y0ab8kJl+7mw=;
	b=WRb+khmgHLgCAl1ujK3GxAUAs6JFnnHfwClFvM/UcfI8UgankvZFXiJRxTTLHPUQfn3zNX
	AaixfGeMWAsrccNl/sO2FFDtoi9kkCpbjcGe/yxGeHVsp0d/yNMKia6/18U8FvG2PwpMDe
	90awVkH19OibJqO0Hbo7eDWyGs6QBwM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-9t9EmevBOu69KQmdLrigRQ-1; Wed,
 29 Jan 2025 13:52:59 -0500
X-MC-Unique: 9t9EmevBOu69KQmdLrigRQ-1
X-Mimecast-MFC-AGG-ID: 9t9EmevBOu69KQmdLrigRQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AD7180034F;
	Wed, 29 Jan 2025 18:52:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.29])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3326919560AA;
	Wed, 29 Jan 2025 18:52:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Jan 2025 19:52:21 +0100 (CET)
Date: Wed, 29 Jan 2025 19:51:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Alexey Gladkov <legion@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 0/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250129185149.GA25901@redhat.com>
References: <20250128091445.GA8257@strace.io>
MIME-Version: 1.0
In-Reply-To: <20250128091445.GA8257@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4waT3uB4ud_WsXYB9UBBWbxNJg9HzL1VZ2Xu2Go7oX8_1738176773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_105303_250349_052EB8BE 
X-CRM114-Status: GOOD (  11.55  )
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

On 01/28, Dmitry V. Levin wrote:
>
>     * ptrace: Add explicit padding to the end of struct ptrace_syscall_info,
>       simplify obtaining of user ptrace_syscall_info,
>       do not introduce PTRACE_SYSCALL_INFO_SIZE_VER0
>     * ptrace: Change the return type of ptrace_set_syscall_info_* functions
>       from "unsigned long" to "int"
>     * ptrace: Add -ERANGE check to ptrace_set_syscall_info_exit,
>       add comments to -ERANGE checks
>     * ptrace: Update comments about supported syscall stops
>     * selftests: Extend set_syscall_info test, fix for mips n32

Again, I can't review 1-3, I know nothing about the non-x86 architectures.

As for 4-6, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


