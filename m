Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2FCA1009
	for <linux-um@archiver.kernel.org>; Wed,  3 Sep 2025 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxOgjN7WdDoAv2rvG3Wc6cb+dOveWBvcqA5WgB2sqzo=; b=37H3O110/tZkRlib37TdtisS9i
	DktUU2+vPrGmDBKzsGbcp+1okBEc4FBaeblG8oBAt++DFin8TGlaHEqgNBqXHQDe0c8OFjXsTy1Me
	crjV35fcHXsoMpuCwQx+fz46CFt+tptMWeCGs3ZSimF/P93HUUbG87URrlVaE1N2M1+xm+r4molYi
	5lYxYaI778LulynaDA6EMenC6SjPGCmPtjJVsdCDSmr+d95dEU8h9yX3/UKOwTfXKfnxnHBXXZeMD
	VtzoXNRp/9jqgFpD2qS754ibopG/APxKgrbPmYQybFKLFHo13d5gTr9saHg7gaI10+6JKeFQ3dhVX
	8KZjJOUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utpbj-00000006x3j-2DL8;
	Wed, 03 Sep 2025 15:41:11 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utn7a-00000006VDX-0K9Y;
	Wed, 03 Sep 2025 13:01:55 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2539480f8f.0;
        Wed, 03 Sep 2025 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756904512; x=1757509312; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxOgjN7WdDoAv2rvG3Wc6cb+dOveWBvcqA5WgB2sqzo=;
        b=XFIDqcEqw2iJ8qUHXtEBZY5aEQ38RHHD9P9+KUDGUiRM3yXvSAN5OkqQWbq0h4eDdF
         51uiNJ9C5BKrHlh3izcAC9hJ8fUbdww51WqAxjevnRETmK8Mcgh0gg/pSuwkUcg0XSoT
         ly9pOPAL+UFZSUf8AEDvTmC7ttBFUxO10wfU2rTKFXk7HU9B/RhIDtOObKp9wZZwvzIt
         jcCucd7GNDT0HTdzWTyDCD6qguOsLVNnG7w3RH25ksElBRVv7WqQkWv3LGrp3sLpfwmQ
         Nq+DYbtnAUUF2ktkzIDFqpmQoyxUUf7ye9akWaO6rp4q4ZIhLTL4pf5UZz3FXTPSi8WU
         X0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904512; x=1757509312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxOgjN7WdDoAv2rvG3Wc6cb+dOveWBvcqA5WgB2sqzo=;
        b=WgXXQs1BOQiC910z26ZblWTRZXksMPKEcpmTS96v6iDI4uPMNHWAjC8QqxewXVE6HQ
         MWbaQNXD+/nQzHSwgj7ca5A4LnJ2FJNdPA4VoN7QhJvrEY5o3zdyLikcKJ7TVwhJ1TTf
         LQinWTdzdSLZrxRc1T1njnoiqnzTZ7CUMs9dnabF2IEHwr8lIK4SEAuPcotkYGPHf6t7
         DSVPugC86+1f541sb1wLEV7REZ5it5+ZJEn7oGe8f+iX1H3UopuYtJrSMqU37DrQMKiL
         TMKmADutp7C1kzySkf861Oa3xLmeck0BkREYs1miCrHKbxY4gJs4icRJ7QUUq0s7tGoy
         JHpw==
X-Forwarded-Encrypted: i=1; AJvYcCUIYJgcpJ+SK1l6hlDdmv3SBWOJE8NCvn/7n7Rg4SQt6nALJuqbRiYnP9ZcQFAfM72IXc+0N25c/Fs=@lists.infradead.org, AJvYcCWlRVKxl3qOmflFJHniF1xlHwU4F0Dh9W9Rcq483kunKOk/Q91pfV6wZ/VVMid8FUJvP+cvskemOdU0XttqVifx@lists.infradead.org, AJvYcCXtUh+vxI35JVfEKCxCPkgn28gEsiLLBUhrFwabefEaNBYquiPfm36O6s42QzNXKEiw4EjvZjyqoi+5p9Q=@lists.infradead.org
X-Gm-Message-State: AOJu0YzveT6HAxZITpS8+K0zyjG8lv7R1xbqY9vr2lmP/f63jOVC/fFF
	cgr6r68L32EFeujM9/3CvMhAa1eEX3I7h7agwv+6KBIxMRMA3bdfTlUuvHqi/hHL0b6jmCF6g2w
	hUneI4rDsn4IN4lHAunCzFy5s2lk4xuM=
X-Gm-Gg: ASbGncuG7eogbsIZzq1VfeS7NCs3W67orWNuulrotSh6kBCIS8wJ/U/UYPx1/JjQz5W
	mKZ/zV3fPOU9e/NBG6NxRIQJJiVz2AXDyQckxKft0Hs/tOL5/x7I1clneetwwiQcwoNuMDftFMQ
	U2mRzEunYKRLZxTZpMcAIsb2DSGTphS/nMidlV1AwKy1pfKhwzHG/86XyIwnEjXe30BmmjoWx4e
	guzJ2aQ
X-Google-Smtp-Source: AGHT+IHaI9QHXphQW4NL4BWXS0uWqM/wJHgXqqOYeELhPBU/zEzYKTUTZN/+1NM3wCGA2AyzOKaLxaL5ucEtc3zspBA=
X-Received: by 2002:a5d:5d0a:0:b0:3dc:3b91:6231 with SMTP id
 ffacd0b85a97d-3dc3b916271mr3074458f8f.12.1756904512228; Wed, 03 Sep 2025
 06:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
 <CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
In-Reply-To: <CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Sep 2025 15:01:40 +0200
X-Gm-Features: Ac12FXxqG38KSSLGvfY5HirQQyjqsvLS5blUVLw1nroWjuASE3O6kwm-RqaVNbQ
Message-ID: <CA+fCnZdkHATBYG4RJ8rR8MciKmeV4QGwVwoQjkhc-O_igpUBTQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, 
	hca@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, davidgow@google.com, glider@google.com, 
	dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_060154_112790_2D54C6F8 
X-CRM114-Status: GOOD (  14.38  )
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

On Wed, Sep 3, 2025 at 3:00=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
>
> > +void __kasan_save_free_info(struct kmem_cache *cache, void *object);
> > +static inline void kasan_save_free_info(struct kmem_cache *cache, void=
 *object)
> > +{
> > +       if (kasan_enabled())
> > +               __kasan_save_free_info(cache, object);
> > +}
>
> What I meant with these __wrappers was that we should add them for the
> KASAN hooks that are called from non-KASAN code (i.e. for the hooks
> defined in include/linux/kasan.h). And then move all the
> kasan_enabled() checks from mm/kasan/* to where the wrappers are
> defined in include/linux/kasan.h (see kasan_unpoison_range() as an
> example).
>
> kasan_save_free_info is a KASAN internal function that should need
> such a wrapper.

... should _not_ need ...

>
> For now, to make these patches simpler, you can keep kasan_enabled()
> checks in mm/kasan/*, where they are now. Later we can move them to
> include/linux/kasan.h with a separate patch.

