Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8E3FD5F8D
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJJC7J8TYX3p75NwqxB/sPsa5BlF3mMYrIh33Y5V5Yk=; b=snrbarQ8bMuRAuA9Q40Ku8tl+x
	Ij/6AzGm8N/KKZ0fdVqtTdKvT5Zj/2QvYZYR4fCZ/jcU/Vj5mFJMqNBqqQ4jagUmPvNIVv8wTXXWv
	tC1NXjthmVdkMpy3KkYzUMLIcVhe8W1baHy1JZ60nRdsppbrX95k2SiMYbbQy1+HDCfIwVyXST9pX
	UX10ZrwMezpjIz9EO8ZqTppzoxk5LSG830fv/67k8ps+N4ZjlEe/CWlzNpsfKsHQJ46Xk32fn9e6u
	NF2D/SI5HfMxeQo6MJLKVzLgg5/V+k3Meaj4O3BqFz3fSFZD3pPy3OSz24M+2DLmDBaSg/hBoDmwi
	Lasqmxgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAN03-00000008OMS-3NaP;
	Wed, 08 Apr 2026 07:06:55 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAN01-00000008OLZ-3pkZ
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 07:06:55 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-899d6b7b073so75732466d6.2
        for <linux-um@lists.infradead.org>; Wed, 08 Apr 2026 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632012; x=1776236812; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJJC7J8TYX3p75NwqxB/sPsa5BlF3mMYrIh33Y5V5Yk=;
        b=QJxyixDrELjikE08QyyonUlymHiSbD9X5HLTehP4pfjR2vA74rSIYHhWMJ30g9xDaz
         oEoz4LRvxTyUkwREkD8Bw5VyWNwmziNRN1RSCEzFZ5Lx5dVMcB1iJqIwwcrfXMjUx7n2
         ELllhlUwxSMTjv9SkK2x6vM5EUMZeu9nmrDQF6l+FGM1VkzTAcbJbQIL9KLhueQuEWv9
         D3HAS31E4R4sni295Cm2uvt594C/oKG538YForOO8Lf5m7h398c834fu3gzUQ8Y+wsI3
         N1WLSek8+8i2qM/T60YFTLZqMaIMZWRrSd1LPQ18w96BluH3zVhau7yIkjFqFzg3qCMY
         YRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632012; x=1776236812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJJC7J8TYX3p75NwqxB/sPsa5BlF3mMYrIh33Y5V5Yk=;
        b=Y+pWxHsuQjXJIZ/m/M1no1npkTXLMg0V9A/37sX4UGFjdnGpLT1nr6ZekdNnAM54f9
         BSmSLpjylfDpWz9e8zqweeBakJw9uiCmWWb2jAV9HEscsIsVAM4wiMOK+kQaoK2te4Xi
         IIAq5hgQGDLROEbzQjByHf/gIhj73Yn/ApnyVZu/lifnaEDz+VLyCgRtoqT7+3kleHrH
         bttGh62VrOssOY6P+IL5QQlaR79ZqAV7KWn1X5b98dMxg51VOcdvQaepsMYEwBRC0/BX
         cV5iaGlQSYSsONtrm/Z6kP864l5IKhLwJ8ob7ffBgwGZi3y3geiEeuy0hOEgNt2kSuBl
         Ecug==
X-Forwarded-Encrypted: i=1; AJvYcCUkD19QlsNt/1L4M/H8i82kTW34S1K763XJxYQiomTwxeMZVtgmNzk4HtVnV+6qi9w5hW2Cy/5zxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGb40QwjZe8tmkHnH4amj6JbI0vuzdR+LxHRJ3hreCBhDFMVjy
	5gA5Z1sS/W+L7TkzthTnOYoHmGYbQw8TYlyaEDIypP1zmzY2KQOM0z5t
X-Gm-Gg: AeBDiet6kYq3L+hszF+ISLgYmtPE+LPI5gQ0HoQ9XLHSg7pzIRQHz6n3LIgD/VXuoWC
	/060OHabeuX+RFZo3A+HWtfJy+d9dkbnV0wqnOtyBCdwE+lWHQXruWEJtvtmHbLIRy9yMAh14jV
	DcQ7tRuGbk5FTAjHi+d+fYg7z17T4US/KVjovcu1GXw2+8kl2Q2ngLwpyMIRJd9gFI8YMvdYl8L
	URjcBhBLqMiRXT7pV3Pg15+7sHzL/6EmyYCsFy+d0ya2ALEs3C52FhaYOlw9S1AbtZev3daQisD
	ma/laJ12te4mFIvXoE8LvlMW0C0MF5TxlD3E2ObtUfKBex2KEuVFjyz+5HiVIbfTvo6SJ9qGCRy
	3TS44PHzUQL/26OakB4ir7IWL4IlmCyNnbgKEz6Vrlk3Nb7/68TGJmUeeBJsgo5Ea3h6bO0mMrM
	f8STnIpjfuwifmuylKeUhu4tAxEsht5tR7FQeU6VF5Ce6ETW9MKPbl4fJjb6azerFvYkdKtw+Na
	e1/oqRskSVCVyjZUeF+8hid8jA=
X-Received: by 2002:a05:6214:260b:b0:89c:e55b:604e with SMTP id 6a1803df08f44-8a7025b43e0mr334134016d6.5.1775632012587;
        Wed, 08 Apr 2026 00:06:52 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm77574156d6.22.2026.04.08.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:06:52 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Wed,  8 Apr 2026 03:06:44 -0400
Message-ID: <20260408070644.2338858-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a2efd8145cfbc207fef5884e93d09f787811becb.camel@sipsolutions.net>
References: <a2efd8145cfbc207fef5884e93d09f787811becb.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_000653_958154_95576252 
X-CRM114-Status: UNSURE (   8.59  )
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

On Wed, 2026-04-08, Johannes Berg wrote:
> I think you should remove about 75% of that commit message, much
> of it is noise [...]
>
> Try without an LLM perhaps.

Thanks.  The irony of using these tools right now to help is that
since none of us fully trust them, we push them to more verbosity,
which ends up creating extra effort.  Appreciate your patience as
we all adapt to this new world and hope v3 hits the mark.

