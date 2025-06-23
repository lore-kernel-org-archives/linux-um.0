Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A24AC7115B
	for <linux-um@archiver.kernel.org>; Tue, 24 Jun 2025 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=; b=y1CfC+8PhxtJpWTYTedTLPO7s7
	WcgvrMA8+jHD6zVLHeFkb1IBvhljo/ZkLta1buCX+IuHyzIwy1ZytXD/4ilQ158GyiF2rrcC3A+1M
	xY75rAIa8TTXMTLp2/5wpv9fw/3FX/mulqDyGF9KRIOMlqAFNGRkrH76bCk7I8x4iyJf4jv8iuw1V
	9yxYG4k60LEyesuCJkhe0mSodV+hj8OZ/MdBTlZ3eg/fWRyWZoWm0BRRRidR67mnkyESUtfgBsM43
	m8uq/lWBe0Xx3ZNRLFVe1lGunOlbsHV2zgkzRKKhAtC/RdI387YB+ZHqi9xbucO0JPbcAcSA5XSGA
	ToUbXeBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTraI-00000004GNC-1glx;
	Tue, 24 Jun 2025 00:32:22 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTmAr-00000003jTz-1Yn1
	for linux-um@lists.infradead.org;
	Mon, 23 Jun 2025 18:45:46 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3300735f8f.0
        for <linux-um@lists.infradead.org>; Mon, 23 Jun 2025 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750704343; x=1751309143; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=QQlMhcf1Wm+PBgJFJoyIkxfLNPhX1AyHmY9hv/41k9QKeRViiDi9Q6dVoTendWCIpL
         7sSnR4bF/7dw8Q+/LMonvdJ84PAVzGD+cIi4fbHYSN/i5QJ5aJidR3Ls5JaOCJjzyvjD
         isEjonW/Vn+am9VqrVQWPotkW+xYoYuAfTBZv2oPvQY/GStpJ+LzMSJoVNVQJKzecm4l
         qBXjCgmLKVzQjmwN135oDJ5bQe0m5Gt1n9uD6+zMQGyk7irgFeRXGqSJf465HTeSR5NY
         p9Ndna2G2rZRTVzSbwYT+j7jzzFNuG2x6gGrQIT8qXXRxA5tfWOQZjZ0GAyTAJ0/bN7X
         4bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704343; x=1751309143;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=rStMA/CscAqb9jbcwjWbZGh6EV0BQ6QyDY9Vra3uTEmj33u28sQHU2NycfGKmXWNKF
         C30Wuu1ygD5RpqDNlS2trkVP9k7xW507vk2qv+zsGImJrmaN2HNx0SoJgbhwTNQvXPsT
         Gjd4jfJoi/4xipl8Io2AIaiZFJR1fnnOgOnijRp9tw45yFp4Kg3UJpgoHCAN4f+TQnAO
         v3456RIiVE5BRve1kIc/JBDnqnzFDkisZI40T/sNyHtSYQRB7hg9JYfHOPTJPVvcXOnW
         pKv9BK05Vx4Rvdr7x1by6AX3hdkuZYFGvGx3z9cD5SeKUbg0PSYydQlosJCKTG4VxZ7s
         tLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUGf7rO4cLewFkkeZIwMGG3/izyBrH4div2DXnc7EYOqazyBF2nCsDYUZ2SVcqGw9022B9g5jJJFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxyo8NTyrf7ixFiB8oaOk0cTwAk874aYjy+O9dfuLuEtHDKCZms
	SRPIId8FYR7XuX5l4O/HuUSz0MxMJnPf+RN/K1LoNpnsYRpGkl4aayYZIF+RsXtQr90=
X-Gm-Gg: ASbGncvIU8iQIyToTiHRKYTh69x9Nydzo4RIrNI2+XG8/nxmDlpNrjrb19UjEaDg5l0
	qAoIIkwWM/XcPAdxHPB8ARb/T9QLqkoiwCbO71uQPYonjBkXJDpGcALMwujE3qhkinpLldOJfBC
	YtQ/cC7hBtPklSBeZsLKmTCgsBclU/1liZSgahmDn/d1H/B2pcXxqaWgHwdWsn97qutVdIdI/96
	CcX4MYlWPpXBwUvzn45bC36pbZv4wK31N+7koo+IfWSpb0ijxuC5SQf3s9NLbRVujLIQaZYbiL7
	FA0FeJ7nuytM/cNMJcYC06L2i04CFID+6w8j5yZYn1yTPJWrrdO9CWVHXHA4k7WlY/D81YJGof4
	WSKsUUz6zpSxzjxAGyuBQKHMm
X-Google-Smtp-Source: AGHT+IHDRPumMTiGBj2bKfNpuQzAm+7VlyB5Tr2Ge/4ynqkxj9vUq5oRX4iaFtPKRy4untvXuea0VQ==
X-Received: by 2002:a05:6000:40e1:b0:3a4:f607:a5ad with SMTP id ffacd0b85a97d-3a6e7206acfmr430150f8f.19.1750704343074;
        Mon, 23 Jun 2025 11:45:43 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6ca165sm9303644b3a.172.2025.06.23.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:45:42 -0700 (PDT)
Message-ID: <49eed036f3c230d066ff44620c222fe5a2c3da1a.camel@suse.com>
Subject: Re: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel	 <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Date: Mon, 23 Jun 2025 15:45:37 -0300
In-Reply-To: <aEq9_kOoLSQwuYBq@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
	 <aEq9_kOoLSQwuYBq@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_114545_416061_A373F2B5 
X-CRM114-Status: GOOD (  19.78  )
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

On Thu, 2025-06-12 at 13:46 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:43, Marcos Paulo de Souza wrote:
> > Since commit 9e70a5e109a4 ("printk: Add per-console suspended
> > state") the
> > CON_SUSPENDED flag was introced, and this flag was being checked on
> > console_is_usable function, which returns false if the console is
> > suspended.
> >=20
> > No functional changes.
>=20
> I double checked potential functional changes. In particular, I
> checked where the CON_ENABLED and CON_SUSPENDED flags were used.
>=20
> Both flags seems to have the same effect in most situations,
> for example, in console_is_usable() or console_unblank().
>=20
> But there seems to be two exceptions: kdb_msg_write() and
> show_cons_active(). These two functions check only
> the CON_ENABLED flag. And they think that the console is
> usable when the flag is set.
>=20
> The change in this patch would change the behavior of the two
> functions during suspend. It is later fixed by the 3rd and 4th
> patch. But it might cause regressions during bisections.
>=20
> It is probably not a big deal because the system is not much
> usable during the suspend anyway. But still, I would feel more
> comfortable if we prevented the "temporary" regression.
>=20
> I see two possibilities:
>=20
> =C2=A0=C2=A0 1. Merge the 3rd and 4th patch into this one. It would chang=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the semantic in a single patch.

I liked the suggestion, I'll do it in the next revision. Thanks for
looking into it!

>=20
> =C2=A0=C2=A0 2. First update kdb_msg_write() and show_cons_active()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to check both CON_ENABLE and CON_SUSPENDED=
 flags.
>=20
> The 1st solution probably makes more sense because we are going
> to remove the CON_ENABLE flag in the end. And even the merged
> patch is small enough.
>=20
> Best Regards,
> Petr

