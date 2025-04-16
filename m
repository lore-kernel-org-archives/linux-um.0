Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C999AC369B1
	for <linux-um@archiver.kernel.org>; Wed, 16 Apr 2025 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eFYkiEenzg/4pej5bcdOHyZ5zn5C2EU9yY/WMDy+oU=; b=Ol0h69eD9pYVw/gYRfEIJPBJQQ
	3lecE89gCHte3BfvIZ+U9j6yX9H7ec29epd0dRRRFkG608bgthlZaugSXW5q168BPpU05esw0BLTX
	3oBmj3cBD8Pzl8fy6ME1mYmqRuazgk//XatyM6QIajNcnfQvsJ80n4ieb38GsFPaATaegeyeC3ckJ
	qTAGRULqpVfAbEFpb67W2EBhU6kmTj/YKDiSIL86V7XzeOf7P20gnpdI154aNYno3NVGFsvVXTrWq
	ilM6eYvqTuYWfQ0mLcS9F+W9p5WOGfhiXmkP/IIqCev/3hF73w8YwQYk8ohn5+S+2GJKAAgHH5DAf
	sWT18i+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wkK-00000008Wrt-48Iu;
	Wed, 16 Apr 2025 06:59:44 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wid-00000008WBY-2VrD
	for linux-um@lists.infradead.org;
	Wed, 16 Apr 2025 06:58:00 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-54af20849bbso7916576e87.0
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744786677; x=1745391477; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eFYkiEenzg/4pej5bcdOHyZ5zn5C2EU9yY/WMDy+oU=;
        b=HJsh6dhNFZutlLoHZQaQGdwRoDRVG+/4zJBmNiECi263UiT2ZYu6rKXGpQaA7n/gcv
         WZzW3yFxXtlPBBea/+t00wrcX/wfOlIUbGUSst0IlB8t8w2kQmnJo1RQfXRk5EEsBNjy
         Akf4oPfC+UsEEYSMmvwkkus0FpND8+0567Qt1gWYTtDztJadt8r8ag6UVWoeKZAu5L29
         d/GE08ltjxgggopYGMj3lxHNx0P7lv0JTkTUbVASVCejNVAWSkj/J5LWMJM/jcEPry3s
         Fkd84a6yQcZ1MORJMKldaj9x4LY7VHOsDw12/CLDghqUH/LyTWCtPpXt6KjyEvoIvFUQ
         9BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744786677; x=1745391477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eFYkiEenzg/4pej5bcdOHyZ5zn5C2EU9yY/WMDy+oU=;
        b=G4PvuUpTFiMVrVnQHFGkIvmJljpO5Dk+EiyhPJLGHhF6B5I92SMHGx4Vw7/fYryMBf
         bUN4H89EhPi17HMGAqMuDVLN49rkRowQdEFJ2xL2WZC4mLBVx9il9oUZ0AP08xkSXWl+
         YqCeBDYo9ch/3wsMGpt4nbKCuqfdKNp7sOwhVL7lRMZ5RE2+V6iWStbZFGmxmn2HAIVF
         o1tge05GC9ujdlMt4uL2JX/7uKgLMXTeMg5kZyVHgvlAzejGLZEfhpZMbe5pUVGTEAU2
         Op+153uCjQt8fuqEb5jOcpmhqrhHyafLyqI2NIVCrgwWwZvSZE/yQVur9k9ML/7GCXSI
         64IQ==
X-Gm-Message-State: AOJu0YwR507wf3JXmFt3xIYEVsLJx+KbZuE7zvD12EotFrV1XGazAB2G
	IAc0vUXUeKkNp7pSBcLFIpYEZmnGu176SmTYQIs9JdR0KkY89m9mZvW4nFUzg1OqkIcSQKqTsIL
	aowIIOuLbCaIla1IJu4I6JEW3rWA=
X-Gm-Gg: ASbGncvG3UYeLNf9cECxOkZZo+5HqnXwx7zLdIMbs9Yw9bw/K+t3oW54fshVX9qkZ9T
	ldKyrX/yJ6lCGDUJmp2uelc+tbYmbA8o13fULnONRl1PrvdQ9rkj1z5kiaA3iYT49ijM87eydLc
	yAyh99W3hB9oAiKONjtb4l/w==
X-Google-Smtp-Source: AGHT+IGDG8EQyu2e91PlMcGHXOQUUS2M/UX2zORD22uy6GUwCCzWVy4INZkGFxhlM4V0q+NcTSO0+g+TDefdHJold44=
X-Received: by 2002:a05:6512:ac8:b0:54a:f7fb:ff82 with SMTP id
 2adb3069b0e04-54d64aa9f8amr176461e87.26.1744786677184; Tue, 15 Apr 2025
 23:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250414145650.10776-1-ubizjak@gmail.com> <20250415185558.112621df@pumpkin>
 <CAFULd4YV0yKTULPM-+Y0b72EJ48tqfW_ni8RjHsQTULT8TGaTQ@mail.gmail.com>
In-Reply-To: <CAFULd4YV0yKTULPM-+Y0b72EJ48tqfW_ni8RjHsQTULT8TGaTQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 16 Apr 2025 08:57:45 +0200
X-Gm-Features: ATxdqUExvVnEnRY0cmxDSz2Qf3qDtQT8dPVM3sFFqvWDSsanRiYI8WlkpkYb-0w
Message-ID: <CAFULd4ZtMrj+5Le0GArm5eTLw1AYiWLXPb_nXKaMDHy8TW60wA@mail.gmail.com>
Subject: Re: [PATCH] um/asm: Replace "REP; NOP" with PAUSE mnemonic
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-um@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="0000000000001a60c40632dfce69"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_235759_648722_621DB623 
X-CRM114-Status: GOOD (  27.85  )
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

--0000000000001a60c40632dfce69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:53=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Tue, Apr 15, 2025 at 7:56=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon, 14 Apr 2025 16:55:57 +0200
> > Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > Current minimum required version of binutils is 2.25,
> > > which supports PAUSE instruction mnemonic.
> > >
> > > Replace "REP; NOP" with this proper mnemonic.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > Cc: Johannes Berg <johannes@sipsolutions.net>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > ---
> > >  arch/x86/um/asm/processor.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.=
h
> > > index 478710384b34..233a7a0d29c9 100644
> > > --- a/arch/x86/um/asm/processor.h
> > > +++ b/arch/x86/um/asm/processor.h
> > > @@ -24,7 +24,7 @@
> > >  /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. *=
/
> > >  static __always_inline void rep_nop(void)
> > >  {
> > > -     __asm__ __volatile__("rep;nop": : :"memory");
> > > +     __asm__ __volatile__("pause": : :"memory");
> > >  }
> > >
> >
> > That only makes sense if you also change the function name.
>
> This function is used in several places, and is also defined for x86
> in arch/x86/include/asm/vdso/processor.h. The renaming should be
> coordinated with x86 and should definitely be a separate patch.

Something like the attached patch that also moves (duplicated)
function definition to a shared place.

Uros.

--0000000000001a60c40632dfce69
Content-Type: text/plain; charset="US-ASCII"; name="pause.diff.txt"
Content-Disposition: attachment; filename="pause.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m9jkxe900>
X-Attachment-Id: f_m9jkxe900

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaCBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaAppbmRleCA2MjY2ZDZiOWUwYjguLjU5YmQy
NWFjNzI5MiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3BlY2lhbF9pbnNucy5o
CisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaApAQCAtMTE1LDYgKzEx
NSwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgd3Jwa3J1KHUzMiBwa3J1KQogfQogI2VuZGlmCiAK
Ky8qIFBBVVNFIGlzIGEgZ29vZCB0aGluZyB0byBpbnNlcnQgaW50byBidXN5LXdhaXQgbG9vcHMu
ICovCitzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgbmF0aXZlX3BhdXNlKHZvaWQpCit7CisJ
YXNtIHZvbGF0aWxlKCJwYXVzZSI6IDogOiJtZW1vcnkiKTsKK30KKwogc3RhdGljIF9fYWx3YXlz
X2lubGluZSB2b2lkIHdiaW52ZCh2b2lkKQogewogCWFzbSB2b2xhdGlsZSgid2JpbnZkIjogOiA6
Im1lbW9yeSIpOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNz
b3IuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zkc28vcHJvY2Vzc29yLmgKaW5kZXggYzliMmJh
N2E5ZWM0Li4xNjkyMTk4NjRkNjEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zk
c28vcHJvY2Vzc29yLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3Iu
aApAQCAtNywxNSArNywxMSBAQAogCiAjaWZuZGVmIF9fQVNTRU1CTEVSX18KIAotLyogUkVQIE5P
UCAoUEFVU0UpIGlzIGEgZ29vZCB0aGluZyB0byBpbnNlcnQgaW50byBidXN5LXdhaXQgbG9vcHMu
ICovCi1zdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgcmVwX25vcCh2b2lkKQotewotCWFzbSB2
b2xhdGlsZSgicmVwOyBub3AiIDo6OiAibWVtb3J5Iik7Ci19CisjaW5jbHVkZSA8YXNtL3NwZWNp
YWxfaW5zbnMuaD4KIAogc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGNwdV9yZWxheCh2b2lk
KQogewotCXJlcF9ub3AoKTsKKwluYXRpdmVfcGF1c2UoKTsKIH0KIAogc3RydWN0IGdldGNwdV9j
YWNoZTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYyBiL2FyY2gv
eDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYwppbmRleCBlZWJjMzYwZWQxYmIuLmJhNWE0Y2NkYTM3
YSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2FwaWMvaW9fYXBpYy5jCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYwpAQCAtMTQ4Niw3ICsxNDg2LDcgQEAgc3RhdGljIHZv
aWQgX19pbml0IGRlbGF5X3dpdGhfdHNjKHZvaWQpCiAJICogMSBHSHogPT0gNDAgamlmZmllcwog
CSAqLwogCWRvIHsKLQkJcmVwX25vcCgpOworCQluYXRpdmVfcGF1c2UoKTsKIAkJbm93ID0gcmR0
c2MoKTsKIAl9IHdoaWxlICgobm93IC0gc3RhcnQpIDwgNDAwMDAwMDAwMDBVTEwgLyBIWiAmJgl0
aW1lX2JlZm9yZV9lcShqaWZmaWVzLCBlbmQpKTsKIH0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xp
Yi9kZWxheS5jIGIvYXJjaC94ODYvbGliL2RlbGF5LmMKaW5kZXggZTg2ZWRhMmMwYjA0Li5lYjJk
MmUxY2JkZGQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2xpYi9kZWxheS5jCisrKyBiL2FyY2gveDg2
L2xpYi9kZWxheS5jCkBAIC03NSw3ICs3NSw3IEBAIHN0YXRpYyB2b2lkIGRlbGF5X3RzYyh1NjQg
Y3ljbGVzKQogCiAJCS8qIEFsbG93IFJUIHRhc2tzIHRvIHJ1biAqLwogCQlwcmVlbXB0X2VuYWJs
ZSgpOwotCQlyZXBfbm9wKCk7CisJCW5hdGl2ZV9wYXVzZSgpOwogCQlwcmVlbXB0X2Rpc2FibGUo
KTsKIAogCQkvKgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdW0vYXNtL3Byb2Nlc3Nvci5oIGIvYXJj
aC94ODYvdW0vYXNtL3Byb2Nlc3Nvci5oCmluZGV4IDQ3ODcxMDM4NGIzNC4uMzFkNzExOTg3Nzhl
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni91bS9hc20vcHJvY2Vzc29yLmgKKysrIGIvYXJjaC94ODYv
dW0vYXNtL3Byb2Nlc3Nvci5oCkBAIC0xOSwyMSArMTksMTYgQEAKICNkZWZpbmUgQVJDSF9JU19T
VEFDS0dST1coYWRkcmVzcykgXAogICAgICAgIChhZGRyZXNzICsgNjU1MzYgKyAzMiAqIHNpemVv
Zih1bnNpZ25lZCBsb25nKSA+PSBVUFRfU1AoJmN1cnJlbnQtPnRocmVhZC5yZWdzLnJlZ3MpKQog
CisjaW5jbHVkZSA8YXNtL3NwZWNpYWxfaW5zbnMuaD4KICNpbmNsdWRlIDxhc20vdXNlci5oPgog
Ci0vKiBSRVAgTk9QIChQQVVTRSkgaXMgYSBnb29kIHRoaW5nIHRvIGluc2VydCBpbnRvIGJ1c3kt
d2FpdCBsb29wcy4gKi8KLXN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCByZXBfbm9wKHZvaWQp
Ci17Ci0JX19hc21fXyBfX3ZvbGF0aWxlX18oInJlcDtub3AiOiA6IDoibWVtb3J5Iik7Ci19Ci0K
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBjcHVfcmVsYXgodm9pZCkKIHsKIAlpZiAodGlt
ZV90cmF2ZWxfbW9kZSA9PSBUVF9NT0RFX0lORkNQVSB8fAogCSAgICB0aW1lX3RyYXZlbF9tb2Rl
ID09IFRUX01PREVfRVhURVJOQUwpCiAJCXRpbWVfdHJhdmVsX25kZWxheSgxKTsKIAllbHNlCi0J
CXJlcF9ub3AoKTsKKwkJbmF0aXZlX3BhdXNlKCk7CiB9CiAKICNkZWZpbmUgdGFza19wdF9yZWdz
KHQpICgmKHQpLT50aHJlYWQucmVncykK
--0000000000001a60c40632dfce69--

