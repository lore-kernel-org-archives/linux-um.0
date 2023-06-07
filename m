Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E712EC77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtzhxgMaSxJwqftFoo0Shf/nrQPovppRTc+wfPwZVjU=; b=i3DLQQcZnZIBBl
	8C++qUXHa3QhAHgPmyxobXNf1DMg7mmhB6ioiDeH/xxNwjCLNshMGKoR6p0lsvfg6kUFEcqDAWvQO
	CUS5mce5t5M2dJBLTG7L3OXp9TXEgUhA0onui7L2nTHiYbHcInGnMN7PA5CXEzvxBKE5lAvmhXKlB
	XzwsOSBb8Z38wmoiMkreq6cQXResq0dQIb2KbJKd81HX1hl7GuID4IhytpiCWv17RZNK0AdCDiV+D
	eOu60xLN8jOWvWmhaiSw6u/2fZmuzP03mDLQfEJQw8fLbT0j/P6r/94+jmmx2F9NasPfIYzzUJ9Ce
	Id/Hiae1lAh59M9q3aRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phf-005JEY-1t;
	Wed, 07 Jun 2023 09:43:43 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phd-005JCZ-01
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:43:42 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so929323a12.3
        for <linux-um@lists.infradead.org>; Wed, 07 Jun 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686131019; x=1688723019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7De2dV56C4HlWldqRhiqrthNBSi3YmqE+PsGIwemH4=;
        b=Fxs73X18plukFoRmWCEATURAToiPof++AhV2rd1/T2MKXGmjDCPWn+q8ZXibWIJoCl
         fHfu9DBj0R01NVvwasXQiY0lKT1FhoYR2X+c5jE2FnzXFR9NQ6iXute09sA4dYi5/gck
         psOWHas6uKWqFB5zNcQ7IrWLWew12mqmJwAS2YNr2ADMxS+LziF4JcFGcR/G6Q7NeZ7C
         gnc9umHxHhpwxSNb/FTgvTAZTX6T0jxAAcpIFEs4lHfCZdM6nb4VJD4c8dc11CL9vYmB
         PP/GUtutiKFcuL2dMJlAWegEn3D5UBxmkW546B+kzx0X64ETqnOp9+wz6iaKHcNDX6z+
         mItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131019; x=1688723019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7De2dV56C4HlWldqRhiqrthNBSi3YmqE+PsGIwemH4=;
        b=OiPEuFOsyjmDuXf+eaESdZ04rjd4VPV/02RUp1maaQogrYsdJ/ZkT7uKBXjy3CA0qP
         7idlPzGGsUKFGs6Vqp7QaBmcNYX+YSQ9Tz+7dOgsotLQihPZk8LTnbc0cTyfleJZ/iYu
         rtfM81sLdbc1FXWM8M+ubYWgjwM5aR93qwosYSv9DPh+euqF2D6IHrgF8gWywl7TU88d
         Rj7WuWjVjkG38DklGgonlpTYjEKy8zhwENtkfaFbjc0aujayKh0cYdmChNZoWRs6COJM
         N9YjtqMHEB2ijObw4OFDRIkcTd88yje/19yQ89BdVXg8mSekkMy6QsNAf2aea8kT4+F9
         JeuA==
X-Gm-Message-State: AC+VfDzahxzCKcYQZCcylKQloWqJLh+QsprIsDFKUYT1xXe6UOapc5l5
	9m/tgrKVqx4O7+h6BTP4GuivhImabi6p6ybNWIPIUg==
X-Google-Smtp-Source: ACHHUZ5Zsd3dLhUTQg2QCup0RdocqPkCkN0n7M2rugZo5XtKl4/VHXYLtkyrTBeTzA0h2H5Q3Eo78GSAj7z6EomEI0Y=
X-Received: by 2002:aa7:c6c8:0:b0:514:7f39:aa82 with SMTP id
 b8-20020aa7c6c8000000b005147f39aa82mr3567915eds.27.1686131019731; Wed, 07 Jun
 2023 02:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-25-hch@lst.de>
In-Reply-To: <20230606073950.225178-25-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:43:28 +0200
Message-ID: <CAMGffEnM-XmQWjBu8EmXxFPouH9uQX45gL2PFW5vQJu5OaaYjA@mail.gmail.com>
Subject: Re: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool readonly"
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com, 
	linux-block@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024341_047629_B07B63C8 
X-CRM114-Status: GOOD (  21.29  )
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA5OjQx4oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+IHdyb3RlOgo+Cj4gU3RvcCBwYXNzaW5nIHRoZSBmbW9kZV90IGFyb3VuZCBhbmQganVz
dCB1c2UgYSBzaW1wbGUgYm9vbCB0byB0cmFjayBpZgo+IGFuIGV4cG9ydCBpcyByZWFkLW9ubHku
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KQWNrZWQt
Ynk6IEphY2sgV2FuZyA8amlucHUud2FuZ0Bpb25vcy5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvYmxv
Y2svcm5iZC9ybmJkLXNydi1zeXNmcy5jIHwgIDMgKy0tCj4gIGRyaXZlcnMvYmxvY2svcm5iZC9y
bmJkLXNydi5jICAgICAgIHwgMTUgKysrKysrKy0tLS0tLS0tCj4gIGRyaXZlcnMvYmxvY2svcm5i
ZC9ybmJkLXNydi5oICAgICAgIHwgIDIgKy0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svcm5i
ZC9ybmJkLXNydi1zeXNmcy5jIGIvZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtc3J2LXN5c2ZzLmMK
PiBpbmRleCBkNWQ5MjY3ZTFmYTVlNC4uZWJkOTU3NzFjODVlYzcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ibG9jay9ybmJkL3JuYmQtc3J2LXN5c2ZzLmMKPiArKysgYi9kcml2ZXJzL2Jsb2NrL3Ju
YmQvcm5iZC1zcnYtc3lzZnMuYwo+IEBAIC04OCw4ICs4OCw3IEBAIHN0YXRpYyBzc2l6ZV90IHJl
YWRfb25seV9zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUg
KmF0dHIsCj4KPiAgICAgICAgIHNlc3NfZGV2ID0gY29udGFpbmVyX29mKGtvYmosIHN0cnVjdCBy
bmJkX3Nydl9zZXNzX2Rldiwga29iaik7Cj4KPiAtICAgICAgIHJldHVybiBzeXNmc19lbWl0KHBh
Z2UsICIlZFxuIiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICEoc2Vzc19kZXYtPm9wZW5f
ZmxhZ3MgJiBGTU9ERV9XUklURSkpOwo+ICsgICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQocGFnZSwg
IiVkXG4iLCBzZXNzX2Rldi0+cmVhZG9ubHkpOwo+ICB9Cj4KPiAgc3RhdGljIHN0cnVjdCBrb2Jq
X2F0dHJpYnV0ZSBybmJkX3Nydl9kZXZfc2Vzc2lvbl9yb19hdHRyID0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtc3J2LmMgYi9kcml2ZXJzL2Jsb2NrL3JuYmQvcm5iZC1z
cnYuYwo+IGluZGV4IDI5ZDU2MDQ3MmQwNWJhLi5iNjgwMDcxMzQyYjg5OCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2Jsb2NrL3JuYmQvcm5iZC1zcnYuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svcm5i
ZC9ybmJkLXNydi5jCj4gQEAgLTIyMiw3ICsyMjIsNyBAQCB2b2lkIHJuYmRfZGVzdHJveV9zZXNz
X2RldihzdHJ1Y3Qgcm5iZF9zcnZfc2Vzc19kZXYgKnNlc3NfZGV2LCBib29sIGtlZXBfaWQpCj4g
ICAgICAgICBibGtkZXZfcHV0KHNlc3NfZGV2LT5iZGV2LCBOVUxMKTsKPiAgICAgICAgIG11dGV4
X2xvY2soJnNlc3NfZGV2LT5kZXYtPmxvY2spOwo+ICAgICAgICAgbGlzdF9kZWwoJnNlc3NfZGV2
LT5kZXZfbGlzdCk7Cj4gLSAgICAgICBpZiAoc2Vzc19kZXYtPm9wZW5fZmxhZ3MgJiBGTU9ERV9X
UklURSkKPiArICAgICAgIGlmICghc2Vzc19kZXYtPnJlYWRvbmx5KQo+ICAgICAgICAgICAgICAg
ICBzZXNzX2Rldi0+ZGV2LT5vcGVuX3dyaXRlX2NudC0tOwo+ICAgICAgICAgbXV0ZXhfdW5sb2Nr
KCZzZXNzX2Rldi0+ZGV2LT5sb2NrKTsKPgo+IEBAIC01NjEsNyArNTYxLDcgQEAgc3RhdGljIHZv
aWQgcm5iZF9zcnZfZmlsbF9tc2dfb3Blbl9yc3Aoc3RydWN0IHJuYmRfbXNnX29wZW5fcnNwICpy
c3AsCj4gIHN0YXRpYyBzdHJ1Y3Qgcm5iZF9zcnZfc2Vzc19kZXYgKgo+ICBybmJkX3Nydl9jcmVh
dGVfc2V0X3Nlc3NfZGV2KHN0cnVjdCBybmJkX3Nydl9zZXNzaW9uICpzcnZfc2VzcywKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgcm5iZF9tc2dfb3BlbiAqb3Bl
bl9tc2csCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJsb2NrX2Rldmlj
ZSAqYmRldiwgZm1vZGVfdCBvcGVuX2ZsYWdzLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGJvb2wgcmVhZG9ubHksCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJuYmRfc3J2X2RldiAqc3J2X2RldikKPiAgewo+
ICAgICAgICAgc3RydWN0IHJuYmRfc3J2X3Nlc3NfZGV2ICpzZGV2ID0gcm5iZF9zZXNzX2Rldl9h
bGxvYyhzcnZfc2Vzcyk7Cj4gQEAgLTU3Niw3ICs1NzYsNyBAQCBybmJkX3Nydl9jcmVhdGVfc2V0
X3Nlc3NfZGV2KHN0cnVjdCBybmJkX3Nydl9zZXNzaW9uICpzcnZfc2VzcywKPiAgICAgICAgIHNk
ZXYtPmJkZXYgICAgICAgICAgICAgID0gYmRldjsKPiAgICAgICAgIHNkZXYtPnNlc3MgICAgICAg
ICAgICAgID0gc3J2X3Nlc3M7Cj4gICAgICAgICBzZGV2LT5kZXYgICAgICAgICAgICAgICA9IHNy
dl9kZXY7Cj4gLSAgICAgICBzZGV2LT5vcGVuX2ZsYWdzICAgICAgICA9IG9wZW5fZmxhZ3M7Cj4g
KyAgICAgICBzZGV2LT5yZWFkb25seSAgICAgICAgICA9IHJlYWRvbmx5Owo+ICAgICAgICAgc2Rl
di0+YWNjZXNzX21vZGUgICAgICAgPSBvcGVuX21zZy0+YWNjZXNzX21vZGU7Cj4KPiAgICAgICAg
IHJldHVybiBzZGV2Owo+IEBAIC02ODEsMTMgKzY4MSwxMiBAQCBzdGF0aWMgaW50IHByb2Nlc3Nf
bXNnX29wZW4oc3RydWN0IHJuYmRfc3J2X3Nlc3Npb24gKnNydl9zZXNzLAo+ICAgICAgICAgc3Ry
dWN0IHJuYmRfc3J2X3Nlc3NfZGV2ICpzcnZfc2Vzc19kZXY7Cj4gICAgICAgICBjb25zdCBzdHJ1
Y3Qgcm5iZF9tc2dfb3BlbiAqb3Blbl9tc2cgPSBtc2c7Cj4gICAgICAgICBzdHJ1Y3QgYmxvY2tf
ZGV2aWNlICpiZGV2Owo+IC0gICAgICAgZm1vZGVfdCBvcGVuX2ZsYWdzOwo+ICsgICAgICAgZm1v
ZGVfdCBvcGVuX2ZsYWdzID0gRk1PREVfUkVBRDsKPiAgICAgICAgIGNoYXIgKmZ1bGxfcGF0aDsK
PiAgICAgICAgIHN0cnVjdCBybmJkX21zZ19vcGVuX3JzcCAqcnNwID0gZGF0YTsKPgo+ICAgICAg
ICAgdHJhY2VfcHJvY2Vzc19tc2dfb3BlbihzcnZfc2Vzcywgb3Blbl9tc2cpOwo+Cj4gLSAgICAg
ICBvcGVuX2ZsYWdzID0gRk1PREVfUkVBRDsKPiAgICAgICAgIGlmIChvcGVuX21zZy0+YWNjZXNz
X21vZGUgIT0gUk5CRF9BQ0NFU1NfUk8pCj4gICAgICAgICAgICAgICAgIG9wZW5fZmxhZ3MgfD0g
Rk1PREVfV1JJVEU7Cj4KPiBAQCAtNzM2LDkgKzczNSw5IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19t
c2dfb3BlbihzdHJ1Y3Qgcm5iZF9zcnZfc2Vzc2lvbiAqc3J2X3Nlc3MsCj4gICAgICAgICAgICAg
ICAgIGdvdG8gYmxrZGV2X3B1dDsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgc3J2X3Nlc3NfZGV2
ID0gcm5iZF9zcnZfY3JlYXRlX3NldF9zZXNzX2RldihzcnZfc2Vzcywgb3Blbl9tc2csCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiZGV2LCBv
cGVuX2ZsYWdzLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3J2X2Rldik7Cj4gKyAgICAgICBzcnZfc2Vzc19kZXYgPSBybmJkX3Nydl9jcmVh
dGVfc2V0X3Nlc3NfZGV2KHNydl9zZXNzLCBvcGVuX21zZywgYmRldiwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9wZW5fbXNnLT5hY2Nlc3NfbW9kZSA9PSBSTkJEX0FDQ0VTU19S
TywKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNydl9kZXYpOwo+ICAgICAgICAg
aWYgKElTX0VSUihzcnZfc2Vzc19kZXYpKSB7Cj4gICAgICAgICAgICAgICAgIHByX2VycigiT3Bl
bmluZyBkZXZpY2UgJyVzJyBvbiBzZXNzaW9uICVzIGZhaWxlZCwgY3JlYXRpbmcgc2Vzc19kZXYg
ZmFpbGVkLCBlcnI6ICVsZFxuIiwKPiAgICAgICAgICAgICAgICAgICAgICAgIGZ1bGxfcGF0aCwg
c3J2X3Nlc3MtPnNlc3NuYW1lLCBQVFJfRVJSKHNydl9zZXNzX2RldikpOwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jsb2NrL3JuYmQvcm5iZC1zcnYuaCBiL2RyaXZlcnMvYmxvY2svcm5iZC9ybmJk
LXNydi5oCj4gaW5kZXggZjU5NjJmZDMxZDYyZTQuLjc2MDc3YTlkYjNkZDU1IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvYmxvY2svcm5iZC9ybmJkLXNydi5oCj4gKysrIGIvZHJpdmVycy9ibG9jay9y
bmJkL3JuYmQtc3J2LmgKPiBAQCAtNTIsNyArNTIsNyBAQCBzdHJ1Y3Qgcm5iZF9zcnZfc2Vzc19k
ZXYgewo+ICAgICAgICAgc3RydWN0IGtvYmplY3QgICAgICAgICAgICAgICAgICBrb2JqOwo+ICAg
ICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfaWQ7Cj4gICAgICAg
ICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtlZXBfaWQ7Cj4gLSAgICAgICBmbW9k
ZV90ICAgICAgICAgICAgICAgICAgICAgICAgIG9wZW5fZmxhZ3M7Cj4gKyAgICAgICBib29sICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRvbmx5Owo+ICAgICAgICAgc3RydWN0IGtyZWYg
ICAgICAgICAgICAgICAgICAgICBrcmVmOwo+ICAgICAgICAgc3RydWN0IGNvbXBsZXRpb24gICAg
ICAgICAgICAgICAqZGVzdHJveV9jb21wOwo+ICAgICAgICAgY2hhciAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwYXRobmFtZVtOQU1FX01BWF07Cj4gLS0KPiAyLjM5LjIKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
