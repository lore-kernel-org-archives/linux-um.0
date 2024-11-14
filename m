Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E1FD637CF
	for <linux-um@archiver.kernel.org>; Thu, 14 Nov 2024 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sq9rNn9T//MSGQ4y0/1yL9tlfahIpW02mAaEWps24Nc=; b=VTNKNHUBhoFX3SibwwWhvL7B3M
	5TZ00DRVfws/zMyf2Z3ikFJYQces7BZbpwgEaQLUwi2h4uW3C2Vflz7EQrbr5m/XF8/8AZIkpbkPB
	Vf7BQ9RoGZ0RvdxDQ0pdRqzLVU+jw24rCjLUehOiVWpb+NUKa01W/nagHNphWON7y3pzS1RRDLRh+
	Ioa/X+yfrJmDd/PgvrmSfqodTYuVJe9B3Mq0Awu+fEOMvRW9p9r0YjV/laAtm53JYXfhVN1aKfFzE
	Wrdo2sW//K3cGOz5eUXpyND4eDkG2UhXMynb6i1+Y4Qjr1OPWPBI5VgP73ncbwcjhsNBHXiqytWN8
	hYbGlGfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOqD-00000008Ryf-037v;
	Thu, 14 Nov 2024 01:40:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOqA-00000008Rwt-1Gdz
	for linux-um@lists.infradead.org;
	Thu, 14 Nov 2024 01:40:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF3335C5BD9;
	Thu, 14 Nov 2024 01:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B73C4CEC3;
	Thu, 14 Nov 2024 01:40:05 +0000 (UTC)
Message-ID: <7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
Date: Thu, 14 Nov 2024 11:40:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>, geert@linux-m68k.org
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org,
 ricarkol@google.com, Liam.Howlett@oracle.com, ebiederm@xmission.com,
 kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dalias@libc.org
References: <cover.1731290567.git.thehajime@gmail.com>
 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com>
 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
 <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
 <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
 <m2o72jff2a.wl-thehajime@gmail.com>
 <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
 <m2msi2g15z.wl-thehajime@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <m2msi2g15z.wl-thehajime@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_174010_450964_A8902FB3 
X-CRM114-Status: GOOD (  22.97  )
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

Hi Hajime,

On 14/11/24 09:32, Hajime Tazaki wrote:
> On Wed, 13 Nov 2024 22:55:02 +0900,
> Geert Uytterhoeven wrote:
>> On Wed, Nov 13, 2024 at 2:17 PM Hajime Tazaki <thehajime@gmail.com> wrote:
>>> On Wed, 13 Nov 2024 19:27:08 +0900,
>>> Geert Uytterhoeven wrote:
>>>> On Wed, Nov 13, 2024 at 9:37 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>>>>> On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
>>>>>> On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
>>>>>>>
>>>>>>>>>> -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>>>>>>>>>> +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
>>>>>>>>>
>>>>>>>>> s/UML/X86/?
>>>>>>>>
>>>>>>>> I guess the fdpic loader can be used to X86, but this patchset only
>>>>>>>> adds UML to be able to select it.  I intended to add UML into nommu
>>>>>>>> family.
>>>>>>>
>>>>>>> While currently x86-nommu is supported for UML only, this is really
>>>>>>> x86-specific. I still hope UML will get support for other architectures
>>>>>>> one day, at which point a dependency on UML here will become wrong...
>>>>>>>
>>>>>>
>>>>>> X86 isn't set for UML, X64_32 and X64_64 are though.
>>>>>>
>>>>>> Given that the no-MMU UM support even is 64-bit only, that probably
>>>>>> should then really be (UML && X86_64).
>>>>>>
>>>>>> But it already has !MMU, so can't be selected otherwise, and it seems
>>>>>> that non-X86 UML
>>>>>
>>>>> ... would require far more changes in all kinds of places, so not sure
>>>>> I'd be too concerned about it here.
>>>>
>>>> OK, up to you...
>>>
>>> Indeed, this particular patch [02/13] intends to support the fdpic
>>> loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
>>> 3) and with) !MMU configured.  Given that situation, the strict check
>>> should be like:
>>>
>>>     depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTENSA) && !MMU)
>>>
>>> (as Johannes mentioned).
>>>
>>> on the other hand, the fdpic loader works (afaik) on MMU environment so,
>>>
>>>     depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>>>
>>> should also works, but this might be too broad for this patchset (and
>>> not sure if this makes a new use case).
>>
>> AFAIK that depends on the architecture's MMU context structure, cfr.
>> the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
>> loader to be selected"), which restricts it to nommu on m68k.  If it
>> does work on X86_64, you can drop the dependency on UML, and we're
>> (almost) back to my initial comment ;-)
> 
> I checked and it doesn't work as-is with (UML_X86_64 && MMU).
> restricting nommu with UML might be a good to for this patch.
> 
> even if it works, I would like to focus on UML && !MMU for this patch
> series since I wish to make the (initial) patchset as small as
> possible.  If we would like to make it broadly available on x86, that
> would be a different patch.

Makes sense.

I was only interested in the ability to run ELF based static/PIE binaries
when I did 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic loader to be selected").
I did the same thing for RISC-V in commit 9549fb354ef1 ("riscv: support the
elf-fdpic binfmt loader"), limiting it to !MMU configurations only.

There is no need for binfmt_fdpic in MMU configurations if all you want to
do is run ELF PIE binaries. The normal binfmt_elf loader can load and run
those already.

Regards
Greg



>>> anyway, thank you for the comment.
>>> # I really wanted to have comments from nommu folks.
>>
>> I've added some in CC...
> 
> Thanks,
> 
> -- Hajime

