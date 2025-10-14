Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE7CCD18E
	for <linux-um@archiver.kernel.org>; Tue, 14 Oct 2025 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SzW2cWfpQXuLGQqbaNqxu1i17z4sh2RC+KzHuoIl4BY=; b=qG8rR1LO0NPktGnWXkPDRLEZm7
	lK26vq16zYMS1SdJiUja/T6xNd+aoPD6Hl8bmfU4Db1z0w6yVjKkahh3FFG4KSkML3jqyjMggW0RH
	9sMpKUVOsPiU4tPsNbDG8mljgjRghPf+CNdp7ZT91LIn776kUqpZ3QUk3Do/LjnUyeGAt3+6yZ7z4
	s+GxTQSnsCJfcZaZCE8/DMzGGCTH8ugEU/QW9Bdr5/CTAiBKWBo1yRM9gg45ISpEp8Rs4s+b42Hs7
	fxHu5dPTbg8S2i1cMr1TxmyVMK8NBwpB43bh/Iof//ek5SFAz/WYxQXQI685x+IaE9uPZlovxHw/D
	lNQ1Dtjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8apd-0000000Fgk0-0jVP;
	Tue, 14 Oct 2025 08:56:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8apa-0000000Fgi7-08LV
	for linux-um@lists.infradead.org;
	Tue, 14 Oct 2025 08:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzW2cWfpQXuLGQqbaNqxu1i17z4sh2RC+KzHuoIl4BY=;
	b=DBoF7f5CJLx8LIEZz8p61JrmQjd/o8kqXzoXDelIZykH9/2k+qSWOTHcXY1m2fAgPplnlj
	B+Yk1BjRGANpl92ORb4WnhFgnnk/4MKCpHnThWdJZ+342siCBJMd8/mzbgf8M/xEsli2fS
	TAYPsF0lHpiQr1OxWs1bPmjHgAyTLdw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-88ZyZhZiPSKzb3dgMZdLLQ-1; Tue,
 14 Oct 2025 04:56:22 -0400
X-MC-Unique: 88ZyZhZiPSKzb3dgMZdLLQ-1
X-Mimecast-MFC-AGG-ID: 88ZyZhZiPSKzb3dgMZdLLQ_1760432179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A5F2180045C;
	Tue, 14 Oct 2025 08:56:17 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.33.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B5F19560A2;
	Tue, 14 Oct 2025 08:56:08 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,  Huacai Chen <chenhuacai@kernel.org>,
  WANG Xuerui <kernel@xen0n.name>,  Heiko Carstens <hca@linux.ibm.com>,
  Vasily Gorbik <gor@linux.ibm.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>,  Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,  Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,  Vincenzo Frascino
 <vincenzo.frascino@arm.com>,  Shuah Khan <shuah@kernel.org>,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-s390@vger.kernel.org,  linux-um@lists.infradead.org,
  linux-api@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
In-Reply-To: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
	(Andy Lutomirski's message of "Mon, 13 Oct 2025 10:14:58 -0700")
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
	<e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
	<CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Date: Tue, 14 Oct 2025 10:56:06 +0200
Message-ID: <lhu5xchq2u1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_015630_140378_B425E5DA 
X-CRM114-Status: GOOD (  15.26  )
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

* Andy Lutomirski:

> The theory is that people thought that getcpu was going to be kind of
> slow, so userspace would allocate a little cache (IIRC per-thread) and
> pass it in, and the vDSO would do, well, something clever to return
> the right value.  The something clever was probably based on the idea
> that you can't actually tell (in general) if the return value from
> getcpu is stale, since you might well get migrated right as the
> function returns anyway, so the cache could be something silly like
> (jiffies, cpu).

It probably had to do something with per-CPU or per-node mappings of the
vDSO.  Or may some non-coherent cache line in the vDSO.  As far as I
understand it, the cache has zero chance of working with the way vDSO
data is currently implemented.

We have the CPU ID and node ID in the restartable sequences area now
(although glibc does not use the node ID yet).  It's not a cache.  So
this clearly supersedes whatever struct getcpu_cache tried to achieve.

Thanks,
Florian


