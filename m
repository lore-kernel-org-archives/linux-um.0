Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DEEC369B1
	for <linux-um@archiver.kernel.org>; Wed, 16 Apr 2025 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ma56JdV1nhumd2hIrzxNZCq7YqsIb2ro3nhXeH33szk=; b=QMM2CWdLlya8ZuzvpSAvhOlrg9
	ozHosbzWjUlnvDioOH8fXzWMuLfAM51Tzgt+wMvZgSWhwVnpqcSqMoNDYKZUEMTmG/XGGXQY4XJ1i
	YHMs0geIC8X22olcfVaSEi9kETlz7rAdHQzt4zKq3/xB0zkS/MOyxuBSn7dL6ZVVTUYMB6ML/waqM
	PD4gE3v9bxA3TAECmqdAVYrK81vvvl6slREpcsaB9ko9aFB6ssZKA4bvwNXMMfN9jj8oHKEUKimXo
	ccuhFYH3sw68NUvYtSKGBlGuUxQMKs8zwi4sCsA+YgK65ryFXR4bKiuhY+OAi1RZyL4F/mRFuV0N9
	Wf3Mluyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4viv-00000008LLn-3xQZ;
	Wed, 16 Apr 2025 05:54:13 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vit-00000008LLC-0ymP
	for linux-um@lists.infradead.org;
	Wed, 16 Apr 2025 05:54:12 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-54c090fc7adso5068732e87.2
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744782849; x=1745387649; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma56JdV1nhumd2hIrzxNZCq7YqsIb2ro3nhXeH33szk=;
        b=DxiV75uD0cB5JA5m+FTzg0sVW/qCiUngFRnKeP83m2qb1IUjQtvoz9VUn8DvkkDYnf
         dfKQOvboNHYdzC4sMkxR2zOGC2X121gN1qb3ZckYRd7GXZCThtdbHFn9nVIxZ2Wz5YiD
         YJTKnJ/6T1qw9UK7REsdMp490E/Uq4nRVmCUcQf0vLIQ+tSFfzYn5Ygz9OJKaJelsbTI
         Vx0xaQf+XCWgephIR1hHTrZTwJnDTCKqidEW3wBnX8BSt4ZiRkoX36VmYXQ2CBLYsexh
         oYV6rAQe0peTOXxszKr5RvMxjS6GhoSbXVYNcGTrenhCL1fBZoKt6gchXvfigLovmMAU
         84sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744782849; x=1745387649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma56JdV1nhumd2hIrzxNZCq7YqsIb2ro3nhXeH33szk=;
        b=qdQCb7i7mKD4v06EehvOZIhIFO/BNxsjmoBy3q4RUX/nW1Peo+Ru+fI/z7JO0FDdN3
         aUd65b6t9vpeL/+QhXLNbo3d5T7p0fOmIJ/j3H4T6jR+s/Q75OxFcFMVSKn6UhoXu0YW
         R9esqr7QvrQBYQyEoaotJ2ZV+fEI2b3rvqmpvLYX59g5nCmAZH2BG0OSyavVPWFGROmE
         PH80Z3wZmyMG+Ex9ShEFzIjTYfvniqZasVkPUtPfB4Y8vigczj91ilTYguRxAyPcm6jb
         bhVBZq5+7izqOONeCgJYiz8q4Z6rtc+JKkxzDLRvi9u7PVa2Q8BdZSbj89XG0E/Boymx
         JB6Q==
X-Gm-Message-State: AOJu0Yx9Kobs79xUhxgU9Hl/HPsNlS5NoSN/r6jNs64gijTP+tuWGpYU
	dszjN6poMhet9KHZfsbj1e1pjpQHtrLDvTWjqtCMWjnwt2W0sD3IBdIYphF5Mbj4sHCeXd+LhOL
	oIlO4eP1aZaIH+9a8UdmAkD/1CEc=
X-Gm-Gg: ASbGnctUARXhccmI54FqouE1HLFyYe/4jNkM753nGNXfTFWyXzhLL4o5LjHIGIxFprX
	4BYdwl1l52HHnJ9cpbhbi4WJfini2RvMq1/1MyvB7gN2fUqNuqA97Za8sr3IvSDAA2fkRtM2Tp8
	+Wf6GHmQ++ZISlOANpJQCa8w==
X-Google-Smtp-Source: AGHT+IFKNOvvk/guKx+5UUNDUQ3VjKqbOOR/YrgZhnhd/s/Jt7rhsOWn5n+XMebPpbtROoWDcm4vmhTDkFWPo7tjwhg=
X-Received: by 2002:a2e:bea5:0:b0:30c:6f38:f675 with SMTP id
 38308e7fff4ca-3107f718b32mr1334801fa.31.1744782848194; Tue, 15 Apr 2025
 22:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250414145650.10776-1-ubizjak@gmail.com> <20250415185558.112621df@pumpkin>
In-Reply-To: <20250415185558.112621df@pumpkin>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 16 Apr 2025 07:53:56 +0200
X-Gm-Features: ATxdqUELBsckZ2mk1WsCsKoeAANw0iyzdNyTWIq2U13CXOfTkWqT8UIebtQcx5w
Message-ID: <CAFULd4YV0yKTULPM-+Y0b72EJ48tqfW_ni8RjHsQTULT8TGaTQ@mail.gmail.com>
Subject: Re: [PATCH] um/asm: Replace "REP; NOP" with PAUSE mnemonic
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-um@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_225411_270476_F4E7EBBA 
X-CRM114-Status: GOOD (  19.75  )
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

On Tue, Apr 15, 2025 at 7:56=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 14 Apr 2025 16:55:57 +0200
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Current minimum required version of binutils is 2.25,
> > which supports PAUSE instruction mnemonic.
> >
> > Replace "REP; NOP" with this proper mnemonic.
> >
> > No functional change intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >  arch/x86/um/asm/processor.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
> > index 478710384b34..233a7a0d29c9 100644
> > --- a/arch/x86/um/asm/processor.h
> > +++ b/arch/x86/um/asm/processor.h
> > @@ -24,7 +24,7 @@
> >  /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
> >  static __always_inline void rep_nop(void)
> >  {
> > -     __asm__ __volatile__("rep;nop": : :"memory");
> > +     __asm__ __volatile__("pause": : :"memory");
> >  }
> >
>
> That only makes sense if you also change the function name.

This function is used in several places, and is also defined for x86
in arch/x86/include/asm/vdso/processor.h. The renaming should be
coordinated with x86 and should definitely be a separate patch.

Uros.

