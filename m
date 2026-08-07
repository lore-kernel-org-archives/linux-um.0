Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F701C5AC7C
	for <linux-um@archiver.kernel.org>; Fri,  7 Aug 2026 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXecMis04p/qxD8Q75ODIPsKx6640DQP+yHLlpoDkyE=; b=ArvO09I+ETqOMyzkiAot7AXeT2
	cBxF9/fdw4MJpoZrpGeASUpjCjbaL5TCGzSwFhug1PqJXBzTtUDpJt/rHkg2wbwcGjQd72V+LSn/n
	WkIwVaSGZQG+JcbKkMhLAPTIl6fL3GX+pjvEHu0DfEuHL1Ej7lLv5KTEhvvbNEJZWxsQ0WBYALVI0
	0l538e5D2Tqk+Ry9B7VUtOX5uDFBnN/T4yfv73A/9lyRK7j4NSd48tTHPFh+l1BarwELnwmxEy+5S
	FCx6mrWX1qsaWWj6NR3WevuouvYXlSoxPG85Atq91yQkVedcJKPLAwHGApcsmrcp6LbZ7zqJ9UASZ
	iE624IqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsETr-00000007CIn-0ks7;
	Fri, 07 Aug 2026 06:54:59 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsETp-00000007CIR-2od3
	for linux-um@lists.infradead.org;
	Fri, 07 Aug 2026 06:54:58 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84f3ab8751fso483688b3a.2
        for <linux-um@lists.infradead.org>; Thu, 06 Aug 2026 23:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786085697; cv=none;
        d=google.com; s=arc-20260327;
        b=CY0GTEoD4UaehhoilI+Y7iixz7gX3pUVxnyMyvHHCEOskjNXppp0NYL73NWOWz0Cra
         gGIWjWbPtHqbaPD95bMqP0WJ5ReF38+VScMLYekznYGKb4iabz8iWTVReXPjmDh3WS5L
         Zwcwck2wWIz/c5BZAN9vuH4N1/vQi602+RQH1Y3i153mauVjsYPM2iK26axipJGqizsU
         /AgkIflUoiDRJTNYJ6MAb0d1gIRjwjdnTzWX3YvF1+N5uesMmsJk71jE9PhguZo8HD90
         Alqy2CfaEiCiqGOVioiaoMnrSpewRy23HDqrAuda0PouPbhAW9YxAfGIsLmrN853XEEL
         Ms1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXecMis04p/qxD8Q75ODIPsKx6640DQP+yHLlpoDkyE=;
        fh=lW37kVjvqm0KF6UWb/TNjL4NLMjABRJqipB2LUyGSIM=;
        b=oreHj1+fZ0hpYhJ6tkZLO4Isu3iYh4kAWYSCelLxkYxpL/tX2RhQuuYbua0QVOl5sV
         6pLB92iY2ReTWbT8wiDrrAO4qoDCkOLR6ntp1CzP/nfOWF5ZX1L0hobjL4/iw0TpsEaH
         ROsUCPpwKszVkp41xyygRXt1AyO/j9Z8HaBu61WcTMcxSRJk50jjvUZWQ5U4mlkCRt7k
         3RrZ83yZQTjCHCLtdicerddhoGOW+yO2JZ/Bl+RtKzLlmB2fIK5t+F8RWZZHoYsSJWHB
         xbm1w1fEMH08ie65Ya++VsQBGhtpE88DO9KAjbCztbaHk9XcMXfT4+HQGFltnMJ1bbak
         iZEQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786085697; x=1786690497; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXecMis04p/qxD8Q75ODIPsKx6640DQP+yHLlpoDkyE=;
        b=LRjQF8k2veSeLMKnskXL7xM3gsUGn16qE+1sByJu1LhoVfQMrCPYg52/3ZK2/QEb+/
         dT4KaMlnEFORDuyyj4NAipFVQDOVNbm+VHXPQOk4G8R2A5ejl2GeAygr97oj+7T+Lq64
         yank1kbwwb7UkvtHVGmahKIZZULGfN6HcznvEyKPxgl8OgkAuDR2tORqQC7scbz1gQke
         3Kg7b//znLPpXEasxlUmsjRbA365/hidGUhtzZyh12yWu6hg1oEXYLJB94Op7UpAc5c3
         NI/U8k+o8ff59HZmCxOStMUAPnRJSdMnTjXpkKlYt0LxoiKvOC0/HmOnnIpqC35W+xo3
         kx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085697; x=1786690497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXecMis04p/qxD8Q75ODIPsKx6640DQP+yHLlpoDkyE=;
        b=fDSoIWZA3SSO9JHnbMOENh2v1wo/Z+R/axvx9ki2PS1+CogYBbaLw7/in8adF5Fp7q
         sOYC9jcbQeoa/a6PFR5BAr2Oi2pv8R7d9MHgjArvfNZEFzULlpI6xSswHRllau9FE+1s
         ddMSxEMpan7c+H4gKWyigGKreWJEPplw6OBTHotG0HkrN2Q+bW127I/f69audoS3iXye
         sMlQFDALKkuFdPvMggzNOc1J3BUdYHra86IhFx8SKltd4IEo1CyYW2JEcTzZxzPKPAUu
         w31E/sXV4gmL4FR+rmN1lIVok1QVNTDcEBQob4/gPdL3hx9QdjlB62/TXnZYvO01kCpw
         JfBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzP5NTG41b+FfA6beCItql+Ry9tp/bD4uku7l0w+7Keg3KT9H5/ZqkrL4t2M2wFb8ou22BzqldZA==@lists.infradead.org
X-Gm-Message-State: AOJu0YywjLoR9rDWPpOSjqKB6nj60lDbAK0uNEPd0ycMO+v9WjL9tmk/
	F2Gscj+kDLC7ZLD7pV1LBZPrSdUD2Qgljh/ezgGxbtUgl6dmhtvgq7dyVuHrZtmiKU6cXQ1Sh3/
	b2+bJbZ/aGMccg6VRQlRyMmAxA8ZGA7g=
X-Gm-Gg: AR+sD11GRLG6QxZpQGAFU6A/3WZ0Quwu3BEpVyPOB6LkBrP5P9nBwtRL79W1TqBzE8o
	dp/1NYAtMV7hfBuOza0BTp89PWZilwGSu2bXkMRK2P/qruGulilghQi6ra8grjO82WOfDzSIEfO
	tgSeJSQPuw3h7z469wOMdQaH3SG+vkISssYJtEDoCgQRkDPClpqqir5E4zvy0erPZ9NiOQ4JiXU
	p3XQuAS5HJJjVeMVDONxNkS2qK0M1t3KLmL3dm5h5yxo0q5Du6a9AKXlETEot1DomVk3joXOOTZ
	X9Ho/rjUbKwzkcVJfBsEFv2kHWfuWl/UHlbYAQFRAA42eWcsKwTMgvtvAIywhTpxnl0FTee57PI
	lpGzN9c6BmrwAUJJrkJi6NEiineB1OodwBJh9nxrZyIol8AziLpLNrYjj9TVW
X-Received: by 2002:a05:6a20:9392:b0:3c3:a491:cd10 with SMTP id
 adf61e73a8af0-3cb85dcaf65mr15706800637.1.1786085696821; Thu, 06 Aug 2026
 23:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260801022501.722493-1-tomo@flapping.org> <CANiq72kzmPnu_UPHryLMSwGMmTruirNUL5H+aD4tMiNUqqRELw@mail.gmail.com>
In-Reply-To: <CANiq72kzmPnu_UPHryLMSwGMmTruirNUL5H+aD4tMiNUqqRELw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 08:54:43 +0200
X-Gm-Features: AUfX_myi2BDsNwM3e_swkA6TipakMQGHd_q39mA07wS2XPVsTvKNrOxsIPS0Pck
Message-ID: <CANiq72mRjEYce052YhAr5MAoiwCqYGbxs8aECjo-=gCqbmJB2w@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: fix warn_on macro build error on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, David Gow <david@davidgow.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_235457_738253_179947F7 
X-CRM114-Status: UNSURE (   5.81  )
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

On Fri, Aug 7, 2026 at 8:52=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> And Cc'ing David for UML in case he is interested.

Old email address from the contacts, sorry -- re-Cc'ing.

Cheers,
Miguel

