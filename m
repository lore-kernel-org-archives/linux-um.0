Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AA5CDB474
	for <linux-um@archiver.kernel.org>; Tue, 17 Oct 2023 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QSahnduKqnxTLMfLcmTq8grGA+alAgE9vsa0R6jGoZI=; b=o5izHegkDRKa9c
	xd3utzETacOiSpw9UWC4lJMlsJ+vJCu5pkWTtgu5UMcUWIucObgR0FFfo9CMCOMfBMyjvPwEHKlKp
	mB59JVD8Kknux/tcVIFnfj9hFTNntgppg1UQGQcMh9jbmepfrWqy9hDK7DVXsPdl7sNJ6ojiW+3Lt
	gM5R7qG2TJFmF+6Zfwxnt0njwSdzjaKUaVF/TbtcRi851Wbay4EpU5/kXL3E12cjXdxztfXdNZqbB
	D7NS0so943J6Fb7tHX/n847pKHQ9bkxGZQ79oFQuWmzCUcVFFGHi5QNouioVjXaqZtu/XbWXNbZsI
	NYOrwKLtTDrKS37p9u7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsiiB-00CG13-2j;
	Tue, 17 Oct 2023 11:58:11 +0000
Received: from mail.avm.de ([212.42.244.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsii7-00CFz1-1t;
	Tue, 17 Oct 2023 11:58:09 +0000
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 13:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1697543873; bh=osOPrqiiKOprJxC70XFTAVq992xL7ZaM2aZVaEQG2Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnJgpiNWAMGVc0xEWtD9K4S88LSSPMbgijDz2pOHmBktW2Orxe1PlrhnLTDsBrgGX
	 tfFz/35yEpjsd2lWXJB3L8dxOM1f2ywcRKM8oZxaKD9ofLnmAeJI+8zMVH6ERwT4HW
	 LewlwUwa8Y743N4nthnjDBYgG1826/sWxFei++6o=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 1002280683;
	Tue, 17 Oct 2023 13:57:54 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 0841B1819FD; Tue, 17 Oct 2023 13:57:54 +0200 (CEST)
Date: Tue, 17 Oct 2023 13:57:54 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 2/2] kbuild: unify no-compiler-targets and
 no-sync-config-targets
Message-ID: <ZS52wrL9meW8iehZ@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
References: <20231014105436.2119702-1-masahiroy@kernel.org>
 <20231014105436.2119702-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231014105436.2119702-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1697543872-187BED95-BE924DB1/0/0
X-purgate-type: clean
X-purgate-size: 416
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_045807_842869_63FE7A82 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, Oct 14, 2023 at 07:54:36PM +0900, Masahiro Yamada wrote:
> Now that vdso_install does not depend on any in-tree build artifact,
> it no longer needs a compiler, making no-compiler-targets the same
> as no-sync-config-targets.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Revive need-compiler flag
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
