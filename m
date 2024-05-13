Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F55C25B75
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INhTGa+hLJWxJaIBH8Ei7S3x1zwZqdSWYWQ3g86eEoE=; b=RhENhORR3tJxtTQeC1LVYDeZ8j
	j9ecFa+Tcxbe1EmIY1dGrflca8jwA+RRYeve91KL5KMhkAnjP1u2//c3rE8NbHkgVjab6xkNeaRA+
	ETArfPIE6Rj/QEQLu2qOuiuwgBrcAB66qG2cqpnBqZ4bzkL2fhao9uuWJbKuLP4oNKUM/1RnCTqtJ
	ZUR5rfCIlyprgnOmYV8YZ1RbqFi5LBwdJDQPKJ2KEqU6+/Z3fBVt+h2qmx5QmrIh38dYIdeVEdm4t
	ipO8CqF1aB126i1jlSEUr2iY9izlxIz2UPI0SAGTZQj7p0h1CAeSjdHkrpa/vQQrJEDG3qseAEknP
	Jc0TfdIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6V1U-0000000CrYV-2fJu;
	Mon, 13 May 2024 12:43:20 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6V1Q-0000000CrXF-3Uw5
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 12:43:18 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VdJcb5sJdz9v7Hl
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 20:26:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5EB1A1407F8
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 20:42:58 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXAyfGCkJmtr4SCA--.47370S2;
	Mon, 13 May 2024 13:42:57 +0100 (CET)
Message-ID: <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:42:42 +0200
In-Reply-To: <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwAXAyfGCkJmtr4SCA--.47370S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5lAAQAAst
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_054317_021411_F5EEAA0E 
X-CRM114-Status: UNSURE (   6.57  )
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

On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Disable UBSAN sanitization on UML, since UML does not support it.
> >=20
>=20
> Luckily, that isn't actually true, nor does it actually do this at all.
> Please fix the commit message.

Thanks, I was actually wondering. I based that statement based on
ARCH_HAS_UBSAN=3Dn.

Any other solution would be ok.

Thanks

Roberto


