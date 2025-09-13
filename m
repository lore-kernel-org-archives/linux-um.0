Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1772CAC58F
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 05:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=msWjE/k4XDYFNkRqUljSzhRmzL+P+KgKrTjqUiQu4aI=; b=2RhebmYUmzCoqfxTwzGoVigCX8
	R2rGhBin0sWT8IMjyHjqi4De90Rt6aIweRaFJHKJd7ocRG9yp78MseLmaZhmM/k0UZQ9y7uVyLMn7
	Q1ha9uPJrqFntvdRWpjsbYNY9GViQmh11lmB+rhXrBBji3det6Dsq0ubc29EW4OY6yO4hGz1AM8DZ
	tR0UjhG6bGaNa5PlAYVDqLHKYtGHJ1X2Ish65n/uyEt/fP8BjdPO0/+yV8IesHKEf6rRf3UYWMZxZ
	fQGR0PA3JjI2mCULGjwHwjCi74yVUB68TNGwQWgs3XvEjlKXdWpbCw5LuykAnfI8QgxABJ94DVVEI
	HFVRSZqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJ90-0000000DOjL-1QC9;
	Sat, 13 Sep 2025 05:49:54 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJ8v-0000000DOgh-330k;
	Sat, 13 Sep 2025 05:49:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3A3940E0174;
	Sat, 13 Sep 2025 05:49:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ojZM34cNAwPe; Sat, 13 Sep 2025 05:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757742581; bh=msWjE/k4XDYFNkRqUljSzhRmzL+P+KgKrTjqUiQu4aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlbk0QitQVlp4rvpHe4vCXkRS2hvjoafx60Hi3+Hnx26MFN20WwiEWDlh3HCMXF/Y
	 B7stY6Fyr3vILBwsJcBAqlOW5BxLtsbMmB1EXIFUnlm4GzKlbw7UGM+DEcOseX75hg
	 FPGD/5ZdIiie/I55kLSBsHbTf5YW4dXDvezwU3bEqbq+FV7hIpAAHI6N3sgA2AvmXD
	 3vQ0WadXH8uby4Ww6hVk8ohOCEr7dq/AnKiN+L5+0Qzw4HOeJ3KVUC98nYqPW67/YW
	 aWpHSco3t3XyDwybSqnHdHsxJKU+VPv8otpwQRhG6Y850pLGVP+5QN03U8HBcvg3qJ
	 YYfb20vCSvE4Ai0U8A9cSf9IR1mIJgy5iyavsFYWrU9iyZHBF0AYZx+WI/zWF0+N3j
	 yYr/9bod0cW556Z6BwicNX0j4oLecbtI6kPTnTbfq9PIQRnjY49acw04OtWrRYjsbI
	 DQkmlnaai3jYlBnsa1AnTSuTPIrVsWOuuni4+sHz/DQnxpwepInt7QWlTbdwLusW58
	 k1GUpFnyMOR6rD+nZ2jz9MpyEHSQd/x6SVjlXFFhbnW6MajvATDtW+vN0PIKR+kSvH
	 J/wpw42BbFvcsBnYbs2215b0y4rQlOHZTMFHZvjKHk3GMUIDXA+gFVW3s7E2BwGo8u
	 197mO9Gq+6sAN+bvVMZHrolI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8EFB740E0140;
	Sat, 13 Sep 2025 05:48:45 +0000 (UTC)
Date: Sat, 13 Sep 2025 07:48:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>, Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org, initramfs@vger.kernel.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um,
 x86, xtensa: rename initrd_{start,end} to
 virt_external_initramfs_{start,end}
Message-ID: <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-29-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-29-safinaskar@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_224949_918210_3BE1756E 
X-CRM114-Status: UNSURE (   8.39  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, Sep 13, 2025 at 12:38:07AM +0000, Askar Safin wrote:
> Rename initrd_start to virt_external_initramfs_start and
> initrd_end to virt_external_initramfs_end.

"virt" as in "virtualization"?

That's not confusing at all... :-\

And "external" means what?

> They refer to initramfs, not to initrd

Why not simply initramfs_{start,end} if they belong to it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

