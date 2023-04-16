Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBFFC77B73
	for <linux-um@archiver.kernel.org>; Sun, 16 Apr 2023 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QkThLiQSQVlLE8oYx1yydXutyStZ3xDQRTM1CQhMMA=; b=3lINFUuMqVctUc
	K8Zbz1Uiy5YarJMWm4GVVBfzY34VyfkEzm4WnuWinydTV9jmV5RwUc54nl4c53OsFMkVN8cq94EtI
	Yw5/b8ggfvYAgiJB1AKloyAAyPUHkIUaRzF0Y8U79j9FVSa6KoCpSIEJz6K2RbMS1YcFIA4pmMGTF
	hNbH2sNBVH5rL1MVgMBO7ETSIhI/5v7NBNwy3UiM4mkDQqQYVkEcm42BqV5IGTYjsEQtLf03K3Rcq
	MBsVly44R6MCsaP9Ch3ljzj8RtWu1sWeICky2V3XxWYZD0/UbTZn+fi2JmAr/weCmAs5o2H0fxA/A
	GxGlxrv3gyajbzATHWQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1po676-00EAjR-1m;
	Sun, 16 Apr 2023 17:24:32 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1po673-00EAif-2e
	for linux-um@lists.infradead.org;
	Sun, 16 Apr 2023 17:24:31 +0000
Received: by mail-ej1-x630.google.com with SMTP id a5so1821494ejb.6
        for <linux-um@lists.infradead.org>; Sun, 16 Apr 2023 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681665867; x=1684257867;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY63/G4TmRjM6ksLWaejcWFKcBz6CRYb3Ge572PB5uI=;
        b=U1+i72aRUckc6eS0fVCS63lsPza0e6tTYoGQNSamylE948ElHaAGsuWFFGHL2iuDPu
         e8NviSxLFnlMs/lZlZ0Tzv0GrnwHCERWEGtVk/aP4tLGxw3TpSaF86F9dX+3PuNGl9QG
         77y58aMFcEszgcRnRRxuoEXqxpB/58z6fTFYsnH90x0n2adpHvMh7tA3RE9r+t4cohMp
         pZgAouS0fhSzjrrTBJuiRk71g8Z336OtdrJBKmpzdS3gM7NfXn9IfaPVzQjoMG3kEhij
         ReBhEXpzCpyitEN4vPxY2y5UWyJIeceo0oe7ZKOGsZkpVDyAuZSizsyhGRA3+huqXEp8
         mEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665867; x=1684257867;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lY63/G4TmRjM6ksLWaejcWFKcBz6CRYb3Ge572PB5uI=;
        b=APFuaSXLmraBm40q0G3kjVHTOE8RGQh9XmzXcqaGxwwIW78n9BhbLtS5GW2Y8rTYu1
         AFZD4oaNTby8dQGf4NOYocOMZys65uaru0/Jqt0CrxcZAPCsNDwHxll3f0KkpW1Nnhpw
         iO/lLTg9wcPYcwdXWMGpRoaP7Abqks59x4o6ykkdQeQImWPdTGB+4pELf9utizG+vS5r
         l9F3niUSH1hIkTUWktFYBeWV/zUKMQ1uHJmowo38VgNaktUoSdh7Ar9JL9LXkEkuFRjy
         flWdIJLsIXmK4Ts+WMn+lbO/CoqT5h6lcrKmbOF/oMHrvLNJpnpUMbFFZVyTP6eGnXEE
         I0CA==
X-Gm-Message-State: AAQBX9f3ItQDBJ22GYUbNfC8/NWJn7aSXZCNnpYHCUV0U1zbK2c7CR1A
	rREF3weTETm12zFarnQfX3hRy71ov3JB2iIV
X-Google-Smtp-Source: AKy350a34JnMGHGNSx7MF5ReMlcR9t8mpJQNYVFE0cq6o0NXdH6D95M15TIFaLlBMAc3YaU+gV4zTQ==
X-Received: by 2002:a17:906:595a:b0:94e:dc3c:cca2 with SMTP id g26-20020a170906595a00b0094edc3ccca2mr5257755ejr.70.1681665866687;
        Sun, 16 Apr 2023 10:24:26 -0700 (PDT)
Received: from localhost ([79.175.90.109])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7c242000000b00504937654f8sm4706775edo.21.2023.04.16.10.24.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Apr 2023 10:24:26 -0700 (PDT)
Mime-Version: 1.0
Date: Sun, 16 Apr 2023 19:24:23 +0200
Message-Id: <CRYCSOJIMYCY.3UJQ3W04LGKK7@laptop-fedora>
Cc: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
 <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] hostfs: store permissions in extended attributes
From: =?utf-8?q?Marko_Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: =?utf-8?q?Marko_Petrovi=C4=87?= <petrovicmarko2006@gmail.com>,
 <linux-um@lists.infradead.org>
X-Mailer: aerc 0.13.0
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
 <20230415164821.166606-1-petrovicmarko2006@gmail.com>
In-Reply-To: <20230415164821.166606-1-petrovicmarko2006@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230416_102429_880286_82734C14 
X-CRM114-Status: GOOD (  13.02  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpJIGhhdmUgd3JpdHRlbiB0aGUgdGhpcmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2guIFRo
YW5rIHlvdSBmb3IgYWxsIG9mIHlvdXIKcmVjb21tZW5kYXRpb25zLgoKV2hpbGUgd3JpdGluZyB0
aGUgdGhpcmQgcGF0Y2ggdmVyc2lvbiwgSSBub3RpY2VkIHRoYXQgdGhlcmUgd2FzIGEKc2VyaW91
cyBsaW1pdGF0aW9uIG9mIHRoZSBjb2RlIGluIHNlY29uZCBwYXRjaCwgbmFtZWx5IHRoZSB3aG9s
ZQp4YXR0cnBlcm0gZmVhdHVyZSB3YXMgYXZhaWxhYmxlIG9ubHkgYW5kIG9ubHkgYXMgYm9vdCB0
aW1lIGZsYWcgc28gaXQKY291bGQgbm90IGJlIHVzZWQgd2hlbiBob3N0ZnMgd2FzIGJ1aWx0IGFz
IG1vZHVsZSBzaW5jZSBtb2R1bGVzIGRvbid0CmhhdmUgaG9zdGZzX2FyZ3MoKSBmdW5jdGlvbi4K
ClRvIG92ZXJjb21lIHRoYXQgaXNzdWUsIEkgaGF2ZSBjaGFuZ2VkIHRoZSBjb250ZW50IG9mCnN0
cnVjdCBzdXBlcl9ibG9jayAtPiBzX2ZzX2luZm8gdG8gcG9pbnQgdG8gYSBzdHJ1Y3QgaG9zdGZz
X2ZzX2luZm8KY29udGFpbmluZyB0aGUgc3RyaW5nIHRoYXQgd2FzIHByZXZpb3VzbHkgdGhlcmUg
KHRvIGJlIHVzZWQgYnkgb2xkCmZ1bmN0aW9ucykgYW5kIHRoZSBwZXItbW91bnRwb2ludCB1c2Vf
eGF0dHIgZmxhZy4KVGhpcyBhbGxvd3MgZWFzeSBleHRlbmRpbmcgb2YgbW91bnQgb3B0aW9ucyBp
biB0aGUgZnV0dXJlIGFuZCB0aHVzCnByb3ZpZGluZyBtb3JlIGZsZXhpYmlsaXR5IHRvIHVzZXJz
cGFjZSB0byBjb25maWd1cmUgdGhlIGZpbGVzeXN0ZW0uCkZvciBleGFtcGxlLCBob3N0ZnNfYXR0
ciwgYWNsIGFuZCBub2FjbCBjb3VsZCBiZSB0aGUgbW91bnQgb3B0aW9ucyBhZGRlZApmb3IgUE9T
SVggQUNMcyBhbmQgZXh0ZW5kZWQgYXR0cmlidXRlcyBpbiB0aGUgZnV0dXJlIGFuZCBpZiB0aGVy
ZSBpcyBhCmRlc2lyZSBmb3IgdGhhdCwgYXBwZW5kIGNvdWxkIGJlY29tZSBhIG1vdW50IG9wdGlv
biBub3cgdG9vLgoKUmVnYXJkaW5nIHhhdHRycGVybSBhcyB0aGUga2VybmVsIGJvb3QgcGFyYW1l
dGVyLCBJIGxlZnQgaXQgYXZhaWxhYmxlIGFuZAppdCBkZWZpbmVzIHRoZSBkZWZhdWx0IGJlaGF2
aW9yIHdoZW4gbW91bnRpbmcgdGhlIGZpbGVzeXN0ZW0gKHdoZW4KbmVpdGhlciB4YXR0cnBlcm0g
bm9yIG5veGF0dHJwZXJtIGlzIHNwZWNpZmllZCBpbiBtb3VudCBvcHRpb25zKS4KCldoYXQgZG8g
eW91IHRoaW5rIGFib3V0IHRoaXMgbmV3IGNoYW5nZT8gUGxlYXNlLCBsZXQgbWUga25vdyBpZiB5
b3UgaGF2ZQphbnkgY29uY2VybnMgc28gdGhhdCBJIGNhbiBhZGRyZXNzIHRoZW0uCgpCZXN0IHJl
Z2FyZHMsCk1hcmtvIFBldHJvdmnEhwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=
