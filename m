Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58E5D0E6E7
	for <linux-um@archiver.kernel.org>; Mon, 21 Oct 2024 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldeRxmVxesBWJgkdZ2wLQ3QBzgC/wXtoI3dkl178Rls=; b=Ntab1kEEC3hptdbDYtnLsSaWUI
	ecUNpRcAl0LdUpEceL0n/3bs7KAXrSaBF24rBGUNpoiMKCm6D/LYDySBPvaK46hRrIkbhOknvo+ie
	iq6q4ObifBfohPm5Xwb9fB9qTyuCX1KDn2XAxbaT3isSa1yoYnHsRUGUOybDMY/g9YOl126Fiwrsp
	Nl3QqsXG8o6O6RpKQJLDpIu8y78jsy8SYJGWteI5OJyYMH1zI3IBIOPfFV/Ii7UG/6K95CUeao0CL
	bL/oX6+p5Sh3EjHS4FxOAImqSFczr7AaWvrNKxrehriYmFKb6nG5t0S24t8cgs4bO6txkWpKiI2Q7
	LEnTC60w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2peN-00000006tLA-0O2M;
	Mon, 21 Oct 2024 10:28:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pcj-00000006t3h-2nba
	for linux-um@lists.infradead.org;
	Mon, 21 Oct 2024 10:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ldeRxmVxesBWJgkdZ2wLQ3QBzgC/wXtoI3dkl178Rls=;
	t=1729506411; x=1730716011; b=ooVn4SRrGHbey0+QUMsnOP5+Q/xopu97eVgCgW1/HOGdrW4
	Uz7ggReA6ng9iVeZCx4geiMPEQaujSjccddjAJXgnjR3kDasM8WRhM8w6Bi9QtgJoM28JVaz54cRE
	nKyz2/lS4++USwtJKMQoG6QmnDWBfoi9JI9y2fsDn1C//A5+JN2qIaBz1MtM7QsBHJZehxYFYATul
	tPdtf6FT1+jZmY3XYdzwlksSOh6AjcuTJ6HqQXaxykEeXPCVELiHr7jG0AutxrA2fjQu6ColRoqyw
	6NM1r9uTFA7AiRKiUmjoW0bWd+xF558wV5PCQ4zWriBpnbWGouF9vrFhO+ERfjqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pcd-00000000k3e-1scN;
	Mon, 21 Oct 2024 12:26:47 +0200
Message-ID: <43f56c9d5bbbc93193b3e08622490e176bc915d9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix misaligned stack in stub_exe
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Date: Mon, 21 Oct 2024 12:26:46 +0200
In-Reply-To: <CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com>
References: <20241017231007.1500497-2-davidgow@google.com>
	 <CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_032653_744778_C179AEB4 
X-CRM114-Status: GOOD (  20.98  )
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

On Sat, 2024-10-19 at 13:54 +0800, David Gow wrote:
>=20
> Okay, it turns out this breaks clang:
> arch/um/kernel/skas/stub_exe.c:84:2: error: non-ASM statement in naked
> function is not supported

Fun :)

Interesting too, I've _definitely_ got some code elsewhere, that's
usually compiled with clang, using __attribute__((naked,noinline)). With
a quite old clang version, I believe. Oh well, whatever.

> And, looking into it, gcc's docs are not encouraging here either:
> https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html
>=20
> This attribute allows the compiler to construct the requisite function
> declaration, while allowing the body of the function to be assembly
> code. The specified function will not have prologue/epilogue sequences
> generated by the compiler. Only basic asm statements can safely be
> included in naked functions (see Basic Asm =E2=80=94 Assembler Instructio=
ns
> Without Operands). While using extended asm or a mixture of basic asm
> and C code may appear to work, they cannot be depended upon to work
> reliably and are not supported.

Right ...

> My gut feeling is that the "correct" way of doing this is to use an
> actual crt implementation for __start. I managed to get it working
> with nolibc on x86_54, but the sheer amount of hackery involved was
> not exactly encouraging. There are a lot of conflicts between the
> different headers for a start.

Yeah, that doesn't seem like a lot of fun.

> The other "correct" way would be to rewrite __start in assembly, which
> is annoying as it'd be architecture specific, so need a separate
> 32-bit version.

That'd probably be less bad than it sounds, since all the syscall magic
macros etc. in there are already architecture specific.

> The less-correct-but-working-here way, which I'm tempted by for now,
> is to get rid of __attribute__((naked)) and just use
> __attribute__((force_arg_align_pointer)). That's probably the best way
> of fixing the stack issue, but obviously won't fix any other issues
> which could arise from __start playing loose with the rules.
>=20
> My current plan is to send out a v2 with force_arg_align_pointer next
> week, unless someone has a more brilliant idea.

Sounds good to me. We'll find out if we have to iterate more ;)

johannes

