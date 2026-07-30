Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF617C55164
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M89kfycQcHjbtSp4KrMwssDD/glAdwj31Koyk+WC8Sk=; b=TCZg7J1mktmjvZecIz5dfCuqeA
	6oMCbz9N7MIPg46lAKr1Trze0BoW1Bqt5llMkHh4HKfe7AMMGJpFZmGBA9TqIRBoXdXpy10kvbT9L
	q4F0JZRF8HEl1RFYLSRan53TpBtX4sTYklG5AFiQ5+uIYghYsf8Ab+RDiNj7techHiNptdY4mbvfJ
	Q1LD6iGE7M3ixWwfYJT8wTMzz7EHL1EGNLna4Eni8WbVmQ3bpy0gAEiSRmt8T90Loe5JjySinrR64
	0sHQMxL/bidyHtNrAH/EkP40FN+WqAN4OPoseZZQUuyV6903tRVaD+71jldHV1iGTQkbqnSDUPw+U
	0ECDAQfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTI5-0000000Awlj-34WO;
	Thu, 30 Jul 2026 16:07:25 +0000
Received: from mail-ua1-x962.google.com ([2607:f8b0:4864:20::962])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTI3-0000000AwlG-33iW
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 16:07:25 +0000
Received: by mail-ua1-x962.google.com with SMTP id a1e0cc1a2514c-9773c6ea885so699193241.3
        for <linux-um@lists.infradead.org>; Thu, 30 Jul 2026 09:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427641; x=1786032441;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M89kfycQcHjbtSp4KrMwssDD/glAdwj31Koyk+WC8Sk=;
        b=PoptjCE+pJ10GfzMXsIIBi0VghC86cjHV0uTArtK8tValkfsWcvJ42+4jONWdmIZ56
         768x7+fFfyRSWnnPUsF99Q2JTn/512VXkEyQBy9bl3jIS6TE2hy8I0VPlvn/V51pMFQo
         nOZLjeCB5HqNLmfh2HnPuKwq67D9yIaoIolblg0TQk96xZiLVdpRxJ4Z0aCPtdx8yGln
         9AfdUVw6t4Yb7AMvAHG2FaxwCUCJgtLL5BL6BcuWKm1/Upoy2DbUHIcsxyrhRo0Hq7iO
         UWjAtt9JjIWZK1DkUE9FXyIE7rtjPbz350rso9TQfb2hXFIU2FbyJk4yUpNtLc/hq3hb
         xseA==
X-Forwarded-Encrypted: i=1; AHgh+RqOHyOuUjrN7DtX6ziXc09qXt7e57Fkz1XGD6pVyuNH0oiQt0f5Sg12m0eiPNzDP4d34Ph9xx53Bw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxYNMKwjUMispw6h+fxb8bTThrwXVh3j6vUr/DgnBxUArGmL/Yh
	Ydl20P+qp9DBeDV7gVwsfIfGf9UrNC72V4FNkVJSQGTdBuOq/uqtkIh77EHpiZ7OX6XPEt0QTUj
	8MDraJR+AUTMn9Gr/mVR7Q2Ur2/s3lLE15F1sFhWVu0xVwTAjC0hu3PS6IYcxz9A9AhXwt5bzry
	qyqgwkTiemlGkJMRiDinr2OAMKZn47+AgZ/NGTJqWkU47mjaA+5mpZlJHmQN1ona1plfoDMKhx9
	DZ3wZm8BNSk9jlFaVbg6rEr
X-Gm-Gg: AR+sD11qx/pR6CTP6hX4pBktt5hiq5Ek9hvWoiJbGCbwqJsCzze4mxW5HsWRvXgDeYy
	h3bGbrKKCrggPyw8l55ML8ZAr0Ri5UFrSsm5GEHxz4qNm5ikTSS9Bmljlpu01Q34Bl9sJxp9Xcw
	dJC6enKEKzm/BRPKNh3mW7rUqdmD7MVI+cQapZB6zGAfpwBhRa148Pd3Qfy9/CQIKh/9KJZjA2B
	Q0CuThF9/Cx7QDEhKkYcuY3rjmkcFfZyG02aVv8/84HJizfdOkMbBbmN3PVA/R1TxArGoi1EBgm
	sCjfsNEbzHFt0Gv74ufZqcaoMQxg0I6yHf1UGGgAZQQGLRmkXx6Yr08CmLTwwnvH0rabsl9hN/k
	xDN2pGeqng9zN0JeT7TXpQRp4imEU58CQjs1EpeBv1AewuU12WvQqp0JSFvGDSRQI4qgNV+7g1+
	2+UB8/XKhg/eBFmp0BFe83rqblcSImkMwCdNEaV8tu
X-Received: by 2002:a05:6122:4f9f:b0:5c2:c0ae:c2de with SMTP id 71dfb90a1353d-5c366104372mr1151283e0c.8.1785427641514;
        Thu, 30 Jul 2026 09:07:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9083232d126sm1501276d6.7.2026.07.30.09.07.20
        for <linux-um@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:07:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907b38aaad2so483766d6.1
        for <linux-um@lists.infradead.org>; Thu, 30 Jul 2026 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785427640; x=1786032440; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M89kfycQcHjbtSp4KrMwssDD/glAdwj31Koyk+WC8Sk=;
        b=MRhs054rpWyDks8+nw+o9NVIYQ0fpRwILWgVjm3bfS07eWiZIOvghm6LdOUHRh6LC5
         d6uyglUOI1+qTT0XStOqnUhGpjz97PXuLpp0hthxEaoBLy1PhgN54b9aegO10vhB6Mmy
         /yO814uhClalGG5zmd+EQo8Q3qMUrQU2eZ4hM=
X-Forwarded-Encrypted: i=1; AHgh+RpIiWiD1lh6+M1AmehYS/kNByJN9Uo42dFiBY1d0XtFy/sA98z0aARwjvZti0E5HYwEhXtJc8mE4g==@lists.infradead.org
X-Received: by 2002:ad4:5cc2:0:b0:907:40a4:e5e6 with SMTP id 6a1803df08f44-908348028b2mr31692206d6.52.1785427639773;
        Thu, 30 Jul 2026 09:07:19 -0700 (PDT)
X-Received: by 2002:ad4:5cc2:0:b0:907:40a4:e5e6 with SMTP id 6a1803df08f44-908348028b2mr31691236d6.52.1785427639004;
        Thu, 30 Jul 2026 09:07:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8b2csm20551916d6.23.2026.07.30.09.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:07:18 -0700 (PDT)
Message-ID: <15e85610-5596-43a1-8a88-9f9d74b9aaa5@broadcom.com>
Date: Thu, 30 Jul 2026 09:07:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
To: Greg KH <gregkh@linuxfoundation.org>
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
 <kunit-dev@googlegroups.com>, bcm-kernel-feedback-list@broadcom.com
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
 <2026073005-release-puzzling-8f07@gregkh>
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
In-Reply-To: <2026073005-release-puzzling-8f07@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_090723_830358_69B8B6D0 
X-CRM114-Status: GOOD (  16.47  )
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

On 7/30/26 05:38, Greg KH wrote:
> On Fri, Jul 24, 2026 at 02:41:10PM -0700, Florian Fainelli wrote:
>> This patch series addresses an issue we encountered on older Ubuntu
>> 20.04.6 LTS servers whereby running Kunit would not return to a prompt
>> and it would not be possible to Ctrl-C the running session either.
>>
>> Benjamin Berg (2):
>>    um: Set parent death signal for winch thread/process
>>    um: Set parent death signal for userspace process
>>
>> David Gow (1):
>>    kunit: tool: Terminate kernel under test on SIGINT
>>
>> Shuvam Pandey (1):
>>    kunit: tool: skip stty when stdin is not a tty
>>
>> Tiwei Bie (5):
>>    um: Add os_set_pdeathsig helper function
>>    um: Use os_set_pdeathsig helper in winch thread/process
>>    um: Set parent-death signal for ubd io thread/process
>>    um: Set parent-death signal for write_sigio thread/process
>>    um: Preserve errno within signal handler
>>
>>   arch/um/drivers/chan_user.c            |  2 ++
>>   arch/um/drivers/ubd_kern.c             |  1 +
>>   arch/um/include/shared/os.h            |  2 ++
>>   arch/um/os-Linux/process.c             |  6 ++++
>>   arch/um/os-Linux/sigio.c               |  1 +
>>   arch/um/os-Linux/signal.c              |  3 ++
>>   arch/um/os-Linux/skas/process.c        |  3 ++
>>   tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
>>   tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
>>   9 files changed, 88 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>>
> 
> Many of these are not in newer stable kernel versions.  So can you send
> patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
> missing patches for them, and then resend this 6.12.y series and we will
> be glad to queue this up then.

Oh yes, sure thing, let me submit against 7.1 and 6.18 as well.
-- 
Florian

