Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF61BC531DC
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOcODjceGC7ZkW4fB/YT/SWFmfr0YR2DkMYRyu0vLoM=; b=AKjEagdxsTCihHAEtoxrKBi0ZP
	QiA2lZbmmEfvfC9veLkU3FcjQ8tEuI3/RtVIfo+mDxKbdoah7RMAtGzHGoQgkS6v4GE6lObwXxLdi
	uKyvp0kNo2Qavq754pSAeNn6Tyurb3UmFIkTUD2on4rk1hgKmhY0XCA/Xo50Io3TtJ+62b6MyBnJp
	0+1vKL73AcxBeEJ+ppJh+dcL5SP2Plo2xv/nyWhIGJuPcXJ5ObvJ26RESDo4+I5zZRmD2dso7hkh4
	WJGpm1pUKWBsy0ocDy8Qy7u2lehssebIotxx1gVPclpl7IQuRF21mvajpme7W5DVEJ+GYKd4YdGyt
	Cjmn36EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWEX-00000006fG6-33Bt;
	Tue, 20 Aug 2024 21:17:41 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWEB-00000006fAw-0rny
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 21:17:20 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-6bd3407a12aso19264187b3.3
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1724188637; x=1724793437; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOcODjceGC7ZkW4fB/YT/SWFmfr0YR2DkMYRyu0vLoM=;
        b=kBdxge9CD0Uy8TRrKTF2yJt+1oYYnTIwejcLqB+yuR54Tvkgj3O8/60RkZlnlrdeC2
         0leKw/iqX2eI1WqMjKu7yicNUS+xjv+7rShPQoacUz5DCmXx5GzBOLuupZz5manTObfd
         vF5uM0q5x3GiMGAnH/hDUor0iurBwVDRrbu6T5oEDG1cOjkbTR1BxfmbzVW02/26ZAOi
         5DH7kuGtYCbILmleU6ZecNYQIlJkWXUxaT2Hd2i5KjG0sUps08IMgH8+dsLHry5jNKcp
         Efs1ec6QvsAP675b5tTU4cejFIMifkyLdntq3tWQ+8UWmiqD+z9BSTX/ZmWj/UVTGjol
         y05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188637; x=1724793437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOcODjceGC7ZkW4fB/YT/SWFmfr0YR2DkMYRyu0vLoM=;
        b=SRibJHcvZF3lY7zqb6EEqo3r45X1cVgq2sw4/lvRpRGRUOyHNZDjZNq0GLIWV3RD8Q
         ZHP4aeETPnA9dWJm7u7FdO82GWuc0hURn0oG/WsBWRz6IExZNr8D8HWPCDGaL7F0NNGB
         i91FR2uYQVQCHD7OvyauBWg5ocpls4qBxsC7LokGg4kxjhubnJ4e/9tGmsLBEQkQLFne
         6F6UdYtD1nuymuX1h/Wx4E7dW3eTiVIwDr4jAoZDyxR8JtR1YIVpnKDuWSHFT/+Uk0Ze
         HkE24kjVwGra0fvG1wb5clZ6qtjCqOEaJi2Z6uoZwfMzL9S4ayn010rULgW1rIJapFf6
         e3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVCP7K/RUaKAcDv/9ofRogT+rk/Dya+QCftY+uarXNhMA+CCTP1kil80l9EyOGS/Lb98vamPKHQUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3p/bQ3dZOTSKK9GdTwIVYkWFWitqxDRS7RLRHRwkbN4cSwESY
	VUutubDCMMyzaOsR61vbzFBpV75hk0x1FFATHvTnbo/mrqK6ZJXIsKmY5nzGu/s=
X-Google-Smtp-Source: AGHT+IH694ptJUT+W4npveoCOkWoEd/Bd4Fd/tTcyPr4LbEtrypfJeZqkWp1OWOohPWwkgyUxuRYrg==
X-Received: by 2002:a05:690c:6591:b0:6ad:ba92:1731 with SMTP id 00721157ae682-6c0a0ae8507mr6885217b3.41.1724188637088;
        Tue, 20 Aug 2024 14:17:17 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a66f388703sm62392285a.25.2024.08.20.14.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:17:16 -0700 (PDT)
Message-ID: <dff57198-7955-ec09-8909-671982834673@landley.net>
Date: Tue, 20 Aug 2024 16:31:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse>
 <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_141719_444781_DC082DBD 
X-CRM114-Status: GOOD (  16.01  )
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

On 8/20/24 10:31, Linus Torvalds wrote:
> On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> > +static struct vm_special_mapping vdso_mapping = {
>> > +     .name = "[vdso]",
>> > +     .pages = syscall_pages;
>>                               ^
>>                               should be ,
> 
> Ack. Changed here locally.

Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
somewhere to at least smoketest...)

> But I assume you also don't actually test sh...

But I do.

Aside: arch/sh smoketests easily under qemu, here's a relocatable binary toolchain:

  wget https://landley.net/bin/toolchains/latest/sh4-linux-musl-cross.tar.xz
  tar xvf sh4-linux-musl-cross-tar.xz
  CROSS_COMPILE=$PWD/sh4-linux-musl-cross/bin/sh4-linux-musl-

And https://landley.net/bin/mkroot/latest/sh4.tgz is a tiny qemu-system-sh4
system with kernel + initramfs.cpio.gz + run-qemu.sh with the config used to
build it under docs/ and as the first three lines of docs/linux-miniconfig
record, the kernel is arch/sh/boot/zImage.

You can keep the initramfs.cpio.gz and run-qemu.sh and swap out the kernel for a
quick boot to shell prompt under qemu. Serial console is qemu's stdin/stdout,
"exit" to shut down the emulator.

The build script, if you care, is 400 lines of bash:

  https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh

> It would be good to get acks from the architectures that still used
> the legacy interface.

I'll give arch/sh a whirl. Can somebody answer my above hexagon question?

>               Linus

Rob

