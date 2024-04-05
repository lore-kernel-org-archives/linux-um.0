Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BAC67861
	for <linux-um@archiver.kernel.org>; Fri,  5 Apr 2024 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wax/9YcCizPKqZe3Omqwdrd0bMfmMcCS1cugFym/X3g=; b=KhY8TDJdKHq+Mi1VXr83/UG7VA
	SYXbzMARSJLQxl3OokqcZa1rsl6ZWNgBfjRVeMYnDfrQzCUYvx2+yES91G0GYBtqIlNkgQfj5XKr3
	8n85UrYjJNperlfPc1T2rbums0gcw03mfOfPzJ0kNeM7KV0y9t/RgtORVLlcCjWMngZUGHSsWzzcA
	kQBEwhu5QrWt1/ns0KwY0UFt0/K81tI8AwHaZGRcSu1nd7EUnxVuDuP3fmUOmPJb6SgbFPNRYmMmz
	dqfrZKOZiuK/SqJ9Z6vytnOFl4CyjLRNpEr/aHGOak3Ij/0F8c1eGLjnTRk7pPX3299v18w0Exluk
	ehiNlUuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsnyv-00000008NNH-3ATl;
	Fri, 05 Apr 2024 18:08:05 +0000
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsnyr-00000008NFM-1tdh
	for linux-um@lists.infradead.org;
	Fri, 05 Apr 2024 18:08:03 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VB60H71S8z7Qf;
	Fri,  5 Apr 2024 20:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712340463;
	bh=kiwUCEjPx78g1bk35VucSw6ptQJmiUDwfINeVgK5ces=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyL7wMZ6fGr++bxregCQEm29qB3fuZgv653iTA9GW51TcUaqXfg7KmuPDuTqcUkKe
	 SfxMZxvEY0inVS2JBEN5QQq9vmLag7zRP8f7AnAnC7axhKSIoC8dmhYmcienEPkhH2
	 tyIzl9AeQHADN+6Mrz57ceiG7iQq9xIzLG1VEUcM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VB60G5glFzpnt;
	Fri,  5 Apr 2024 20:07:42 +0200 (CEST)
Date: Fri, 5 Apr 2024 20:07:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <keescook@chromium.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
Message-ID: <20240405.pahc6aiX9ahx@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
 <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_110801_644369_EDC6F241 
X-CRM114-Status: GOOD (  10.34  )
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

On Fri, Apr 05, 2024 at 10:08:00AM -0600, Shuah Khan wrote:
> On 3/26/24 03:51, Mickaël Salaün wrote:
> > Hi,
> > 
> > This patch series teaches KUnit to handle kthread faults as errors, and
> > it brings a few related fixes and improvements.
> > 
> > Shuah, everything should be OK now, could you please merge this series?
> 
> Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
> except for the important ones. :)

Indeed, I don't know how I missed that... Do you want me to send it
again?

> 
> thanks,
> -- Shuah
> 

