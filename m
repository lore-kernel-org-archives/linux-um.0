Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA264C71141
	for <linux-um@archiver.kernel.org>; Thu, 12 Jun 2025 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=; b=ENgpcHRt6cl8+hev9lZmenj75O
	PGiU6PS5PMRuuNmYZUhK7W7YDrtbSEwThGm/GT5rCnOmWvUyjXVPBKXfs4C2REidcjWqfkrWl+jvb
	sWPaaIPSPYUxn7Omqj6ltPMnztxj/07CXFI7wAF22TB+B+Sws4uOH/gqz+5vDSSiQsmMQc78jJ5Fn
	8k+j8wYsNZ02Lm9NZ3RVbykUQh8wXKnaUqVQKXZaz89WpEWDeKTfP5sDWY42sxDAq9N3u1NovJa3c
	z43GRYumod9YAuomY4U1hEhm3BXs60UIZ86dzZ121RwClbItbooMFVVIPv40aq2qy51CMiafwzRIw
	PhgJtYVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPhqR-0000000DO7D-1Zs0;
	Thu, 12 Jun 2025 13:19:51 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPgQM-0000000DBaV-1crq
	for linux-um@lists.infradead.org;
	Thu, 12 Jun 2025 11:48:51 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4531e146a24so5440445e9.0
        for <linux-um@lists.infradead.org>; Thu, 12 Jun 2025 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749728929; x=1750333729; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=;
        b=KQjyvm6fkVT8GhPmTTa5oe0OqqbVX8U605f2/NAkNm/rtQslSq5YGVXKYn8sLEahUv
         7lut/NugPMkSxgObU4EPnfCKGjNA5a8onpMDLy322+EdIQgQKxr4apQCLPKuNKxG8TCr
         +Z8B3izKcHh3XaDwbjRRLYnoKyQbxQ5fwJZTJtUIEjerog7VwRelRYkNORmgQtk1sVIN
         wY7eSkoosiv0pmN9VYiLVxKhE0D7ObXzqkYbvQMi6oVsGTJjjgHs6wzwmAWZiSaZxl0A
         JHdHP+wcXxF9fgRe011xBhFnEHcZYd8+710as0Gbfd2DQGfSuJa8Brrw0DCT3UDaZkOJ
         +E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728929; x=1750333729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=;
        b=paGPtjvfms245OWEglf4iYjm1n5Oi/QJuUdqxuEoxKMsVTL7bpxFzxetf03Pu+LPVC
         IzyrDI6Fpjav5dDQ8SZ6aiQ1e7+4W/zf5+2e6jVO6lDTB17xnNptrOEcVDrDB827dJVP
         7ScUFzNx0g82n9Xxv8fvCIkivJouYnWHHH5HvCRtIKXL+pgE81713tEoOb8yw6GN2rTD
         HX7IdsMQh7c63CvkSHmFdL3Rn7Iz0cJtYYyhXxW6dGgR2MbHdIO+pgQT9eNO+BYJSuNe
         0strD8g1s1fvrP6y6BBrPI5n3j7PGCJ3cgi1++13KYas9Pf3aYGenhfE506ljz+Kwh3b
         tUIw==
X-Forwarded-Encrypted: i=1; AJvYcCWr7Xs7n7XlCGLfIMVlX0qqmK9ziEoorzcPrKGzx8uVVq3LxasO/jchUnjCRQr+gIotJTN65lJd7Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwczkJjbUpVjojZn/461i3XmEoVEiLsGVgE6epsD1rPXgpwex4
	m1pwoIOvSyMutsMKqsi5ss9ljeZ6AI83JilIFTVjOiA+RmUR89z3GsT26hrZWy4THYE=
X-Gm-Gg: ASbGncsGkp2DZC1p8oL5yMeH/MLZ6M5BT9cHP1L+OYP0EGnq4T9FZxSrgRCf3i/knF6
	2FTXcvTW6gd05bRzC/vcMO2holwsGSrQacPKV5Czb7jKSe8WatXqZfebNZbTDf51zTuz/grvka0
	hBVJ1XPECZ444XeY87ZCDrN4bMb9WEUkwpG5w8Ypq7AY/l7MCLzuO5QqZzXri7jd4xZ9196VxhG
	TbnmddJNb1Ez5EsH0Vujjs5NZlvmnkdLU82ZUocDYI4XwEjQG/lqhXZ7xsNpOpMWQrhvW0eOKpk
	qF1V6TcP1mvHUSoIpC6ksRrgfMAME/l9B3ep2LC9kr32i+wpj4OXcXmeqZrba/iV
X-Google-Smtp-Source: AGHT+IF8zRqV5wheeGN/Jp/GL6rwWbAWoucvbBo3Q9yO7s/hldTXZgL3tDSMI9f+6V734a8pX4n7YQ==
X-Received: by 2002:a05:6000:288a:b0:3a4:f7f3:2d02 with SMTP id ffacd0b85a97d-3a558695742mr5484054f8f.17.1749728928892;
        Thu, 12 Jun 2025 04:48:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d2b63sm1220811b3a.83.2025.06.12.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:48:48 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:48:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 3/7] drivers: tty: Check CON_SUSPENDED instead of
 CON_ENABLED
Message-ID: <aEq-jS3u90XCHCSS@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_044850_427182_948E6D26 
X-CRM114-Status: UNSURE (   9.51  )
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

On Fri 2025-06-06 23:53:45, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.

This patch "fixes" a behavior change caused by the 1st patch. Please,
merge it into the 1st patch to avoid regressions when bisecting.

Best Regards,
Petr

