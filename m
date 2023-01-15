Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9820C3DA78
	for <linux-um@archiver.kernel.org>; Sun, 15 Jan 2023 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FcGzPJKHmC7dsHvcUW2isUMWhPWnvVxXesmU4k9fX2k=; b=STrMdKyPHBwu+Y
	XMjrCA9NQfBvtxriM2bdt/50nCHN4HjGw7LS/+AaNpQWN5cLVmHGAdO8vxAv/FKqHSYBfQNEWF0Oi
	BkP0vGHM1vhGF1uAjaHCScFXGmCGjJhevz4JRW5JxJOvq8b0D/VV+JWKqMueLP98VUcX/9XsYLir7
	RSBjd3lDSAj9cxcwVaBZ0m+rNBr8A+AMQZ3ooNzyrU2oXXtmfJZHRLaND2foYGg3YMuEMgyX/o2uT
	0EuN4wowotS7fzPyXN2Eqg3fTTMvLw9mfXQHe5adOtIe0hSaRP9yG47jIkhKkBTjSa466lFjVp5Ay
	O1Vw1+cezBT2e+foV2CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzec-0079GX-Gs; Sun, 15 Jan 2023 09:50:18 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzeZ-0079G0-LP
	for linux-um@lists.infradead.org; Sun, 15 Jan 2023 09:50:17 +0000
Received: by mail-ed1-x531.google.com with SMTP id b4so17488058edf.0
        for <linux-um@lists.infradead.org>; Sun, 15 Jan 2023 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJbXc+feWdrqTlshVGwB3Z4oTlL8/3Lfs4lGSV6qQxc=;
        b=SVOysDXI/KdXRRvrXHp0ya1LDMJuBWI61lpO+oK8r+0aY0CcpgvqzbUtdCl5zqYJLW
         isB7u9qMSzWpo6eY0TS6hauX8sJOWcviFR8RAwzFr2CVRXF+oTMAIriKigeZazZK1CoG
         HAj3ZyuY+W4j0jj7VINqFaK7aCX9jhqKoGUgeCxNZWPwaoV89H7JPZhUHTnSQ37a+ALA
         An3bX5fpT35o0TEQYAp4jWgWOenmUfSx+1MTB1cmFUnuvINZu6sXRMGqFil3Lm4ES5iF
         wc3mFjKJUT8wzf0E0mecWKemtuHyjH1qnsuIEFd0u81BWAam9kVqlmsm3FYamSyDkUMf
         tBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJbXc+feWdrqTlshVGwB3Z4oTlL8/3Lfs4lGSV6qQxc=;
        b=mVGIuPuEf+nLgWJbsps8ZcH7smFgejsVF2xFpIr2NVcBCdje9TTrsUWxmV/6ly4OdG
         z7OHJl5xxm1OIn76O5eJFGjCDdTfFcOXSWhaslkIbOL4O1R38UM5KhmNdiZfkDhIRJ2H
         dthpEZAuETGDtG+EVmTuccL78/8hSR8ilQVoVh0DqilVh56JGGr6qL8NJckP95RY9qEw
         oD2nfBneH65V8NlLOyiOSodLALjLluIVuzFIIw3ReeUEdAu5WGK86pjliGA49xodBfZi
         RRYEu4aTGGQhCwxVt15MHUW6ddAgHM0X8w8XzcL7gXvQHx7uqBm0qKbLPxengWKGTdqE
         AeCQ==
X-Gm-Message-State: AFqh2kpuiE+dLB0lQjQEK1zdtGdtPQoPNcuUmaLRNjRpHvza59IvrbET
	IbHryfvh4yRyDy9DogCmJ9qf36VmBtuG0mll+EU=
X-Google-Smtp-Source: AMrXdXuUzOa2guBRIiKB1uwuexgzh4m3A+XUo+2InfVEBiNvpDerXJvdg/SBbJSjUz5jF+ZBXJGEE0fQbEC1OHVw1eI=
X-Received: by 2002:aa7:cc13:0:b0:49c:bc23:e5c0 with SMTP id
 q19-20020aa7cc13000000b0049cbc23e5c0mr964850edt.252.1673776213567; Sun, 15
 Jan 2023 01:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-4-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-4-davidgow@google.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sun, 15 Jan 2023 10:49:37 +0100
Message-ID: <CAA76j91c1Uxo04Ymg8HszPOmiMjCzC08iDGL05m1ABa+u_Pw1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under
 x86_64 UML
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_015015_761039_B1096E57 
X-CRM114-Status: GOOD (  18.61  )
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

T24gU2F0LCAxNyBEZWMgMjAyMiBhdCAwNTo0OCwgRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUu
Y29tPiB3cm90ZToKPgo+IENPTkZJR19SVVNUIGN1cnJlbnRseSBzdXBwb3J0cyB4ODZfNjQsIGJ1
dCBkb2VzIG5vdCBzdXBwb3J0IGl0IHVuZGVyCj4gVU1MLiBXaXRoIHRoZSBwcmV2aW91cyBwYXRj
aGVzIGFwcGxpZWQsIGFkZGluZyBzdXBwb3J0IGlzIHRyaXZpYWw6Cj4gYWRkIENPTkZJR19IQVZF
X1JVU1QgdG8gVU1MIGlmIFg4Nl82NCBpcyBzZXQuCj4KPiBUaGUgc2NyaXB0cy9nZW5lcmF0ZV9y
dXN0X3RhcmdldC5ycyBmaWxlIGFscmVhZHkgY2hlY2tzIGZvcgo+IENPTkZJR19YODZfNjQsIG5v
dCBDT05GSUdfWDg2LCBzbyBpcyBwcmVwYXJlZCBmb3IgVU1MIHN1cHBvcnQuCj4KPiBUaGUgUnVz
dCBzdXBwb3J0IGRvZXMgbm90IGN1cnJlbnRseSBzdXBwb3J0IFg4Nl8zMi4KPgo+IEFsc28sIHVw
ZGF0ZSB0aGUgUnVzdCBhcmNoaXRlY3R1cmUgc3VwcG9ydCBkb2N1bWVudGF0aW9uIHRvIG5vdCB0
aGF0Cj4gdGhpcyBpcyBiZWluZyBtYWludGFpbmVkOiBJIGludGVuZCB0byBsb29rIGFmdGVyIHRo
aXMgYXMgYmVzdCBJIGNhbi4KPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEdvdyA8ZGF2aWRnb3dA
Z29vZ2xlLmNvbT4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9ydXN0L2FyY2gtc3VwcG9ydC5yc3Qg
fCAyICsrCj4gIGFyY2gvdW0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9ydXN0L2FyY2gtc3VwcG9ydC5yc3QgYi9Eb2N1bWVudGF0aW9uL3J1c3QvYXJjaC1zdXBw
b3J0LnJzdAo+IGluZGV4IDY5ODJiNjM3NzVkYS4uYTUyNmNhMWM2ODhiIDEwMDY0NAo+IC0tLSBh
L0RvY3VtZW50YXRpb24vcnVzdC9hcmNoLXN1cHBvcnQucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9ydXN0L2FyY2gtc3VwcG9ydC5yc3QKPiBAQCAtMTcsMyArMTcsNSBAQCBBcmNoaXRlY3R1cmUg
IExldmVsIG9mIHN1cHBvcnQgIENvbnN0cmFpbnRzCj4gID09PT09PT09PT09PSAgPT09PT09PT09
PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
ICBgYHg4NmBgICAgICAgIE1haW50YWluZWQgICAgICAgIGBgeDg2XzY0YGAgb25seS4KPiAgPT09
PT09PT09PT09ICA9PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Cj4gK2BgdW1gYCAgICAgICAgTWFpbnRhaW5lZCAgICAgICAgYGB4
ODZfNjRgYCBvbmx5Lgo+ICs9PT09PT09PT09PT0gID09PT09PT09PT09PT09PT0gID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC91bS9LY29uZmlnIGIvYXJjaC91bS9LY29uZmlnCj4gaW5kZXggYWQ0ZmYzYjBlOTFlLi40ZGIx
ODZmMDE5YWUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC91bS9LY29uZmlnCj4gKysrIGIvYXJjaC91bS9L
Y29uZmlnCj4gQEAgLTI4LDYgKzI4LDcgQEAgY29uZmlnIFVNTAo+ICAgICAgICAgc2VsZWN0IFRS
QUNFX0lSUUZMQUdTX1NVUFBPUlQKPiAgICAgICAgIHNlbGVjdCBUVFkgIyBOZWVkZWQgZm9yIGxp
bmUuYwo+ICAgICAgICAgc2VsZWN0IEhBVkVfQVJDSF9WTUFQX1NUQUNLCj4gKyAgICAgICBzZWxl
Y3QgSEFWRV9SVVNUICAgICAgICAgICAgICAgICAgICAgICAgaWYgWDg2XzY0Cj4KPiAgY29uZmln
IE1NVQo+ICAgICAgICAgYm9vbAo+IC0tCj4gMi4zOS4wLjMxNC5nODRiOWE3MTNjNDEtZ29vZwo+
CgpSZXZpZXdlZC1ieTogU2VyZ2lvIEdvbnrDoWxleiBDb2xsYWRvIDxzZXJnaW8uY29sbGFkb0Bn
bWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
