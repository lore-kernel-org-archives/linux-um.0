Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5486AC531DF
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=; b=sRUzOKv7x7cTX4b/5fVyPLmXc0
	BSapCQN+D85bdd0A1lanPKlYlCK8FwT8xN1WbBaaW9dATh7PzGEcSepSIYWjZ2MQxGodUuEgpTsg9
	AChyW59lhJ8dQ1LCdV5A4ZYOkEaMqo7NUv1FOVrD/o6kCXRTVG9uYi9vJoqGSJc+7zUKTsPmQ0Zka
	6480mTXcZGfEgjyYOYaeHT92dw+WETe+lLhL//im6Sks3y22w4UU9K8e81WwYZQZkHx5wzF5T+r7w
	yxEWIFzqwgqWeISW+X35Cpr/OVM0CkZ9ayA6RbfsXe+9ZEzDqsFxL7+dQvNT7Epxq2yxdbM11UUul
	TTq5sl+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQqe-00000005qoc-0OZD;
	Tue, 20 Aug 2024 15:32:40 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQqG-00000005qfj-2hOn
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 15:32:18 +0000
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso4369669a12.3
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724167934; x=1724772734; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=g+qnjxz860DMCahts2Q+HetzKsoxzArVIKKCgcufTAz3PDaDSfvnC2qwOS3Yk/KYW8
         iuXpq0Ft/Wsa5x6aghruUZQdFUwjtYGzmQrkjiMSu/n1jf/hDH0SiAaeTAZOOvo63Dix
         mRXDJFaK3k+neftHxMLUCIpvDGK2Fkhlmar8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167934; x=1724772734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=GfhaTceeIToisRTpBspAkKhZop6VzTYCFz7IweTjY8uORuCvhvfpWbkuMddvRkyP4a
         +YgbsCFzBbui6c+0TPSmZqHrW57qwjENCueECk4ngY8jviTXyYVGQHZKifzBrU9Rzbz3
         AxRkK9SZI/WEJDsjOfZ08qUKe+4I0t8nHGDMXbgWImmNnRuOtfE8u6YCAfasTetJrCob
         YS1YB0u10AD46I3maGPWa17hE0D/c78uBjhm3jxli/eXaruAWuej+3O2ghbmHXnsJp0F
         1YLEEfgccp/416Z9PjyniAUOUbOt0wLnKH7A/oAD+NxBp6UjU/uuiHyG+gm37qUAAWfp
         mhWg==
X-Forwarded-Encrypted: i=1; AJvYcCWdpEGPMPP1XsGljarsnyqPg0vlDPVBK4/c7vXuF2arpaHLzNM3KgmU/t7qoQZT3K9iKEuXm2zbhar4o9pP1sGbd4jOK+o1Q5dzPAuB
X-Gm-Message-State: AOJu0YyXBmd92yla0Rh6h4B3saFhJ5+soq4l+zpTamyvjZ7vE8gLWE2H
	YzMVFrKQD2vOHreXSRrD16ZHB7WOC5i0taiuUKSDVMXj4Sjk1odbuoYMn9fnF08SXZe25hv8Kjy
	LBDyB/g==
X-Google-Smtp-Source: AGHT+IHq0Kvi/INZB7KHtBMlWI/TZmtXzvkx+WYmqy7mu9y86Q4pmX0RGXUh2zp0SpFTUMaFCCVqHQ==
X-Received: by 2002:a05:6402:4413:b0:5be:ae21:33a8 with SMTP id 4fb4d7f45d1cf-5beca4da6camr10392657a12.2.1724167933602;
        Tue, 20 Aug 2024 08:32:13 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f318sm6823084a12.74.2024.08.20.08.32.11
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so2335958a12.1
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs75feeq8Qt/lyHgk/oGrqcQpZjLvU6+boNdc1cmfADVi/maMtLKywJ1hwpJEzwJazD9+RX9bFzYZoN7iRJNmT0ax2lGnjkiVttg69
X-Received: by 2002:a05:6402:2710:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-5beca5c5750mr8152922a12.19.1724167931490; Tue, 20 Aug 2024
 08:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <87y14rso9o.fsf@mail.lhotse>
In-Reply-To: <87y14rso9o.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 08:31:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_083216_830313_D30E55B0 
X-CRM114-Status: GOOD (  10.09  )
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

On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > +static struct vm_special_mapping vdso_mapping = {
> > +     .name = "[vdso]",
> > +     .pages = syscall_pages;
>                               ^
>                               should be ,

Ack. Changed here locally. But I assume you also don't actually test sh...

It would be good to get acks from the architectures that still used
the legacy interface.

              Linus

