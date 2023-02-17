Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC3EC05027
	for <linux-um@archiver.kernel.org>; Fri, 17 Feb 2023 21:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6fOyvpjpugI5fvgFis/jZq/VxFhlvw4TuoCTq7xVZfU=; b=OhDpeFaPw/Gyeo
	0aEdOg4Ghn1/PLVBk5h6LUj970gE9a7YgqIVfPWADgHBr+cQ/ep61OdQzIg0WQhERbt+nagpR1SX4
	qgDrdfiNP0o9zPBv6Nj3FvIwutBYb4N53yrU6j6MeDVuef1XHd5Pdt04wkd1De4OvWuwJhs2XcQFY
	Gu4ifUsgIC3zroXiksQsTMHSCXruKZkFawyXthJTJWrjhU7KDTrXQcev4wlJCaJMdGDK1JGDEkdhR
	R9ZsxDmsy24qU/1t/R2NH/zN8uNKrLouJeJIwWXO8DEYcKa2p0slp1NE0PsfVilbp1AdgmqVHffVl
	hgY7ucYO2ku0Dvar1mng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8iv-00Fmyk-Fq; Fri, 17 Feb 2023 21:56:57 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8ir-00FmyG-Du
	for linux-um@lists.infradead.org; Fri, 17 Feb 2023 21:56:55 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id p9so2539671qvr.5
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jh0IhTqYjApq0TG14YhzT9SqYcPB/iVo7TaBsKf3FP4=;
        b=IV2FYpE2sYSxnqdf0EmPi2fFeHVGRlwzy5Fnv5cllbwqowlE2pRN2sjxwtU5fCDRqT
         WYUl890FNcOfwSV7FeGyzRP6hwEHmg4wHoH1pV8CS7AYVv/QFM1awdYiFm3actiggFsT
         t/B2zRvrkko5wLsBCbSFIsCDCQuvk8DTDOfHiryMOBG6NJgvtvR503FbANauiHzMgU7r
         CgYO8eKrZQsmoI4WaMJR6j7ak4vNzj0qFXx0QDjHLuXG2sixGcYt8yJT7SP16Xa6wGh1
         DQhls5rhu2km2IWp8m7OLvCzD/uSFajBOOtnuTmiohdk5oc+DyBbtf7QyDQ15E3mbuw4
         Uxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh0IhTqYjApq0TG14YhzT9SqYcPB/iVo7TaBsKf3FP4=;
        b=Z7s6C+x7zkMd0CklZbGQhZay9rpcELRIi7d1tQI+UJTJVjMTfJMZJTuctSe12O11jX
         1Cd4srQXh5SxLLfEwcURXK+KWgyyuCZE+uDrNCbQTztU+5odWn0YViXnkwBlQjee3Ukg
         Ur3mJdJQMvcFskM4c841BIF0Dcu7/CSMDYHnouccjXW4p7LsNt3e/VA72xhfWQZmtUaX
         H34Oa4yZcZuGIV5Z4gIX5onFCN1kchGDqOEMpivdEfjbW8MrMMWsfd1U6/2sFywUBB0f
         ynkszCca1tgKNel1Gf1r6FBmp+BLyELyS7zZRtSg4Vo6s9km0mox4lt/u442MbeHjQD4
         9nuw==
X-Gm-Message-State: AO0yUKXLIZAq1OBH8/zZ+5wMJvAtFob5iNQ0JSNsGNAnXZUFCaOQjpAy
	P/KulsVoUlJ0egGgQYKPOaqxXU/FJzwChlYS
X-Google-Smtp-Source: AK7set+zyIY+Ts6fo6RA/NJi0bDTQmbYg07D09fWkGfFVBOk3P+jTnJUQKr0d/CY2IPa/m41GUynfw==
X-Received: by 2002:a05:6214:d6c:b0:56e:8a00:f3a with SMTP id 12-20020a0562140d6c00b0056e8a000f3amr3924013qvs.32.1676671011002;
        Fri, 17 Feb 2023 13:56:51 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id o6-20020a37be06000000b0073b338b4eb1sm3922425qkf.133.2023.02.17.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:56:50 -0800 (PST)
Date: Fri, 17 Feb 2023 15:56:43 -0600
From: Glenn Washburn <development@efficientek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger
 <richard@nod.at>, Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-um <linux-um@lists.infradead.org>, Johannes
 Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-ID: <20230217155643.1c1b0b76@crass-HP-ZBook-15-G2>
In-Reply-To: <CAMuHMdWdQH=o9XNAj4YpTA8G7JMKPe+CJSCG2bRf_6H-u50PZg@mail.gmail.com>
References: <cover.1676532759.git.development@efficientek.com>
	<8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
	<20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
	<283287920.144364.1676588078240.JavaMail.zimbra@nod.at>
	<20230216153309.8b551086ed3a5015a7135957@linux-foundation.org>
	<CAMuHMdWdQH=o9XNAj4YpTA8G7JMKPe+CJSCG2bRf_6H-u50PZg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_135653_713077_A0200C10 
X-CRM114-Status: GOOD (  17.60  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAxNyBGZWIgMjAyMyAxMToxNDowMSArMDEwMApHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToKCj4gSGkgQW5kcmV3LAo+IAo+IE9uIEZyaSwgRmVi
IDE3LCAyMDIzIGF0IDEyOjMzIEFNIEFuZHJldyBNb3J0b24KPiA8YWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZz4gd3JvdGU6Cj4gPiBPbiBUaHUsIDE2IEZlYiAyMDIzIDIzOjU0OjM4ICswMTAwIChD
RVQpIFJpY2hhcmQgV2VpbmJlcmdlcgo+ID4gPHJpY2hhcmRAbm9kLmF0PiB3cm90ZToKPiA+ID4g
LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+ID4gPiA+IFZvbjogIkFuZHJldyBNb3J0
b24iIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+ID4gPiA+IFRoYW5rcywgYnV0IEknbSBu
b3Qgc3Vic2NyaWJlZCB0byBsaW51eC11bSBhbmQgbXkgdXN1YWwKPiA+ID4gPiBnZXQtaXQtZnJv
bS1sa21sIGRpZG4ndCB3b3JrLgo+ID4gPiA+Cj4gPiA+ID4gQ291bGQgd2UgcGxlYXNlIGhhdmUg
YSByZXNlbmQsIHdpdGggYSBjYyB0byBsaW51eC1rZXJuZWw/Cj4gPiA+Cj4gPiA+IFlvdSBjYW4g
YWxzbyBnZXQgdGhlIHBhdGNoZXMgaW4gbWJveCBmb3JtYXQgZnJvbToKPiA+ID4gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXVtL2xpc3QvP3Nlcmllcz0zNDIyMTIK
PiAKPiBBbmQgZnJvbSB0aGVyZSwgeW91IGNhbiBnZXQgdGhlIE1lc3NhZ2UtSURzLCBhbmQgdXNl
IGxvcmU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci82ODNkMTBlNzUyY2Q0ODUyYWM2MmVm
M2NjM2U5YTY5NzJhMDE3YmRmLjE2NzY1MzI3NTkuZ2l0LmRldmVsb3BtZW50QGVmZmljaWVudGVr
LmNvbQo+IG9yIGI0Ogo+IGI0IG1ib3gKPiA2ODNkMTBlNzUyY2Q0ODUyYWM2MmVmM2NjM2U5YTY5
NzJhMDE3YmRmLjE2NzY1MzI3NTkuZ2l0LmRldmVsb3BtZW50QGVmZmljaWVudGVrLmNvbQo+IGI0
IGFtCj4gNjgzZDEwZTc1MmNkNDg1MmFjNjJlZjNjYzNlOWE2OTcyYTAxN2JkZi4xNjc2NTMyNzU5
LmdpdC5kZXZlbG9wbWVudEBlZmZpY2llbnRlay5jb20KPiAKPiA+IFRoYW5rcywgYnV0Li4KPiA+
Cj4gPiAtIENhbid0IGRvIHJlcGx5LXRvLWFsbCBpZiBJIGhhdmUgY29tbWVudHMKPiA+IC0gQ2Fu
J3QgY29sbGVjdCBwZW9wbGUncyBmb2xsb3d1cCBhY2tzIGFuZCByZXZpZXcgY29tbWVudHMKPiA+
IC0gTm8gTGluayB0YWcKCk9rLCBzbyBkbyBJIG5lZWQgdG8gcmVzZW5kIGFmdGVyIGFsbD8gQW5k
IGFudGhlciBwb2ludCBpbiBuZWVkIG9mCmNsYXJpZmljYXRpb24sIHJlZ2FyZGxlc3Mgb2Ygc3Vi
c3lzdGVtIG9yIGFyZWEgb2Ygc291cmNlLCB3aGVuIHNlbmRpbmcKcGF0Y2hlcywgc2hvdWxkIEkg
YWx3YXlzIGNjIHRvIGxpbnV4LWtlcm5lbD8KCkdsZW5uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==
