Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169E8C3ABC3
	for <linux-um@archiver.kernel.org>; Sun, 11 May 2025 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sYnfyvuko3DstVBj9VsnghcCFLtVoXIoYcgRptdifpw=; b=S+o0G6+NaV5uNSX1j9YsOrKbI3
	4XlDbsUHS1ycqxRBqWJm9DYYwBPrcqZJUilJy4D3cLsseCixm3hsYx7n3wLdeaau8kSmSWqBjZxAM
	Gow648lC/KOauqVrtawXN4iwqHcg5+ECqzC2oHZZXaowyijkJ+hDUyGdLz1GWk14bWAdIyc7g7mGQ
	RWyNXaLG9XBSa9jS0RNP4MwwD7A3tVdbd/57LvXO4QTWT8l2HAkrETZQqE7PIgRDl3s5h+77zgIGJ
	H+KEWwdKp9vtG1iVQM14gpWRwq2Q4AcGnHWP4tJsC+qhQehCQxzNbcf6DJKRoH2gVo1/9aPNuqS5i
	+EbeG4nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uECvm-00000007mJe-42Hb;
	Sun, 11 May 2025 20:05:50 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uECup-00000007mFS-0rA7
	for linux-um@lists.infradead.org;
	Sun, 11 May 2025 20:04:52 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso26012845e9.0
        for <linux-um@lists.infradead.org>; Sun, 11 May 2025 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746993889; x=1747598689; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYnfyvuko3DstVBj9VsnghcCFLtVoXIoYcgRptdifpw=;
        b=kz2CJ29MKMWfgwi+FG3jqgU4HH+okPtZfhKxEEa2LjqGvfq8JaiBG79y1iuGIn1lGt
         f0gRxJzhh0OGboBP5ftp5B9UBY4sbRkR2r28y/IvjGImaB72gSDZ7oAbhjY2SIqBmubL
         flLtQ+c1jNEZd+VmsCm6nhS2zbSnBJ0q2EfBqd5XTS85jwve/j4BAyX7Vi7/YmoiDUe6
         SRx7eD/plUGwZUZI8+eUQf4Jw5vw/Yj58GDRMsLdsvixdZMzuz7a3zQrTJd5Va99Y2s6
         GpwqR9q0Fe+vGrl4eUSJpgG+1xldBTCD6z4FqgKj5S9rwh0fyrf/OjdTYo1oFUC2ijo8
         SNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746993889; x=1747598689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYnfyvuko3DstVBj9VsnghcCFLtVoXIoYcgRptdifpw=;
        b=OyTdqwXx+UQLCulriFqmROtqhN8oMHVTB1x1WG3eKpphuL8gy33t3zDyHZqUTHfVrL
         5oJ9lCIcuX+4TUGIaG8NUJeq1V7CRbe6l+HisJkQqxplFTOr5Nx9GVoBJ+7uy6VNwgqk
         G4n/RDZ8o9btgAw5KzHeetiRz93ZOntxrafEJ0yXQdpGfopNX8UBjvQaHDXvX3Wig6un
         /hCGeJ96fvJgY7wmPuX8FYUyIIrM4W3cpkr5wHIRshzCU7KjZdHiD3IHyBcTdVW3ALDM
         WEYud0LByB90XJwLsR8pJ8h7WGMHdDNq06Vd/i6p+f2ZYxZcIZpQBpDTfByOMo/Iemjd
         nP8w==
X-Forwarded-Encrypted: i=1; AJvYcCWGw6nLHiWDTiyGxR16HKvAIoyG7F/CajToOwV2znnNNPYu577omyKAF05GREV4WBhz/5vEQPdnLA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQBLKuwH67EmMvPc/FncC4k7FP59tmOsjXVd7vZrtp6BlNBiB5
	qmo3tOrU8CxL5Gi+8VkoYEtnuQFYBYpSHSonVuwaz7uRDtGFYQK3
X-Gm-Gg: ASbGncuqkTV1/MUhcIvFrtVohWulSz34//msOW0om+AQcHxxC9RvAhiyBceabKdOtGx
	1dVA91NMDt9OiAxlhz8Gx/9H/YzPvj7X1FtJA6lovPeBJ505eeH/VYbCLBwv4PvWj4AJ7UYlLbd
	VEWpRGmZ1/jRK9F58GM8selxWEQUf/yds66FCENWc+kVAnnzqRQfvqc5wz6s8hRKqEBL2AKln4n
	sDSzBvBYVSqF8ycvsb2UHKmDBYGhTKLpQp/nHKZDySlsxTkewV+GYHH4DYFLlpxetmKwrfgn/EJ
	YHM7XKFNhycHw3xEycRObRxaUPpAgtoV5vk6zOaUijANiCHze1S65IAZ9aN/c4ShMif4rSytUnb
	UDhYNiT7qo1Xp0M/PMQbYq16Fzi1yjiP+n3MCx6N+7qbVwfXdGSHgnXg=
X-Google-Smtp-Source: AGHT+IFjIJ/PiWP0rc5Lu8A35rP2o8sedXKOTMh73Xgvm5S60olcSUYwZBrdtBhLKmBU/xrQcLLW+w==
X-Received: by 2002:a05:600c:45d1:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-442d6d18ab4mr87990995e9.5.1746993888671;
        Sun, 11 May 2025 13:04:48 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c35sm101844785e9.5.2025.05.11.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:04:47 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uECsL-00000000RYg-3Q9R;
	Sun, 11 May 2025 22:04:46 +0200
Message-ID: <9086a511-bd3e-4a88-ad86-8c51d5a385ac@gmail.com>
Date: Sun, 11 May 2025 22:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding in
 time-travel mode"
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at,
 stable@vger.kernel.org
References: <20250509095040.33355-1-chunkeey@gmail.com>
 <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_130451_249502_2D29581A 
X-CRM114-Status: UNSURE (   9.75  )
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

On 5/11/25 9:23 PM, Johannes Berg wrote:
> On Fri, 2025-05-09 at 11:50 +0200, Christian Lamparter wrote:
>>
>> What's interesting/very strange strange about this time-travel stuff:
>>> commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
>>
>>   $ git describe 0b8b2668f998
>> => v6.12-rc2-43-g0b8b2668f998
>>
> 
> Come to think of it, often you just want "git describe --contains":
> 
> $ git describe --contains --match=v* 0b8b2668f998
> v6.13-rc1~18^2~25

yeah, I'm wondering if this 'git describe vs git describe --contains' could be the
reason why the patch was AUTOSEL'd? I have no idea how Sasha's helper works though.

As for UML: Your work is greatly appreciated. I've ran into this because OpenWrt is
currently in the process of adapting to the 6.12 LTS:
https://github.com/openwrt/openwrt/pull/18666

Cheers,
Christian

