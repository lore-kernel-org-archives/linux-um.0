Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934F4C5516F
	for <linux-um@archiver.kernel.org>; Fri, 31 Jul 2026 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78eASuWYN+bdMC8EWrF3gOKxrSi6Ec2rxlN0ZtVlNR0=; b=RP+IImNCeYNSpjjC7faNig2WR/
	3icLoJhwvcyZ9ebkCCs0JWLUhNAlQgKNsrjCIKl/x8tOcwoRrPt0OaeSGxCFJhP+FApb1rflXWnek
	zqZGN6IaEgSoXjtm/ftgY8aB+K4MYsng9o4FkxZ8/WVtx/I8PgFf4Qwd2zPnYg5aRl5qCsMeRZLX2
	0CvmX7JYU3v0DvhkM+3ar4gMtNz5wMPfRBqoMoUIlU8gfRBJXyGYD90vH+EZWKr34pBJK+uGdFTDb
	Dowo7U+VURr47kUlaO7B4ry/ypZW6RtT7kir/DIrc2Jx7n9pGVGkD8EF2BCPqskssLpkI+P9DxhLC
	degO0usQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpwSb-0000000DiS4-2cX5;
	Fri, 31 Jul 2026 23:16:13 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpwSY-0000000DiRe-2qPM
	for linux-um@lists.infradead.org;
	Fri, 31 Jul 2026 23:16:12 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-caf45fc5202so968731a12.1
        for <linux-um@lists.infradead.org>; Fri, 31 Jul 2026 16:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539769; x=1786144569;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=78eASuWYN+bdMC8EWrF3gOKxrSi6Ec2rxlN0ZtVlNR0=;
        b=mcb0HUbiAklrgDVwjUIzAeHFOBVKbiuqVtf87/1SxGUmwVB62I54vbGRgXvJGe3hgP
         ka3LAZFa4OOn8nPqX1ROQOO54EgPMinlxCxXlORfLe2mzLn9BSDrymOf9WdYa1tWPzWE
         O2TlBoXiVpLkKjt/DKfmcVrXSENNYpJ43KcJVQgx0O6hIOJDdrsBeNNmZJgDh3ksKMey
         ZrGJgxmqomhd0UiqQwre2WgY0Q8+nruH22yBXCtKyYKtvP0OnuiiBFjdSVsE/eMH4PXO
         4wDChwo+dH4CyA/YlO/1P6k0qolz3x9y5GcTWhJnBorJoAKrhTk/THsHnOTg3akzrkAd
         K/XA==
X-Forwarded-Encrypted: i=1; AHgh+RrLX5ogBq2pID/bivDK3nEsA1r7sTS2HQATvVvvfZ8YsAZr18GmNNYVYRHO44UZsE5ZTIgzTAm9+g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCFlaBzdOsjZp4BTO4ZrZuDMIOwAS2Ug2AzDbJlWusrTyi2k7O
	e0YiyrQd3h1R8q/m2Lf9FjcvR02tEzz9vwrl/LG2giopJmRpIXKXGk+SUkEYXd7tPij0GxR2v8w
	hgn64I+Xc/OdW00ytW1BS0sw9MCfpIPzmHhu8BXdzfQgiYV1026TvmuAg00TpK19P/miC0QKQeP
	bXAQ9zbyPVV5fkK4VqjCh276IfNBYzS8GiC49Qwm/gkOrAnF5UAcuFN8JBFOn5ZWYXnyncrBh9s
	R/3FeXfrIf2nUry1pPaaLly
X-Gm-Gg: AR+sD12QRDYjdeDuxG0Bs6/ulvNT/yBJLPp5h6/1gU5cCcEo/2zyPdHSekiJ9nFMnqE
	/tM9flLsWyQHVZSa781cL1kIOxa4flHkuEKh1ZbXSMH1dG/JOkG2/nEmn0V6b4pwcDwnnz7lcJg
	+8aVFKKscuWfLHZo0PHLBArAD0gF3OCvS7C0bYnjiAahREwvq2Ys4rv/GwLCIUdt+fbwOeV/p1f
	0wsXGa1RiL+22p8d2nlTAZCQZRGPcllHc1GfoEaM84gV9ypyC29YQplRShhXmstikrx9quDTMuo
	qESi5yeTTefxbhsOGqo+56Hu49GNK5qHoW1N/yMDWkVS0WToE0DBJjCfBzbyuUiA8YS91qte3zT
	obhZ3yY5R88wd5tgvZvZLj6z8f+DonuUGOynXHQqEhe+Qm39VVlb0AGBobTqWqnaN1om5z5+Gm2
	68s2zszlKKSNssgVBL+cU2eHcoqU8zJPbBKCpnW75a
X-Received: by 2002:a05:6a20:a105:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3c92a5342c4mr1381119637.16.1785539769272;
        Fri, 31 Jul 2026 16:16:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3153e2ae9d6sm175096eec.27.2026.07.31.16.16.08
        for <linux-um@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:16:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso25339655ad.3
        for <linux-um@lists.infradead.org>; Fri, 31 Jul 2026 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785539767; x=1786144567; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78eASuWYN+bdMC8EWrF3gOKxrSi6Ec2rxlN0ZtVlNR0=;
        b=C3xz8y3UxOpbwOkTAB8vZH34ndbs9+VL/HLNx5QLh4msarnFp6nC13ZPmv1D61l4fj
         Qw6FRXGuUt6mqJli+kV2oMTtGRT8fofZgKygphPvMMNzrIwqTajxmmX1TPE8GZ1JHYNH
         73toSyTYFab1SHAt9RGhSrzo4SYn9HulrLZqA=
X-Forwarded-Encrypted: i=1; AHgh+RohsTYhUe4CweTT196e9HnyT4/349BxvoTsQ37mgGgPWyNVApb4TjchT1r8AY4S2r6fP7629PSkxA==@lists.infradead.org
X-Received: by 2002:a05:6a21:3113:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c92a88f651mr1347627637.60.1785539767352;
        Fri, 31 Jul 2026 16:16:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:3113:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c92a88f651mr1347602637.60.1785539766919;
        Fri, 31 Jul 2026 16:16:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04506csm10341357eec.17.2026.07.31.16.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:16:05 -0700 (PDT)
Message-ID: <b8ec703e-145f-4466-8d4a-a67740098c15@broadcom.com>
Date: Fri, 31 Jul 2026 16:16:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>, Kees Cook <kees@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)"
 <linux-kselftest@vger.kernel.org>,
 "open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)"
 <kunit-dev@googlegroups.com>, bcm-kernel-feedback-list@broadcom.com,
 Greg KH <gregkh@linuxfoundation.org>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
 <2026073005-release-puzzling-8f07@gregkh>
 <20260730203700.stable-0007@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260730203700.stable-0007@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_161610_772794_99A2BEBB 
X-CRM114-Status: GOOD (  13.01  )
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

On 7/30/26 19:39, Sasha Levin wrote:
> On Thu, Jul 30, 2026 at 02:38:42PM +0200, Greg KH wrote:
>> Many of these are not in newer stable kernel versions.  So can you send
>> patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
>> missing patches for them, and then resend this 6.12.y series and we will
>> be glad to queue this up then.
> 
> The gap is smaller than it looks: 7.1.y already carries all nine
> commits, and 6.18.y was missing only two of them, "kunit: tool: skip
> stty when stdin is not a tty" and "kunit: tool: Terminate kernel under
> test on SIGINT". Both cherry-pick to 6.18.y with no adaptation, so I
> picked them up there first rather than making Florian respin.

Thanks Sasha! Before seeing your email I had sent out the two missing 
6.18.y patches:

https://lore.kernel.org/all/20260730190329.3388222-1-florian.fainelli@broadcom.com/

> 
> With that done, queued the series for 6.12, thanks.
> 

Great, thanks!
-- 
Florian

