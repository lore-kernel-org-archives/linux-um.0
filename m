Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0CAC0218A
	for <linux-um@archiver.kernel.org>; Fri, 17 Jan 2025 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whHgpC9NdP83/YfvPy6m/Zm1/eSoIWGpN2YA1mG9PX0=; b=gy/nbA/fFzF7ABp3ShGkm3zANY
	EWrEnTugte1vwbR/JaGFPVM2j1yy+LgtFLfGVHhVHsl9x0fFM7eNry6CMSOvFh7LT7+S8+/HaSrna
	5C3sYCNyhqKh5zWn/4rvsOKVQaAIjXjjumqj8iOTEu1Zpq2XAZllFQ7F3JocJJR6Ikogg7JLpMFRg
	5yCHECJ3nmDZjUiu1ZxlDSxAEXAYAV0uKAReLVljSIkxmNS1+pVzaAxVABLxhKW8BlD9RkFN42iV4
	G8/pVYdzIT5NuNNm3FX2mIEYE+wN18ZCdKqjGbx1/BcBG01mLV02//SpAz9d7hSATMQKi5Obq9P8C
	pQ2t54Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYoZp-00000000fF5-16BA;
	Fri, 17 Jan 2025 15:48:05 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYoWa-00000000ehg-1qYy;
	Fri, 17 Jan 2025 15:44:45 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso3235418a91.2;
        Fri, 17 Jan 2025 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737128683; x=1737733483; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whHgpC9NdP83/YfvPy6m/Zm1/eSoIWGpN2YA1mG9PX0=;
        b=AupTXCk/gy4HR81fQY98Qhimc5PdfQk8YWRsnbSwSno0m9nU5hbZJUGuiZHHIVPfom
         XhyoH55XW94DPPIsx9KupKRkGWiaqQ1VYX5GahctCKkNeypL9pog7H8ngmfqxdroAI5J
         Ni3GDMS71UAPLLatHqEyeaBjVm2TKUUCLbG2lXfqMM+/z64+QYBseaQ8fjazeE6tz80F
         ocMrIS+I35QrrdLx2w0u1Njs+sIu7HNBgoxnHryoyxgzGzrR/8tRneB96yoR7HCfzJG1
         EqRz515VFQfw0r12ahxGqmvZspS8zFCJegWUUlM1bPfkJ1uUkmz7n6obvi7YGWR802qB
         Na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737128683; x=1737733483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whHgpC9NdP83/YfvPy6m/Zm1/eSoIWGpN2YA1mG9PX0=;
        b=hnF1jIK/ctQhFmjzRfOmV+SFAvlJF4fsBfzmRSs6ftT1+TgUK3mgUoyChnFKu+RnM7
         jPD9EZp3r1hvxwd546PROc5jAIA6Ng3sq5yr/f1v1JSEjWgpePuFOvSaGmneTDHRDWtZ
         weA1H6GgIZ7Mcz4AX/R8T7K0yLHIwbPeSOPH6OwsPq6G6Vb7UJ+yiW45ERNmtyaNioZQ
         qD1KnyW+trX98KpmYLKMcuUkLTxIZ4DrH0hY6vJ0fwzht0ckyj8CD3DS1yti9TKIfvJh
         NunHUHGHk5Ai2kammFuA/vfqqYEopxkPgc3t4niLxpUT5MRLOCrtMtcgz+B6+CO+5spy
         QlNw==
X-Forwarded-Encrypted: i=1; AJvYcCUyCdhh7+J/IuUVx+QblxQOX9cDxa+BpNyZ/00pBGXzJ/ujFFDxabXutyqbADfD0bYcwQ/7EaZemkg=@lists.infradead.org, AJvYcCVfvs881vmehnW2NAaw/Nj+yUODnAzw8e1rdhBYIy9bK3dAn54iQV7kqfpunjg4wAtmqp7RF+PaYEh+zGuGF4O3@lists.infradead.org, AJvYcCVgjO6uXtigJFjTjK4e+SyRretF2orvbRHTz0jFYp2P31BZqL5qOIaSjaRV8BxiX9JdezbvYiv+YA089Bw=@lists.infradead.org, AJvYcCW7IZ3YEAar7wRjJ8J/7nEWaAux5MmIEnS9QDpd+TG0BhQPq/2BG2pjzZkzpcEbHji639iQ+XAggc1nk27JNEI=@lists.infradead.org
X-Gm-Message-State: AOJu0YwPN1KS9JzTqr4z7ugMBMHDqKPNR+ZwZOCi4WtPxwM+p4hM1Y04
	RBRWXH52AjuTtits4hB7LJrY9J0ZMcRFdya+L7xEfmUGqtoaK6gnuAIg1jJ8N3x249YKZ8Td9rS
	V6TGvt5zmOPk6EHK389obqJ79yEc=
X-Gm-Gg: ASbGncu7CkRXuXImdZ1SGz8aUkMCXhg5gEPEEjvAUBKyHVsCHm23qHO76guSlwrlzan
	qJwZOsmf038JZ5LP7Z6DtD5WTrTArBljN+MzeFA==
X-Google-Smtp-Source: AGHT+IE6c+RDPkVhdYpGhwJjY3swM/Kqbs9TiZQ1EhehCnKjqU+fLUq40RYGPSLu28v4p+m1VfknK3ci2deVkxFc/zo=
X-Received: by 2002:a17:90b:54cb:b0:2ee:df57:b194 with SMTP id
 98e67ed59e1d1-2f782cc011fmr4009658a91.21.1737128683175; Fri, 17 Jan 2025
 07:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20250113170925.GA392@strace.io> <20250113171140.GC589@strace.io>
 <Z4hs0X8RhGTuevnn@ghost> <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com>
In-Reply-To: <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com>
From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Fri, 17 Jan 2025 16:45:02 +0100
X-Gm-Features: AbW1kvb78AU_0HrrHV0OtjwO2uAvukZ8DnSGASVo_9Ya8_h5NunDjjnSIP4voz8
Message-ID: <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] syscall.h: add syscall_set_arguments() and syscall_set_return_value()
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>, 
	Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>, 
	Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_074444_481119_D5E917BD 
X-CRM114-Status: GOOD (  13.72  )
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

On Fri, Jan 17, 2025 at 2:03=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> I link the concept of this patchset, but *please* make it clear in the
> comments that this does not solve the issue of 64-bit kernel arguments
> on 32-bit systems being ABI specific.

Sorry, but I don't see how this is relevant; each architecture has its
own ABI with its own set of peculiarities, and there's a lot of
(completely unrelated) work needed in order to make an ABI that is
architecture-agnostic.  All this patch set does is provides a
consistent way to manipulate scno and args across architectures;  it
doesn't address the fact that some architectures have mmap2/mmap_pgoff
syscall, or that some have fadvise64_64 in addition to fadvise64, or
the existence of clone2, or socketcall, or ipc; or that some
architectures don't have open or stat;  or that scnos on different
architectures or even different bit-widths within the "same"
architecture are different.

> This isn't unique to this patch in any way; the only way to handle it is
> by keeping track of each ABI.

That's true, but this patch doesn't even try to address that.

--=20
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}

