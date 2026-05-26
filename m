Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB0CD5BD1
	for <linux-um@archiver.kernel.org>; Tue, 26 May 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=; b=2cYbAiyrWN8w2S6vm9Pwx/H7To
	pAeDF/o+hThSZweIocId3lRspmp2IU+u8SNjEDiqEdJ+jhen92YqeLk3VzVPfFFDPlPcXDAzkY9Ep
	SS1lhZdq8S6WBvbYLcNicxsRICPqddYV1vVnOXL37BRnNuunQd+l1AqrdbqTxof1ZhfxtfrlpZ5zX
	TOFCSbynTTVbXb/+dtvuCWVxJypYv5thgWlI5HkdSngp1uV7ux+SjacURpqUlWVoRTOyhlPaRrjrl
	y97rQLLr3lTa38rS8mJwZZydto8CCf6StRrX2F/dtnEouW5+79FKtLGrDT7uZ4+hj7izXCOOI0kSM
	ywQ7jEcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlf8-00000001CsP-2dSJ;
	Tue, 26 May 2026 06:53:14 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlf5-00000001Crf-1bbq
	for linux-um@lists.infradead.org;
	Tue, 26 May 2026 06:53:12 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-459bf19e87bso5943360f8f.1
        for <linux-um@lists.infradead.org>; Mon, 25 May 2026 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779778389; x=1780383189; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=X16mIuvoV2VkwYKdIC/vYaAST4V/m4dAJqSOD8qeO109d9I4JA0IyVIhkbUzhXZP53
         JraHKxas5GRxbzBhGPzR9Ngh4HefKV6yY6s5zAYNF5eYtuRBfFaQ1uXB2ESZR0xFXKia
         dL5tdkCeP9U7fWglvPPBTLElTQTU56Kw5VdbkJTlrKWjiFCKr4PGCE2iUkmNo+SUTpRR
         ft1sfyEbG5vdC2ZJZ6FjC9WYm+tZxVj3SCLoCTlIMABPZU+8mKPzhsXzGhgrlGelM8q2
         L2L3YRVdJStC61vUlTXFTpAQIliScXUDakZUPB8XnkfXqwwknBbWcVwQkwKw6CvvH1z3
         ft5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778389; x=1780383189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=mc2BuCMQwdQyAtj490dUb15Ll9e9cc91dkvmQih8i5C/xTtigiPIM8xjyb2DKFoefI
         OfeoUAGYt8WSB8CEWSKrLDKiDp4RuMIEcMwjEmqHwabwKJQx/47mo1DYpRV4pqtBjpJ5
         nFckBSYPfWfZvapLDv2rv1k+xkwVRMLqUbEx7eOMZcJRrfX1PhF3ilIrZxpO4bTi3QZo
         z4qsOyj19MsFy+2XHnFPE+FlnvhugXuVMTDGhVUrZJafA4HVLakHFOspKmijnu1JP9TK
         y+FG44zGcC6b4u2eXoO0Y9HlR5u6uW/vXbpIKNSNUQ6SzhGF2PVZoAJZ/oPGOtzSW9bf
         PUBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OwoF4FtoC4GASBmsNI3D3PBCkpABvP9maU6mDLG3WyFkAZ5SNIIoXlJAfch5hBs00G/tEBC/zeg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0bzwVZ74jWSmeHzNZYEJQCqgLFo43XqpCNrCJa9VxmrGLqYbW
	Sf7m2ew6842ps2m5F5UVvl9iHTMdLa/G8GsB7TFMWIG0w0hxglaV5/DLjbiyt1az74M=
X-Gm-Gg: Acq92OFvQKUyavvfVLhBOj61ELayQMD80eDomx82sPam6owR8YqMxsyvaQEzVAMIOkc
	h7Y5OyjgJeCLPdd6UJ1uc5MDX6ySJmyEJ5E5PoFdFI1azIim1PzmnhBUbB/weZTSbx2CVP71IlQ
	uodEICD49mvD2Bq7TxdhHRqcAL+00JAGuth1MlyO78xB0fjr0cc+pgZ0WqckM7S9YPoUa9H24X3
	7AvwGrYgLTiFCdimfwpxb46dgHpJsxfURdbUqOXfAyyXqUlhgCHsLzGE4WLXrUXTGIz38Anyx6x
	Y67A89JlV4MZU+e6gjE538UKjeCMqoTuxuIf8gTPGapvxMrvVTK1lCTgWY99JedptxxOcUIWWsh
	AVvFYerR+ac/2Nd/p7qy7zieeOMZxf9sQFYyRpFCXkDoPbBW+hkWTgZDWWeNExGXYsfw6N9zMGI
	l0d/uSkDFSg4kys5lvGE6Uctc6EzBFz7bTqm1HuGVccoJXeaatI+AvbiGNYnJmh/16n/mNFaKzG
	5CQfvgZ1JawPgmRE5GkZMx44NJVLyQRVg9pYDCcP9cic9k9G/hOJsvwNEjrjVZO2ZNYF+db641Q
	RObS
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr29516257f8f.38.1779778389230;
        Mon, 25 May 2026 23:53:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm33848641f8f.8.2026.05.25.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:53:08 -0700 (PDT)
Message-ID: <88c5ca1d-eeda-4023-bc7a-397b92780db9@suse.com>
Date: Tue, 26 May 2026 08:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Convert moduleparams to seq_buf
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_235311_582168_81418052 
X-CRM114-Status: GOOD (  20.80  )
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

On 5/21/26 3:33 PM, Kees Cook wrote:
> Hi,
> 
> I tried to trim the CC list here, but it's still pretty huge...
> 
> We've had a long-standing issue with "write to a string pointer" callbacks
> that don't bounds check the destination (and for which the bounds is
> also not part of the callback prototype, even if it is "known" to be
> PAGE_SIZE, which sysfs_emit() depends on). Both moduleparams and sysfs
> use this pattern. As a first step, and to test the migration method,
> migrate moduleparams first.
> 
> There are 2 "mechanical" treewide patches that are handled by Coccinelle:
> - treewide: Convert struct kernel_param_ops initializers to DEFINE_KERNEL_PARAM_OPS
> - treewide: Convert custom kernel_param_ops .get callbacks to seq_buf via cocci
> 
> The last treewide patch is manual, and may need to be broken up into
> per-subsystem patches, though I'd prefer to avoid this, as it would
> extend the migration from 1 relase to at least 2 releases. (1 to
> release the migration infrastructure, then 1 release to collect all the
> subsystem changes, and possibly 1 more release to remove the migration
> infrastructure.)
> 
> Thoughts, questions?

This looks reasonable to me. I added a few minor comments on the patches
but they already look solid.

-- 
Thanks,
Petr

