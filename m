Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 12/22] nvmem: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-13-git-send-email-richard@nod.at>
 <56A75653.8080902@linaro.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A780BE.9070903@nod.at>
Date: Tue, 26 Jan 2016 15:20:46 +0100
MIME-Version: 1.0
In-Reply-To: <56A75653.8080902@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Maxime Ripard <maxime.ripard@free-electrons.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 26.01.2016 um 12:19 schrieb Srinivas Kandagatla:
> 
> 
> On 25/01/16 22:24, Richard Weinberger wrote:
>> Not every arch has io memory.
>> So, unbreak the build by fixing the dependencies.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Am happy to pick this one, unless you have plans to get all these patches merged via a single tree.

Please pick it up. :)
I have hope that all maintainers monkey this patches.

Thanks,
//richard

